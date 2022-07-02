
#[macro_use]
extern crate actix_web;

use chimes_auth::ChimesAuthorization;
// #[macro_use]
// extern crate wechat;
#[macro_use]
use rbatis::Value;
use rbatis::rbatis::Rbatis;

#[macro_use]
extern crate lazy_static;

// use awc::Client;

use actix_web::http::{StatusCode, header};
use actix_web::{middleware, web, App, HttpRequest, HttpResponse, HttpServer, Result};
use actix_cors::Cors;


mod handler;
mod entity;
mod query;


mod utils;
use tokio::time;

use crate::utils::{AppConfig, WebServerConfig, ChimesUserAuthService};

trait AppEntryCollect {
    fn show_all_entry(self) -> Self;
}


impl <T> AppEntryCollect for App<T> {
    fn show_all_entry(self) -> Self {
        self
    }
}

#[get("/")]
async fn index_handler(_req: HttpRequest) -> Result<HttpResponse> {
    // response
    Ok(HttpResponse::build(StatusCode::OK)
        .content_type("text/html; charset=utf-8")
        .body("App is running."))
}


/// 应用启动入口
//#[actix_web::main]
#[tokio::main(flavor = "multi_thread", worker_threads = 10)]
async fn main() -> std::io::Result<()> {
    // 加载配置文件
    let conf_path = std::env::current_dir().unwrap().as_os_str().to_str().unwrap().to_owned() + "/conf/app.yml";
    log::info!("Current Path: {}", conf_path);
    std::env::set_var("RUST_LOG", "actix_server=info,actix_web=info");
    // env_logger::init();
    

    match fast_log::init(fast_log::config::Config::new().console()) {
        Ok (_) => {}
        Err(err) => {
            log::info!("An error occurred on the Logger initializing. {}", err);
        }
    };

    // // 加载配置信息
    let mut appconf = AppConfig::get().lock().unwrap();
    appconf.load_yaml(&conf_path.clone()); 
    let conf = appconf.clone();
    drop(appconf);

    let rb = utils::get_rbatis();

    // 启动web服务
    start_web_server(&conf.webserver_conf).await
}

/// web服务启动
async fn start_web_server(webconf: &WebServerConfig) -> std::io::Result<()> {
    // 设置服务器运行ip和端口信息
    let temp_path = webconf.upload_temp_path.clone();
    let ip = format!("{}:{}", "0.0.0.0", webconf.port.clone());
    log::info!("App is listening on {}.", ip.clone());
    // 启动一个web服务
    let cuas = ChimesUserAuthService { system_user: None };
    
    HttpServer::new(move || {
        App::new()
            .wrap(middleware::Logger::default())
            .wrap(ChimesAuthorization::new(cuas.clone())
                        .header_key(&"Authorization".to_string())
                        .allow(&"/api/v1/auth/login".to_string())
                        .allow(&"/api/v1/auth/code".to_string())
                        .allow(&"/api/v1/auth/logout".to_string())
            )
            .wrap(
                 // 设置允许跨域请求
                Cors::default()
                        .allowed_origin("http://localhost:8013")
                        .allowed_methods(vec!["GET", "POST", "PUT", "DELETE"])
                        .allowed_headers(vec![header::AUTHORIZATION, header::ACCEPT])
                        .allowed_header(header::CONTENT_TYPE)
                        .supports_credentials()
                        .max_age(3600),
            )
            .app_data(awmp::PartsConfig::default().with_file_limit(1000000000).with_temp_dir(temp_path.as_str()))
            .service(index_handler)
            .service(crate::handler::query_user_permission_paged)
            .service(crate::handler::query_user_permission_query)
            .service(crate::handler::user_save)
            .service(crate::handler::user_update)
            .service(crate::handler::user_delete)
            .service(crate::handler::user_search)
            .service(crate::handler::user_paged)
            .service(crate::handler::user_get)
            .service(crate::handler::menu_save)
            .service(crate::handler::menu_update)
            .service(crate::handler::menu_delete)
            .service(crate::handler::menu_delete_ids)
            .service(crate::handler::menu_search)
            .service(crate::handler::menu_children)
            .service(crate::handler::menu_paged)
            .service(crate::handler::menu_get)
            .service(crate::handler::menu_superior)
            .service(crate::handler::permission_save)
            .service(crate::handler::permission_update)
            .service(crate::handler::permission_delete)
            .service(crate::handler::permission_delete_ids)
            .service(crate::handler::permission_search)
            .service(crate::handler::permission_paged)
            .service(crate::handler::permission_get)
            .service(crate::handler::permission_children)
            .service(crate::handler::role_save)
            .service(crate::handler::role_update)
            .service(crate::handler::role_delete)
            .service(crate::handler::role_delete_ids)
            .service(crate::handler::role_search)
            .service(crate::handler::role_paged)
            .service(crate::handler::role_get)
            .service(crate::handler::role_level)
            .service(crate::handler::role_menus_rel_save)
            .service(crate::handler::role_menus_rel_remove_ids)
            .service(crate::handler::dept_save)
            .service(crate::handler::dept_update)
            .service(crate::handler::dept_delete)
            .service(crate::handler::dept_delete_ids)
            .service(crate::handler::dept_search)
            .service(crate::handler::dept_paged)
            .service(crate::handler::dept_get)
            .service(crate::handler::dept_tree)
            .service(crate::handler::dept_superior)
            .service(crate::handler::job_save)
            .service(crate::handler::job_update)
            .service(crate::handler::job_delete)
            .service(crate::handler::job_delete_ids)
            .service(crate::handler::job_search)
            .service(crate::handler::job_paged)
            .service(crate::handler::job_get)
            .service(crate::handler::dict_save)
            .service(crate::handler::dict_update)
            .service(crate::handler::dict_delete)
            .service(crate::handler::dict_delete_ids)
            .service(crate::handler::dict_search)
            .service(crate::handler::dict_paged)
            .service(crate::handler::dict_get)
            .service(crate::handler::dict_detail_save)
            .service(crate::handler::dict_detail_update)
            .service(crate::handler::dict_detail_delete)
            .service(crate::handler::dict_detail_delete_ids)
            .service(crate::handler::dict_detail_search)
            .service(crate::handler::dict_detail_paged)
            .service(crate::handler::dict_detail_get)
            .service(crate::handler::query_dict_detail_query)
            .service(crate::handler::query_dict_detail_paged)
            .service(crate::handler::logs_save)
            .service(crate::handler::logs_update)
            .service(crate::handler::logs_delete)
            .service(crate::handler::logs_delete_ids)
            .service(crate::handler::logs_search)
            .service(crate::handler::logs_paged)
            .service(crate::handler::logs_get)
            .service(crate::handler::user_roles_rel_load)
            .service(crate::handler::user_roles_rel_remove)
            .service(crate::handler::user_roles_rel_save)
            .service(crate::handler::auth_code)
            .service(crate::handler::auth_login)
            .service(crate::handler::auth_info)
            .service(crate::handler::auth_logout)
            .service(crate::handler::menu_build)
            .service(crate::handler::user_center_update)
            .service(crate::handler::user_center_update_email)
            .service(crate::handler::user_center_update_pwd)
            .service(crate::handler::user_center_update_avatar)
            .service(crate::handler::show_avatar)
            .show_all_entry()
    })
    .bind(ip)?
    .run()
    .await
}

