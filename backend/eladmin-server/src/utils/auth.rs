use crate::entity::ChimesUserInfo;
use crate::query::{QueryUserPermission, QueryUserPermissionParams};
use crate::utils::get_rbatis;
use actix_utils::future::{err, ok};
use actix_web::dev::Payload;
use actix_web::http::{header, StatusCode};
use actix_web::{dev, middleware, web, App, HttpRequest, HttpResponse, HttpServer, Result};
use actix_web::{FromRequest, HttpMessage};
use chimes_auth::{ApiResult, ChimesAuthService, ChimesAuthUser, ChimesAuthorization};
use futures::Future;
use serde::Deserialize;
use std::pin::Pin;
use std::rc::Rc;
use tokio::time;

use super::UserClaims;

#[derive(Clone, Default, Deserialize)]
pub struct SystemUser<ChimesUserInfo> {
    pub user: ChimesUserInfo,
}

impl ChimesAuthUser<SystemUser<ChimesUserInfo>> for SystemUser<ChimesUserInfo> {
    fn get_user_name(&self) -> String {
        self.user.username.clone().unwrap_or_default()
    }

    fn get_creditial(&self) -> String {
        self.user.phone.clone().unwrap_or_default()
    }

    fn to_detail(self) -> Self {
        self
    }
}

impl FromRequest for SystemUser<ChimesUserInfo> {
    type Error = actix_web::Error;
    type Future = actix_utils::future::Ready<Result<Self, Self::Error>>;

    fn from_request(req: &HttpRequest, payload: &mut Payload) -> Self::Future {
        match req.extensions().get::<SystemUser<ChimesUserInfo>>() {
            Some(user) => return ok(user.clone()),
            None => {
                log::info!("Not found the SystemUser");
                return err(actix_web::error::ErrorBadRequest("ups..."));
            }
        };
    }
}

#[derive(Clone)]
pub struct ChimesUserAuthService<SystemUser> {
    #[allow(unused)]
    pub system_user: Option<SystemUser>,
}

impl ChimesAuthService<SystemUser<ChimesUserInfo>>
    for ChimesUserAuthService<SystemUser<ChimesUserInfo>>
{
    type Future = Pin<Box<dyn Future<Output = Option<SystemUser<ChimesUserInfo>>>>>;

    fn permit(
        &self,
        ust: &Option<SystemUser<ChimesUserInfo>>,
        req_method: &String,
        url_pattern: &String,
    ) -> Self::Future {
        let up = url_pattern.clone();
        let mth = req_method.clone();
        let mtusr = ust.clone();
        let username = match ust {
            Some(st) => st.get_user_name(),
            None => "ANNOYMOUS".to_string(),
        };

        Box::pin(async move {
            let param = QueryUserPermissionParams {
                api_method: mth.clone(),
                api_pattern: up.clone(),
                username: username.clone(),
            };
            let rb = get_rbatis();
            match QueryUserPermission::query(rb, &param).await {
                Ok(rs) => {
                    if rs.len() > 0 {
                        let rp = rs[0].clone();
                        if rp.api_bypass == Some("ANONYMOUS".to_string())
                            || rp.api_bypass == Some("anonymous".to_string())
                        {
                            return Some(SystemUser::default());
                        } else if rs[0].api_bypass == Some("USER".to_string())
                            || rs[0].api_bypass == Some("user".to_string())
                        {
                            if mtusr.is_none() {
                                return None;
                            } else {
                                return mtusr;
                            }
                        } else {
                            let mut find_username = None;
                            for rx in rs.clone() {
                                if rx.username.is_some() {
                                    find_username = rx.username.clone();
                                    break;
                                }
                            }
                            if find_username.is_none() {
                                return None;
                            } else {
                                return mtusr;
                            }
                        }
                    } else {
                        if up.is_empty() {
                            return mtusr;
                        } else {
                            return None;
                        }
                    }
                }
                Err(err) => {
                    log::info!(
                        "Query the permission for user with an error: {}",
                        err.to_string()
                    );
                    return None;
                }
            };
        })
    }

    fn authenticate(&self, token: &String) -> Self::Future {
        let rb = get_rbatis();
        let tk = token.clone();
        Box::pin(async move {
            match UserClaims::decode(&tk) {
                Some(uc) => match ChimesUserInfo::load_username(rb, &uc.aud).await {
                    Ok(r) => match r {
                        Some(u) => Some(SystemUser { user: u }),
                        None => None,
                    },
                    Err(_) => None,
                },
                None => None,
            }
        })
    }

    fn nojwt_authenticate(&self, token: &String) -> Self::Future {
        todo!()
    }
}
