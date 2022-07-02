use std::collections::HashMap;
use std::iter::Map;

/**
 * Generate the file for chimes_menu_info.rs, 
 */

use crate::entity::{ChimesMenuInfo, ChimesUserInfo, ChimesMenuInfoValue};
use crate::query::{QueryUserMenus, QueryUserMenusParams};
use crate::utils::{get_rbatis, SystemUser, MenuTreeModel, MenuMetadata};
use actix_utils::future::{err, ok};
use actix_web::dev::Payload;
use chimes_auth::{ApiResult, ChimesAuthUser};
use actix_web::{web, HttpRequest, HttpResponse, Result, FromRequest, HttpMessage};
use rbatis::Page;

#[post("/api/v1/menu/save")]
pub async fn menu_save(req: web::Json<ChimesMenuInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let mut val = req.to_owned();
    match val.save(rb).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/menu/update")]
async fn menu_update(req: web::Json<ChimesMenuInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    match val.update_selective(rb).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/menu/delete")]
pub async fn menu_delete(req: web::Json<ChimesMenuInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let mut val = req.to_owned();
    match val.remove(rb).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}

#[post("/api/v1/menu/delete_ids")]
pub async fn menu_delete_ids(req: web::Json<Vec<i64>>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let ids = req.as_slice();
    match ChimesMenuInfo::remove_ids(rb, ids).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<u64>> = web::Json(ApiResult::ok(st));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<u64>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/menu/search")]
pub async fn menu_search(req: web::Json<ChimesMenuInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    match val.query_list(rb).await {
        Ok(st) => {
            let mtts:Vec<ChimesMenuInfoValue> = st.into_iter().map(|f| ChimesMenuInfoValue::from_entity_with(&f, true, &vec![])).collect();
            let ret: web::Json<ApiResult<Vec<ChimesMenuInfoValue>>> = web::Json(ApiResult::ok(mtts));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Vec<ChimesMenuInfoValue>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}

#[get("/api/v1/menu/children")]
pub async fn menu_children(_req: HttpRequest, query: web::Query<HashMap<String, i64>>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let mt = query.0;
    let oid = mt["pid"];
    match ChimesMenuInfo::query_children(rb, &oid).await {
        Ok(st) => {
            let mtts:Vec<i64> = st.into_iter().map(|f| f.menu_id.unwrap()).collect();
            let ret: web::Json<ApiResult<Vec<i64>>> = web::Json(ApiResult::ok(mtts));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Vec<i64>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}



#[post("/api/v1/menu/paged/{current}/{size}")]
pub async fn menu_paged(req: web::Json<ChimesMenuInfo>, v1: web::Path<(u64, u64)>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    let (current, size) = v1.into_inner();

    match val.query_paged(rb, current, size).await {
        Ok(st) => {
            let mtts:Vec<ChimesMenuInfoValue> = st.records.into_iter().map(|f| ChimesMenuInfoValue::from_entity_with(&f, true, &vec![])).collect();
            let mut newpage = Page::new_total(st.page_no, st.page_size, st.total);
            newpage.records = mtts;
            let ret: web::Json<ApiResult<Page<ChimesMenuInfoValue>>> = web::Json(ApiResult::ok(newpage));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Page<ChimesMenuInfoValue>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[get("/api/v1/menu/get/{id}")]
pub async fn menu_get(menu_id_req: web::Path<i64>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let menu_id = menu_id_req.to_owned();
    match ChimesMenuInfo::from_id(rb, &menu_id).await {
        Ok(st) => {
            match st {
                Some(tv) => {
                    let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::ok(tv));
                    Ok(HttpResponse::Ok().json(ret))
                }
                None => {
                    let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::error(5040, &"Not-Found".to_string()));
                    Ok(HttpResponse::Ok().json(ret))
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesMenuInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}



#[get("/api/v1/menus/build")]
pub async fn menu_build(su: SystemUser<ChimesUserInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    
    let param = QueryUserMenusParams{ username: su.get_user_name() };
    log::info!("Calc the menu for {}", param.username.clone());
    match QueryUserMenus::query(rb, &param).await {
        Ok(st) => {
            let mut trees = Vec::new();
            let mut treehs = HashMap::new();
            for mt in st.clone() {
                let mut item = MenuTreeModel::default();
                item.path = if mt.pid.is_none() {
                        "/".to_string() + mt.path.clone().unwrap_or_default().as_str()
                    } else {
                        mt.path.clone().unwrap_or_default()
                    };
                item.component = if !mt.i_frame.clone().unwrap_or_default() {
                    if mt.pid.is_none() {
                        match mt.component.clone() {
                            Some(tt) => {
                                if tt.is_empty() {
                                    "Layout".to_string()
                                } else {
                                    tt.clone()
                                }
                            }
                            None => {
                                "Layout".to_string()
                            }
                        }
                    } else {
                        if mt.r#type.unwrap_or_default() == 0 {
                            match mt.component.clone() {
                                Some(tt) => {
                                    if tt.is_empty() {
                                        "ParentView".to_string()
                                    } else {
                                        tt.clone()
                                    }
                                }
                                None => {
                                    "ParentView".to_string()
                                }
                            }
                        } else {
                            mt.component.clone().unwrap_or_default()
                        }
                    }
                } else {
                    "".to_string()
                };
                item.alwaysShow = if mt.pid.is_some() {
                    None
                } else {
                    Some(true)
                };
                item.redirect = if mt.pid.is_none() {
                        Some("noredirect".to_string())
                    } else {
                        None
                    };
                item.name = mt.name.clone().unwrap_or_default();
                item.iframe  = mt.i_frame.clone().unwrap_or_default();
                // item.cache = mt.cache.clone().unwrap_or_default();
                item.hidden = mt.hidden.clone().unwrap_or_default();
                item.children = vec![];
                item.id = mt.menu_id.clone().unwrap();
                item.pid = mt.pid.clone();

                item.meta = MenuMetadata {
                    noCache: !mt.cache.clone().unwrap_or_default(),
                    title: mt.title.clone(),
                    icon: mt.icon.clone()
                };

                treehs.insert(mt.menu_id.clone().unwrap_or_default(), item);
            }

            for mt in treehs.clone() {
                let t = mt.1.clone();
                let pid = t.pid;
                if pid.is_some() {
                    let nid = pid.unwrap();
                    match treehs.get(&nid) {
                        Some(tx) => {
                            let mut mutx = tx.clone();
                            mutx.children.push(t);
                            log::info!("Found parent node: {}, {}", mutx.id.clone(), mutx.meta.title.clone().unwrap_or_default());
                            treehs.insert(nid, mutx);
                        }
                        None => {

                        }
                    };
                }
            }

            for mt in treehs.clone() {
                if mt.1.clone().pid.is_none() {
                    trees.push(mt.1.clone());
                }
            }

            let ret = web::Json(ApiResult::ok(trees));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let trees = Vec::<MenuTreeModel>::new();
            let jp: ApiResult<Vec<MenuTreeModel>> = ApiResult::ok(trees);
            let ret: web::Json<ApiResult<Vec<MenuTreeModel>>> = web::Json(jp);
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


/**
 * 根据当前ID
 */
#[post("/api/v1/menu/superior")]
pub async fn menu_superior(pids: web::Json<Vec<i64>>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    // let query = req.query_string();
    // let dic = crate::utils::parse_query(query);
    // let val = crate::utils::get_hash_value(&dic, "pid");
    let valopt = Some(pids[0]);
    // let mut depts = vec![];
    match ChimesMenuInfo::query_all(rb).await {
        Ok(st) => {
            let valst = st.into_iter().map(|f| ChimesMenuInfoValue::from_entity(&f)).collect();
            let mtts:Vec<ChimesMenuInfoValue> = ChimesMenuInfoValue::build_tree(&valst);
            let ret: web::Json<ApiResult<Vec<ChimesMenuInfoValue>>> = web::Json(ApiResult::ok(mtts));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Vec<ChimesMenuInfoValue>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}
