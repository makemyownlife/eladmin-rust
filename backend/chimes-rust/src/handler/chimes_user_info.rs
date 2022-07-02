use std::fs::{File, OpenOptions};
use std::io::Read;
use std::path::{Path, PathBuf};
use std::io::Bytes;
use actix_web::body::{BodyStream, BoxBody, MessageBody};
use actix_web::http::header::{ContentDisposition, DispositionType, ExtendedValue, DispositionParam, Charset};
use awmp::Error;
use http::header::ValuesMut;
/**
 * Generate the file for chimes_user_info.rs, 
 */

use rbatis::{Page, snowflake};
use rsa::pkcs8::der::Encodable;
use url::quirks::username;
use crate::entity::{ChimesUserInfo, ChimesUserDetailInfo, UserUpdateInfoRequest, UserUpdateEmailRequest, UserUpdatePasswordRequest};
use crate::utils::{get_rbatis, SystemUser, rsa_decrypt_by_private_key, AppConfig};
use chimes_auth::{ApiResult, ChimesAuthUser, get_local_timestamp};
use actix_web::{web, HttpResponse, Result};

#[post("/api/v1/user/save")]
pub async fn user_save(req: web::Json<ChimesUserDetailInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let mut val = req.to_owned();
    match val.save(rb).await {
        Ok(_st) => {
            let ret: web::Json<ApiResult<ChimesUserDetailInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserDetailInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/user/update")]
async fn user_update(req: web::Json<ChimesUserDetailInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    match val.save(rb).await {
        Ok(_st) => {
            let ret: web::Json<ApiResult<ChimesUserDetailInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserDetailInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/user/delete")]
pub async fn user_delete(req: web::Json<ChimesUserInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let mut val = req.to_owned();
    match val.remove(rb).await {
        Ok(_st) => {
            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::ok(val));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/user/delete_ids")]
pub async fn user_delete_ids(req: web::Json<Vec<i64>>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let ids = req.as_slice();
    match ChimesUserInfo::remove_ids(rb, ids).await {
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


#[post("/api/v1/user/search")]
pub async fn user_search(req: web::Json<ChimesUserInfo>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    match val.query_list(rb).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<Vec<ChimesUserInfo>>> = web::Json(ApiResult::ok(st));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Vec<ChimesUserInfo>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/user/paged/{current}/{size}")]
pub async fn user_paged(req: web::Json<ChimesUserInfo>,path_param: web::Path<(u64, u64)>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    let (current, size) = path_param.into_inner();
    match val.query_paged(rb, current, size).await {
        Ok(st) => {
            let ret: web::Json<ApiResult<Page<ChimesUserInfo>>> = web::Json(ApiResult::ok(st));
            Ok(HttpResponse::Ok().json(ret))
        }
        Err(err) => {
            let ret: web::Json<ApiResult<Page<ChimesUserInfo>>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[get("/api/v1/user/get/{id}")]
pub async fn user_get(user_id_req: web::Path<i64>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let user_id = user_id_req.to_owned();
    log::info!("Try to load the user's detail by {}", user_id.clone());
    match ChimesUserDetailInfo::load(rb, &user_id).await {
        Ok(st) => {
            match st {
                Some(tv) => {
                    let ret: web::Json<ApiResult<ChimesUserDetailInfo>> = web::Json(ApiResult::ok(tv));
                    Ok(HttpResponse::Ok().json(ret))
                }
                None => {
                    let ret: web::Json<ApiResult<ChimesUserDetailInfo>> = web::Json(ApiResult::error(5040, &"Not-Found".to_string()));
                    Ok(HttpResponse::Ok().json(ret))
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserDetailInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/user/center/update/info")]
async fn user_center_update(su: SystemUser<ChimesUserInfo>, req: web::Json<UserUpdateInfoRequest>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    let username = su.get_user_name();
    match ChimesUserInfo::load_username(rb, &username).await {
        Ok(st) => {
            match st {
                Some(sval) => {
                    let mut valmut = sval.clone();
                    valmut.nick_name = Some(val.nick_name);
                    valmut.gender = Some(val.gender);
                    valmut.phone = Some(val.phone);
                    match valmut.update_selective(rb).await {
                        Ok(_) => {
                            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::ok(valmut));
                            Ok(HttpResponse::Ok().json(ret))
                        }
                        Err(err) => {
                            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
                            Ok(HttpResponse::Ok().json(ret))
                        }
                    }
                }
                None => {
                    let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5404, &"NOT-Found".to_string()));
                    Ok(HttpResponse::Ok().json(ret))                    
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/user/center/update/email")]
async fn user_center_update_email(su: SystemUser<ChimesUserInfo>, req: web::Json<UserUpdateEmailRequest>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    let username = su.get_user_name();
    match ChimesUserInfo::load_username(rb, &username).await {
        Ok(st) => {
            match st {
                Some(sval) => {
                    let mut valmut = sval.clone();
                    valmut.email = Some(val.email);
                    // should check the code and the password
                    // check the password
                    let decodepassword = rsa_decrypt_by_private_key(&val.password);
                    let mctdcdpasswd = rsa_decrypt_by_private_key(&sval.password.clone().unwrap_or_default());
                    if decodepassword == mctdcdpasswd {
                        match valmut.update_selective(rb).await {
                            Ok(_) => {
                                let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::ok(valmut));
                                Ok(HttpResponse::Ok().json(ret))
                            }
                            Err(err) => {
                                let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
                                Ok(HttpResponse::Ok().json(ret))
                            }
                        }
                    } else {
                        let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5051, &"Password-Error".to_string()));
                        Ok(HttpResponse::Ok().json(ret))
                    }
                }
                None => {
                    let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5404, &"NOT-Found".to_string()));
                    Ok(HttpResponse::Ok().json(ret))                    
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}

#[post("/api/v1/user/center/update/pwd")]
async fn user_center_update_pwd(su: SystemUser<ChimesUserInfo>, req: web::Json<UserUpdatePasswordRequest>) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let val = req.to_owned();
    let username = su.get_user_name();
    match ChimesUserInfo::load_username(rb, &username).await {
        Ok(st) => {
            match st {
                Some(sval) => {
                    let decodepassword = rsa_decrypt_by_private_key(&val.old_pwd);
                    let mctdcdpasswd = rsa_decrypt_by_private_key(&sval.password.clone().unwrap_or_default());

                    if decodepassword == mctdcdpasswd {
                        let mut valmut = sval.clone();
                        valmut.password = Some(val.new_pwd);
                        // should check the code and the password
                        match valmut.update_selective(rb).await {
                            Ok(_) => {
                                let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::ok(valmut));
                                Ok(HttpResponse::Ok().json(ret))
                            }
                            Err(err) => {
                                let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
                                Ok(HttpResponse::Ok().json(ret))
                            }
                        }
                    } else {
                        let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5051, &"Old password error".to_string()));
                        Ok(HttpResponse::Ok().json(ret))
                    }
                }
                None => {
                    let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5404, &"NOT-Found".to_string()));
                    Ok(HttpResponse::Ok().json(ret))                    
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[post("/api/v1/user/center/update/avatar")]
async fn user_center_update_avatar(su: SystemUser<ChimesUserInfo>, mut parts: awmp::Parts) -> Result<HttpResponse> {
    let rb = get_rbatis();
    let qs = parts.texts.to_query_string();
    let username = su.get_user_name();
    let store_path = AppConfig::get().lock().unwrap().webserver_conf.upload_store_path.clone();

    log::info!("The request {},, {}", qs, username.clone());
    

    let file_parts = parts
        .files
        .take("avatar")
        .pop()
        .and_then(|f| {
            let stamp = get_local_timestamp();
            let fext = Path::new(f.sanitized_file_name()).extension().unwrap().to_str().unwrap_or_default();
            let fcp = format!("{}/{:x}_{}.{}", store_path, stamp, snowflake::new_snowflake_id(), fext);
            f.into_inner().persist(fcp.clone()).map(|_| fcp.clone()).map_err(Error::TempFilePersistError).ok()
        })
        .map(|f| format!("{}", f))
        .unwrap_or_default();

    log::info!("Stored file: {}", file_parts.clone());

    let filepathfull = file_parts.clone().clone();
    let fextion = Path::new(&filepathfull).file_name().unwrap().to_str().unwrap_or_default();

    match ChimesUserInfo::load_username(rb, &username).await {
        Ok(st) => {
            match st {
                Some(sval) => {
                    let mut valmut = sval.clone();
                    valmut.avatar_path = Some(file_parts.clone());
                    valmut.avatar_name = Some(fextion.to_string());
                    // should check the code and the password
                    match valmut.update_selective(rb).await {
                        Ok(_) => {
                            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::ok(valmut));
                            Ok(HttpResponse::Ok().json(ret))
                        }
                        Err(err) => {
                            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
                            Ok(HttpResponse::Ok().json(ret))
                        }
                    }
                }
                None => {
                    let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5404, &"NOT-Found".to_string()));
                    Ok(HttpResponse::Ok().json(ret))                    
                }
            }
        }
        Err(err) => {
            let ret: web::Json<ApiResult<ChimesUserInfo>> = web::Json(ApiResult::error(5010, &err.to_string()));
            Ok(HttpResponse::Ok().json(ret))
        }
    }
}


#[get("/api/v1/avatar/{filename}")]
async fn show_avatar(filename: web::Path<String>) -> Result<HttpResponse> {
    // let rb = get_rbatis();
    let qs = filename.clone().to_string();
    let store_path = AppConfig::get().lock().unwrap().webserver_conf.upload_store_path.clone();

    let fullpath = format!("{}/{}", store_path, qs);

    let filepath = Path::new(&fullpath.clone());
    log::info!("Filepath: {}", fullpath.clone());

    match OpenOptions::new().read(true).open(fullpath) {
        Ok(fl) => {
            let mut mutfile = fl;
            let cd1 = ContentDisposition {
                disposition: DispositionType::Inline,
                parameters: vec![DispositionParam::FilenameExt(ExtendedValue {
                    charset: Charset::Iso_8859_1, // The character set for the bytes of the filename
                    language_tag: None, // The optional language tag (see `language-tag` crate)
                    value: qs.to_vec().ok().unwrap(), // the actual bytes of the filename
                })],
            };
            let mut buf = vec![];
            match mutfile.read_to_end(&mut buf) {
                Ok(us) => {
                    Ok(HttpResponse::Ok().insert_header((actix_web::http::header::CONTENT_DISPOSITION, cd1)).body(buf))
                },
                Err(err) => {
                    Ok(HttpResponse::NotFound().body("Not found"))
                }
            }
        }
        Err(_) => {
            Ok(HttpResponse::NotFound().body("Not found"))
        }
    }
}

