
use std::collections::HashMap;
use std::fmt::{Debug};
use std::iter::Map;
use std::time::{SystemTime};
use std::fs::File;
use std::mem::MaybeUninit;
use std::sync::{Mutex, Once};
use jsonwebtoken::{Header, EncodingKey, DecodingKey};
use rand::thread_rng;
use rbatis::rbatis::{Rbatis};
use rsa::pkcs1::{DecodeRsaPrivateKey, DecodeRsaPublicKey};
use rsa::{RsaPrivateKey, PaddingScheme, RsaPublicKey, PublicKey};
use rsa::pkcs8::{DecodePrivateKey, DecodePublicKey};
// use serde_derive::{Deserialize, Serialize};
use serde::{Deserialize, Deserializer, Serialize};
use chrono::offset::Local;
use chrono::DateTime;
use super::AppConfig;

lazy_static!{
  pub static ref APP_DATA: Mutex<HashMap<String, String>> = Mutex::new(HashMap::new());
}

#[allow(dead_code)]
pub fn global_app_data_insert(key: &String, val: &String) {
  //let mut hs = APP_DATA.lock().as_mut().unwrap().to_owned();
  //hs.insert(key.to_string(), val.to_string());
  //log::info!("Size Of Hash: {}", hs.len());
  APP_DATA.lock().as_mut().unwrap().insert(key.to_string(), val.to_string());
}

#[allow(dead_code)]
pub fn global_app_data_remove(key: &String) {
  //let mut hs = APP_DATA.lock().as_mut().unwrap().to_owned();
  //hs.insert(key.to_string(), val.to_string());
  //log::info!("Size Of Hash: {}", hs.len());
  APP_DATA.lock().as_mut().unwrap().remove(key);
}


#[allow(dead_code)]
pub fn global_app_data_get(key: &String) -> Option<String> {
  let dt = APP_DATA.lock().unwrap().to_owned();
  log::info!("Size Of Hash: {}", dt.len());
  dt.get(key).cloned()
}

#[allow(dead_code)]
pub fn rsa_decrypt_by_private_key(token: &String) -> Option<String> {
  let private_key = AppConfig::get().lock().unwrap().to_owned().webserver_conf.rsa_password_private_key;
  
  let bs = match base64::decode(private_key) {
      Ok(rs) => {
          rs
      }
      Err(_) => {
          vec![]
      }
  };

  
  let priv_key = match RsaPrivateKey::from_pkcs8_der(&bs) {
      Ok(r) => {
          Some(r)
      }
      Err(err) => {
          log::info!("Decode the Private Key with an error {}", err);
          None
      }
  };

  match priv_key {
      Some(pkey) => {
          let basedecode = match base64::decode(token) {
              Ok(ts) => ts,
              Err(_) => vec![]
          };
          let dcode = pkey.decrypt(PaddingScheme::PKCS1v15Encrypt, &basedecode);
          match dcode {
              Ok(rs) => {
                  match String::from_utf8(rs) {
                      Ok(text) => {
                          Some(text)
                      }
                      Err(err) => {
                          log::info!("Convert to utf8 with an error {}", err);
                          None
                      }
                  }
              }
              Err(err) => {
                  log::info!("Decode the token with an error {}", err.to_string());
                  None
              }
          }
      }
      None => {
          None
      }
  }

}


#[allow(dead_code)]
pub fn rsa_encrypt_by_public_key(token: &String) -> Option<String> {
  let public_key = AppConfig::get().lock().unwrap().to_owned().webserver_conf.rsa_password_public_key;
  
  let bs = match base64::decode(public_key) {
      Ok(rs) => {
          rs
      }
      Err(_) => {
          vec![]
      }
  };

  let pub_key = match RsaPublicKey::from_public_key_der(&bs) {
      Ok(r) => {
          Some(r)
      }
      Err(err) => {
          log::info!("Decode the Private Key with an error {}", err);
          None
      }
  };

  match pub_key {
      Some(pkey) => {
          let mut rng = thread_rng();
          let encoded = pkey.encrypt(&mut rng, PaddingScheme::PKCS1v15Encrypt, &token.as_bytes());
          match encoded {
              Ok(rs) => {
                let encodebase = base64::encode(rs);
                Some(encodebase)
              }
              Err(err) => {
                  log::info!("Decode the token with an error {}", err.to_string());
                  None
              }
          }
      }
      None => {
          None
      }
  }

}


#[derive(Deserialize)]
#[serde(untagged)] // 枚举类型的无标签方式
enum StrOrU64 {
    String(String),
    U64(u64),
}

#[derive(Deserialize)]
#[serde(untagged)] // 枚举类型的无标签方式
enum StrOrI64 {
    String(String),
    I64(i64),
}

#[derive(Deserialize)]
#[serde(untagged)] // 枚举类型的无标签方式
enum StrOrF64 {
    String(String),
    F64(f64),
}


#[derive(Deserialize)]
#[serde(untagged)] // 枚举类型的无标签方式
enum StrOrF32 {
    String(String),
    F32(f32),
}

#[derive(Deserialize)]
#[serde(untagged)] // 枚举类型的无标签方式
enum StrOrBool {
    String(String),
    I64(i64),
    Bool(bool),
}

#[allow(dead_code)]
pub fn u64_from_str<'de, D>(deserializer: D) -> Result<u64, D::Error>
where
    D: Deserializer<'de>,
{
    Ok(match StrOrU64::deserialize(deserializer)? {
        StrOrU64::String(v) => v.parse().unwrap_or_default(),
        StrOrU64::U64(v) => v,
    })
}

#[allow(dead_code)]
pub fn i64_from_str<'de, D>(deserializer: D) -> Result<Option<i64>, D::Error>
where
    D: Deserializer<'de>,
{
    Ok(match StrOrI64::deserialize(deserializer)? {
        StrOrI64::String(v) => match v.parse::<i64>() {
            Ok(st) => {
                Some(st)
            }
            Err(_) => {
                None
            }
        },
        StrOrI64::I64(v) => Some(v),
    })
}

#[allow(dead_code)]
pub fn i32_from_str<'de, D>(deserializer: D) -> Result<Option<i32>, D::Error>
where
    D: Deserializer<'de>,
{
    Ok(match StrOrI64::deserialize(deserializer)? {
        StrOrI64::String(v) => match v.parse::<i64>() {
            Ok(st) => {
                Some(st as i32)
            }
            Err(_) => {
                None
            }
        },
        StrOrI64::I64(v) => Some(v as i32),
    })
}

#[allow(dead_code)]
pub fn f64_from_str<'de, D>(deserializer: D) -> Result<f64, D::Error>
where
    D: Deserializer<'de>,
{
    Ok(match StrOrF64::deserialize(deserializer)? {
        StrOrF64::String(v) => v.parse().unwrap_or_default(),
        StrOrF64::F64(v) => v,
    })
}

#[allow(dead_code)]
pub fn f32_from_str<'de, D>(deserializer: D) -> Result<f32, D::Error>
where
    D: Deserializer<'de>,
{
    Ok(match StrOrF32::deserialize(deserializer)? {
        StrOrF32::String(v) => v.parse().unwrap_or_default(),
        StrOrF32::F32(v) => v,
    })
}

#[allow(dead_code)]
pub fn bool_from_str<'de, D>(deserializer: D) -> Result<Option<bool>, D::Error>
where
    D: Deserializer<'de>,
{
    Ok(match StrOrBool::deserialize(deserializer) {
        Ok(t) => {
            match t {
                StrOrBool::String(v) => {
                    match v.parse::<bool>() {
                        Ok(tf) => Some(tf),
                        Err(err) => {
                            log::info!("Parse erroor {}", err);
                            None
                        }
                    }
                },
                StrOrBool::I64(v) => Some(v != 0i64),
                StrOrBool::Bool(v) => Some(v),
            }
        }
        Err(err) => {
            log::info!("Deserializer erroor {}", err);
            None
        }
    })
}
