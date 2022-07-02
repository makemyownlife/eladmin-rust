use std::collections::HashMap;

/**
 * Generate the file for query_user.rs, 
 */

use crate::{utils::{get_rbatis, generate_rand_string, global_app_data_insert, global_app_data_get, UserClaims, get_local_timestamp, global_app_data_remove, rsa_decrypt_by_private_key, rsa_encrypt_by_public_key, SystemUser}, entity::{ChimesUserInfo, ChimesUserDetailInfo}};
use actix_web::{web, HttpRequest, HttpResponse, Result};
use chimes_auth::{ApiResult, ChimesAuthUser};
use rbatis::Page;
use serde::{Deserialize, Serialize};


#[get("/api/v1/auth/code")]
pub async fn auth_code(req: HttpRequest) -> Result<HttpResponse> {
    let png = captcha::Captcha::new()
            .add_chars(5)
            .apply_filter(captcha::filters::Noise::new(0.4))
            .view(180, 80)
            .as_tuple();
    match png {
        Some(st) => {
            let basestr = base64::encode(st.1);
            let keyid = generate_rand_string(18);
            global_app_data_insert(&keyid.clone(), &st.0);
            let ret: web::Json<ApiResult<String>> = web::Json(ApiResult::new( 200, &keyid, basestr, get_local_timestamp()));
            Ok(HttpResponse::Ok().json(ret))
        }
        None => {
            let ret: web::Json<ApiResult<String>> = web::Json(ApiResult::error(5010, &"FAILED".to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct UserAuth {
    pub username: String,
    pub password: String,
    pub verify_code_key: String,
    pub verify_code: String
}

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct UserResponse {
    pub token: String,
    pub username: String,
    pub authorities: Vec<HashMap<String, String>>,
    pub detail: Option<ChimesUserDetailInfo>,
    pub roles: Vec<String>,
}

#[post("/api/v1/auth/login")]
pub async fn auth_login(req: web::Json<UserAuth>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let auth = req.to_owned();

    let codeval = global_app_data_get(&auth.verify_code_key);
    if codeval.is_none() {
        let ret: web::Json<ApiResult<String>> = web::Json(ApiResult::error(5301, &"VERIFY-CODE-KEY".to_string()));
        return Ok(HttpResponse::Ok().json(ret));
    }

    global_app_data_remove(&auth.verify_code_key);

    if codeval.unwrap().to_lowercase() != auth.verify_code.to_lowercase() {
        let ret: web::Json<ApiResult<String>> = web::Json(ApiResult::error(5301, &"VERIFY-CODE".to_string()));
        return Ok(HttpResponse::Ok().json(ret));
    }

    

    match ChimesUserDetailInfo::load_username(rb, &auth.username).await {
        Ok(st) => {
            
            match st {
                Some(us) => {
                    let decodepassword = rsa_decrypt_by_private_key(&auth.password);
                    if decodepassword.is_some() {
                        let pwd = rsa_encrypt_by_public_key(&decodepassword.clone().unwrap_or_default());
                        log::info!("Re-encrypt password: {}", pwd.unwrap_or_default());
                    }
                    let md5password = match us.password.clone() {
                        Some(t) => {
                            // let digist = md5::compute(t);
                            rsa_decrypt_by_private_key(&t)
                            // Some(format!("{:x}", digist))
                        }
                        None => {
                            None
                        }
                    };

                    if decodepassword != md5password { // may need to encode the password
                        let ret: web::Json<ApiResult<String>> = web::Json(ApiResult::error(5302, &format!("PASSWORD")));
                        Ok(HttpResponse::Ok().json(ret))
                    } else {
                        let claim = UserClaims {
                            aud: us.username.clone().unwrap(),
                            sub: format!("{}", us.user_id.unwrap_or_default()),
                            exp: get_local_timestamp() as usize,
                        };
                        match claim.encode() {
                            Some(token) => {
                                let mut usc = us.clone();
                                usc.password = None;
                                let username = usc.username.clone().unwrap();
                                let mut hs = HashMap::new();
                                hs.insert("authority".to_string(), username.clone());
                                let mut roles = vec![];
                                for rl in usc.roles.clone() {
                                    roles.push(rl.name.unwrap_or_default());
                                }
                                let up = UserResponse {
                                    username: username.clone(),
                                    authorities: vec![hs],
                                    token: token,
                                    roles: roles,
                                    detail: Some(usc)
                                };
                                
                                let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::ok(up));
                                Ok(HttpResponse::Ok().json(ret))
                            }
                            None => {
                                let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::error(5404, &format!("TOKEN was not generated.")));
                                Ok(HttpResponse::Ok().json(ret))
                            }
                        }
                    }
                }
                None => {
                    let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::error(5404, &format!("{} is not found.", auth.username)));
                    Ok(HttpResponse::Ok().json(ret))
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}

#[post("/api/v1/auth/logout")]
pub async fn auth_logout(_req: web::Json<UserAuth>) -> Result<HttpResponse> {
    let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::error(200, &"OK".to_string()));
    Ok(HttpResponse::Ok().json(ret))
}

#[get("/api/v1/auth/info")]
pub async fn auth_info(su: SystemUser<ChimesUserInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let param = su.get_user_name();
    
    match ChimesUserDetailInfo::load_username(rb, &param).await {
        Ok(st) => {
            match st {
                Some(us) => {
                    let mut mutus = us;
                    mutus.password = None;

                    let claim = UserClaims {
                        aud: mutus.username.clone().unwrap(),
                        sub: format!("{}", mutus.user_id.unwrap_or_default()),
                        exp: get_local_timestamp() as usize,
                    };
                    match claim.encode() {
                        Some(token) => {
                            let username = mutus.username.clone().unwrap();
                            let mut hs = HashMap::new();
                            hs.insert("authority".to_string(), username.clone());

                            let mut roles = vec![];
                            for rl in mutus.roles.clone() {
                                roles.push(rl.name.unwrap_or_default());
                            }

                            let up = UserResponse {
                                username: username.clone(),
                                authorities: vec![hs],
                                token: token,
                                roles: roles,
                                detail: Some(mutus)
                            };
                            let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::ok(up));
                            Ok(HttpResponse::Ok().json(ret))
                        }
                        None => {
                            let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::error(5404, &format!("TOKEN was not generated.")));
                            Ok(HttpResponse::Ok().json(ret))
                        }
                    }
                }
                None => {
                    let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::error(5404, &format!("{} is not found.", param)));
                    Ok(HttpResponse::Ok().json(ret))
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<UserResponse>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}
