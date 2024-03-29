
use std::fmt::{Debug};
use std::time::{SystemTime};
use std::fs::File;
use std::mem::MaybeUninit;
use std::sync::{Mutex, Once};
use rbatis::rbatis::{Rbatis};
use serde_derive::{Deserialize, Serialize};
use chrono::offset::Local;
use chrono::DateTime;
use jsonwebtoken::{EncodingKey, DecodingKey, Header};
use yaml_rust::Yaml;
use actix_web::{web, HttpRequest};
use std::collections::HashMap;

mod global_data;
pub use global_data::*;

mod auth;
pub use auth::*;

mod app;
pub use app::*;

#[allow(dead_code)]
pub fn num_to_string (n:i64) -> String {
    let base_codec = ['A','B','C','D','E','F','G','H','J','K','L','M','N','O', 'P','Q','R','S','T','U','V','W','X','Y','Z','2','3','4','5','7','8','9'];
    let len = base_codec.len() as i64;
    let mut t = n;
    let mut result = "".to_string();
    while t > 0 {
        let idx = (t % len as i64) as usize;
        let ch = base_codec[idx];
        t = t / len;
        result.insert(0, ch);
    }
    result
}

#[allow(dead_code)]
pub fn f32_to_decimal(f: f32) -> Option<rbatis::Decimal> {
    match rbatis::Decimal::from_str(format!("{:.2}", f).as_str()) {
        Ok(r) => {
            Some(r)
        }
        Err(_) => {
            None
        }
    }
}

#[allow(dead_code)]
pub fn decimal_to_f32(dc: Option<rbatis::Decimal>) -> f32 {
    match dc {
        Some(r) => {
            match r.to_string().parse::<f32>() {
                Ok(t) => {
                    t
                }
                Err(_) => {
                    0f32
                }
            }
        }
        None => {
            0f32
        }
    }
}

#[allow(dead_code)]
pub fn make_decimal_negative(dc: Option<rbatis::Decimal>) -> Option<rbatis::Decimal> {
    match dc {
        Some(r) => {
            match r.to_string().parse::<f32>() {
                Ok(t) => {
                    f32_to_decimal(-t)
                }
                Err(_) => {
                    f32_to_decimal(0f32)
                }
            }
        }
        None => {
            f32_to_decimal(0f32)
        }
    }
}

#[allow(dead_code)]
pub fn generate_rand_string (len: usize) -> String {
    let mut retkey = "".to_string();

    while retkey.len() < len {
        let rng = rand::random::<u16>();
        let key = num_to_string(rng as i64);
        retkey = retkey + key.as_str();
    }

    retkey.chars().take(len).collect()
}

#[allow(dead_code)]
pub fn get_local_timestamp() -> u64 {
    let now = SystemTime::now();
    let date:DateTime<Local> = now.into();
    date.timestamp_millis() as u64
}

#[allow(dead_code)]
pub fn parse_query(query_string: &str) -> HashMap<String, String> {
    if query_string.is_empty() {
        return HashMap::new();
    }
    let q_a: Vec<&str> = query_string.split("&").collect();
    let mut res: HashMap<String, String> = HashMap::new();
    use percent_encoding::percent_decode;
    for s in q_a {
        // let ss: &str = s;
        let kv: Vec<&str> = s.split("=").collect();
        let kvalue = percent_decode(kv[1].as_bytes())
        .decode_utf8()
        .unwrap();
        res.insert(kv[0].to_string(), kvalue.to_string());
    }
    res
}

#[allow(dead_code)]
pub fn get_hash_value(query_params: &HashMap<String, String>, key: &str) -> String {
    match query_params.get(key) {
        Some(val) => val.clone(),
        None => "".to_owned(),
    }
}

lazy_static!{
    pub static ref RB: Rbatis = {
      let rb = Rbatis::new();
      return rb;
    };
}


pub fn get_rbatis() -> &'static Rbatis {
    // 使用MaybeUninit延迟初始化
    static mut STATIC_RB: MaybeUninit<Rbatis> = MaybeUninit::uninit();
    // Once带锁保证只进行一次初始化
    static ONCE: Once = Once::new();

    ONCE.call_once(|| unsafe {
        // CONF = 1u64;
        let conf = AppConfig::get().lock().unwrap().to_owned();
        let url = conf.db_conf.url.clone();
        
        async_std::task::block_on(async {
            let rb = Rbatis::new();
            match rb.link(&url).await {
                Ok(_) => {
                    log::info!("Database was connected. Rbatis was initialized successfully.");
                }
                Err(err) => {
                    log::info!("Error: {}", err);
                }
            };
            STATIC_RB.as_mut_ptr().write(rb);
        });
    });
    unsafe { &*STATIC_RB.as_ptr() }
}


#[derive(Debug, Clone, Default)]
pub struct AppConfig {
    pub db_conf: DatabaseConfig,
    pub webserver_conf: WebServerConfig,
}

#[derive(Debug, Clone, Default)]
pub struct WebServerConfig {
    pub port: i64,
    pub rsa_key: String,
    pub rsa_cert: String,
    pub rsa_password_private_key: String,
    pub rsa_password_public_key: String,
    pub upload_store_path: String,
    pub upload_temp_path: String,
    pub access_url_prefix: String,
}


#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct DatabaseConfig {
    pub url: String,
}

impl AppConfig {
    pub fn get() -> &'static Mutex<AppConfig> {
      // 使用MaybeUninit延迟初始化
      static mut CONF: MaybeUninit<Mutex<AppConfig>> = MaybeUninit::uninit();
      // Once带锁保证只进行一次初始化
      static ONCE: Once = Once::new();
  
      ONCE.call_once(|| unsafe {
          CONF.as_mut_ptr().write(Mutex::new(AppConfig {
            db_conf: DatabaseConfig { url: "".to_string() },
            webserver_conf: WebServerConfig { port: 10089i64, rsa_cert: String::new(), rsa_key: String::new(), rsa_password_private_key: String::new(), rsa_password_public_key: String::new(), upload_store_path: String::new(), upload_temp_path: String::new(), access_url_prefix: String::new() },
          }));
      });
      unsafe { &*CONF.as_ptr() }
    }
  
  
    pub fn load_yaml(&mut self, conf_path: &str) {
      use yaml_rust::yaml;
      // open file
      let mut f = match File::open(conf_path) {
          Ok(f) => f,
          Err(_) => {
              return
          }
      };
      let mut s = String::new();
      use std::io::Read;
      
      match f.read_to_string(&mut s) {
        Ok(_) => {}
        Err(_) => {}
      };
      // f.read_to_string(&mut s).unwrap(); // read file content to s
      // load string to yaml loader
      let docs = yaml::YamlLoader::load_from_str(&s).unwrap();
      // get first yaml hash doc
      // get server value
      // let server = yaml_doc["weapp"].clone();
      let doc = &docs[0];
      let db = &doc["database"];
      let web = &doc["webserver"];
      let dbconf = DatabaseConfig {
        url: if let Some(s) = db["url"].as_str() {
            s.to_owned()
        } else {
            "".to_owned()
        }
      };
      let webconf = WebServerConfig {
        port: if let Some(s) = web["port"].as_i64() {
            s.to_owned()
        } else {
            10089i64
        },
        rsa_key: if let Some(s) = web["rsa_key"].as_str() {
            s.to_owned()
        } else {
            String::new()
        },
        rsa_cert: if let Some(s) = web["rsa_cert"].as_str() {
            s.to_owned()
        } else {
            String::new()
        },
        rsa_password_private_key: if let Some(s) = web["rsa_password_private_key"].as_str() {
            s.to_owned()
        } else {
            String::new()
        },
        rsa_password_public_key: if let Some(s) = web["rsa_password_public_key"].as_str() {
            s.to_owned()
        } else {
            String::new()
        },
        upload_store_path: if let Some(s) = web["upload-store-path"].as_str() {
            s.to_owned()
        } else {
            String::new()
        },
        upload_temp_path: if let Some(s) = web["upload-temp-path"].as_str() {
            s.to_owned()
        } else {
            String::new()
        },
        access_url_prefix: if let Some(s) = web["access-url-prefix"].as_str() {
            s.to_owned()
        } else {
            String::new()
        }
      };
      
      self.db_conf = dbconf;
      self.webserver_conf = webconf;
    }
  }



#[derive(Debug, Serialize, Deserialize)]
pub struct UserClaims {
    pub aud: String,
    pub sub: String,
    pub exp: usize,
}

impl UserClaims {
    
    pub fn encode(&self) -> Option<String> {
        let conf = AppConfig::get().lock().unwrap().to_owned();
        
        match jsonwebtoken::encode(&Header::default(), &self, &EncodingKey::from_secret(conf.webserver_conf.rsa_cert.as_bytes())) {
            Ok(t) => Some(t),
            Err(_) => None
        }
    }

    pub fn decode(token: &String) -> Option<Self> {
        let conf = AppConfig::get().lock().unwrap().to_owned();
        let mut validation = jsonwebtoken::Validation::new(jsonwebtoken::Algorithm::HS256);
        match jsonwebtoken::decode::<UserClaims>(&token, &DecodingKey::from_secret(conf.webserver_conf.rsa_cert.as_bytes()), &validation) {
            Ok(c) => {
                Some(c.claims)
            },
            Err(err) => {
                match *err.kind() {
                    jsonwebtoken::errors::ErrorKind::InvalidToken => log::error!("Token is invalid"), // Example on how to handle a specific error
                    jsonwebtoken::errors::ErrorKind::InvalidIssuer => log::error!("Issuer is invalid"), // Example on how to handle a specific error
                    _ => log::error!("Some other errors"),
                };

                None
            }
        }
    }
}

fn field_is_none<T>(t: &Option<T>) -> bool {
    t.is_none()
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct MenuMetadata {
    pub icon: Option<String>,
    pub noCache: bool,
    pub title: Option<String>
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct MenuTreeModel {
    #[serde(skip_serializing_if = "field_is_none")]
    pub alwaysShow: Option<bool>,
    pub id: i64,
    pub meta: MenuMetadata,
    pub name: String,
    pub path: String,
    pub hidden: bool,
    pub iframe: bool,
    pub permission: String,
    pub component: String,
    #[serde(skip_serializing_if = "field_is_none")]
    pub pid: Option<i64>,
    pub children: Vec<MenuTreeModel>,
    #[serde(skip_serializing_if = "field_is_none")]
    pub redirect: Option<String>
}



