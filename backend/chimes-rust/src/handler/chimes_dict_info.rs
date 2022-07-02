/**
 * Generate the file for chimes_dict_info.rs, 
 */

use rbatis::Page;
use crate::entity::ChimesDictInfo;
use crate::utils::get_rbatis;
use chimes_auth::ApiResult;
use actix_web::{web, HttpResponse, Result};

#[post("/api/v1/dict/save")]
pub async fn dict_save(req: web::Json<ChimesDictInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let mut val = req.to_owned();
    match val.save(rb).await {
        Ok(_st) => {
            let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/dict/update")]
async fn dict_update(req: web::Json<ChimesDictInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    match val.update_selective(rb).await {
        Ok(_st) => {
            let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/dict/delete")]
pub async fn dict_delete(req: web::Json<ChimesDictInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let mut val = req.to_owned();
    match val.remove(rb).await {
        Ok(_st) => {
            let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}

#[post("/api/v1/dict/delete_ids")]
pub async fn dict_delete_ids(req: web::Json<Vec<i64>>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let ids = req.as_slice();
    match ChimesDictInfo::remove_ids(rb, ids).await {
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


#[post("/api/v1/dict/search")]
pub async fn dict_search(req: web::Json<ChimesDictInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    match val.query_list(rb).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<Vec<ChimesDictInfo>>> = web::Json(ApiResult::ok(st));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Vec<ChimesDictInfo>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/dict/paged/{current}/{size}")]
pub async fn dict_paged(req: web::Json<ChimesDictInfo>,path_param: web::Path<(u64, u64)>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    let (current, size) = path_param.into_inner();
    match val.query_paged(rb, current, size).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<Page<ChimesDictInfo>>> = web::Json(ApiResult::ok(st));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Page<ChimesDictInfo>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[get("/api/v1/dict/get/{id}")]
pub async fn dict_get(dict_id_req: web::Path<i64>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let dict_id = dict_id_req.to_owned();
    match ChimesDictInfo::from_id(rb, &dict_id).await {
        Ok(st) => {
            match st {
                Some(tv) => {
                    let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::ok(tv));
                    Ok(HttpResponse::Ok().json(ret))
                }
                None => {
                    let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::error(5040, &"Not-Found".to_string()));
                    Ok(HttpResponse::Ok().json(ret))
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesDictInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


