/**
 * Generate the file for chimes_user_info.rs, 
 */

use std::fmt::{Debug};
use serde_derive::{Deserialize, Serialize};
use rbatis::crud_table;
use rbatis::rbatis::{Rbatis};
use rbatis::error::Error;
use rbatis::Page;
use rbatis::PageRequest;
use rbson::Bson;
use rbatis::crud::{CRUD, Skip};
use crate::utils::bool_from_str;

#[crud_table(table_name:"chimes_user"|table_columns:"user_id,dept_id,username,nick_name,gender,phone,email,avatar_name,avatar_path,password,is_admin,enabled,create_by,update_by,pwd_reset_time,create_time,update_time")]
#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct ChimesUserInfo {
    pub user_id: Option<i64>,
    pub dept_id: Option<i64>,
    pub username: Option<String>,
    pub nick_name: Option<String>,
    pub gender: Option<String>,
    pub phone: Option<String>,
    pub email: Option<String>,
    pub avatar_name: Option<String>,
    pub avatar_path: Option<String>,
    pub password: Option<String>,
    #[serde(default)]
    #[serde(deserialize_with="bool_from_str")]
    pub is_admin: Option<bool>,
    pub enabled: Option<i32>,
    pub create_by: Option<String>,
    pub update_by: Option<String>,
    pub pwd_reset_time: Option<rbatis::DateTimeNative>,
    pub create_time: Option<rbatis::DateTimeNative>,
    pub update_time: Option<rbatis::DateTimeNative>,
}


impl ChimesUserInfo {
    #[allow(dead_code)]
    pub async fn from_id(rb: &Rbatis,user_id: &i64) -> Result<Option<Self>, Error> {
        let wp = rb.new_wrapper()
            .eq("user_id", user_id);
        rb.fetch_by_wrapper::<Option<Self>>(wp).await
    }


    #[allow(dead_code)]
    pub async fn save(&mut self,rb: &Rbatis) -> Result<u64, Error> {
        match rb.save(self, &[Skip::Column("user_id"),Skip::Column("update_time"),Skip::Column("create_time"),Skip::Column("user_id")]).await {
            Ok(ds) => {
                self.user_id = ds.last_insert_id;
                Ok(ds.rows_affected)
            }
            Err(err) => {
                Err(err)
            }
        }
    }


    #[allow(dead_code)]
    pub async fn update(&self,rb: &Rbatis) -> Result<u64, Error> {
        let wp = rb.new_wrapper()
            .eq("user_id", self.user_id);
        rb.update_by_wrapper(self, wp, &[Skip::Column("user_id"),Skip::Column("update_time"),Skip::Column("create_time"),Skip::Column("user_id")]).await
    }


    #[allow(dead_code)]
    pub async fn update_selective(&self,rb: &Rbatis) -> Result<u64, Error> {
        let wp = rb.new_wrapper()
            .eq("user_id", self.user_id);
        rb.update_by_wrapper(self, wp, &[Skip::Value(Bson::Null)]).await
    }


    #[allow(dead_code)]
    pub async fn remove_batch(&self,rb: &Rbatis) -> Result<u64, Error> {
        let wp = rb.new_wrapper()
                 .r#if(self.user_id.clone().is_some(), |w| w.and().eq("user_id", self.user_id.clone().unwrap()))
                 .r#if(self.dept_id.clone().is_some(), |w| w.and().eq("dept_id", self.dept_id.clone().unwrap()))
                 .r#if(self.username.clone().is_some(), |w| w.and().eq("username", self.username.clone().unwrap()))
                 .r#if(self.nick_name.clone().is_some(), |w| w.and().eq("nick_name", self.nick_name.clone().unwrap()))
                 .r#if(self.gender.clone().is_some(), |w| w.and().eq("gender", self.gender.clone().unwrap()))
                 .r#if(self.phone.clone().is_some(), |w| w.and().eq("phone", self.phone.clone().unwrap()))
                 .r#if(self.email.clone().is_some(), |w| w.and().eq("email", self.email.clone().unwrap()))
                 .r#if(self.avatar_name.clone().is_some(), |w| w.and().eq("avatar_name", self.avatar_name.clone().unwrap()))
                 .r#if(self.avatar_path.clone().is_some(), |w| w.and().eq("avatar_path", self.avatar_path.clone().unwrap()))
                 .r#if(self.password.clone().is_some(), |w| w.and().eq("password", self.password.clone().unwrap()))
                 .r#if(self.is_admin.clone().is_some(), |w| w.and().eq("is_admin", self.is_admin.clone().unwrap()))
                 .r#if(self.enabled.clone().is_some(), |w| w.and().eq("enabled", self.enabled.clone().unwrap()))
                 .r#if(self.create_by.clone().is_some(), |w| w.and().eq("create_by", self.create_by.clone().unwrap()))
                 .r#if(self.update_by.clone().is_some(), |w| w.and().eq("update_by", self.update_by.clone().unwrap()))
                 .r#if(self.pwd_reset_time.clone().is_some(), |w| w.and().eq("pwd_reset_time", self.pwd_reset_time.clone().unwrap()))
                 .r#if(self.create_time.clone().is_some(), |w| w.and().eq("create_time", self.create_time.clone().unwrap()))
                 .r#if(self.update_time.clone().is_some(), |w| w.and().eq("update_time", self.update_time.clone().unwrap()));
        rb.remove_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn remove(&mut self,rb: &Rbatis) -> Result<u64, Error> {
        let wp = rb.new_wrapper()
            .eq("user_id", self.user_id);
        rb.remove_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn remove_ids(rb: &Rbatis,ids: &[i64]) -> Result<u64, Error> {
        let wp = rb.new_wrapper()
            .r#in("user_id", ids);
        rb.remove_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn query_paged(&self,rb: &Rbatis,curr: u64,ps: u64) -> Result<Page<Self>, Error> {
        let wp = rb.new_wrapper()
                 .r#if(self.user_id.clone().is_some(), |w| w.and().eq("user_id", self.user_id.clone().unwrap()))
                 .r#if(self.dept_id.clone().is_some(), |w| w.and().eq("dept_id", self.dept_id.clone().unwrap()))
                 .r#if(self.username.clone().is_some(), |w| w.and().eq("username", self.username.clone().unwrap()))
                 .r#if(self.nick_name.clone().is_some(), |w| w.and().eq("nick_name", self.nick_name.clone().unwrap()))
                 .r#if(self.gender.clone().is_some(), |w| w.and().eq("gender", self.gender.clone().unwrap()))
                 .r#if(self.phone.clone().is_some(), |w| w.and().eq("phone", self.phone.clone().unwrap()))
                 .r#if(self.email.clone().is_some(), |w| w.and().eq("email", self.email.clone().unwrap()))
                 .r#if(self.avatar_name.clone().is_some(), |w| w.and().eq("avatar_name", self.avatar_name.clone().unwrap()))
                 .r#if(self.avatar_path.clone().is_some(), |w| w.and().eq("avatar_path", self.avatar_path.clone().unwrap()))
                 .r#if(self.password.clone().is_some(), |w| w.and().eq("password", self.password.clone().unwrap()))
                 .r#if(self.is_admin.clone().is_some(), |w| w.and().eq("is_admin", self.is_admin.clone().unwrap()))
                 .r#if(self.enabled.clone().is_some(), |w| w.and().eq("enabled", self.enabled.clone().unwrap()))
                 .r#if(self.create_by.clone().is_some(), |w| w.and().eq("create_by", self.create_by.clone().unwrap()))
                 .r#if(self.update_by.clone().is_some(), |w| w.and().eq("update_by", self.update_by.clone().unwrap()))
                 .r#if(self.pwd_reset_time.clone().is_some(), |w| w.and().eq("pwd_reset_time", self.pwd_reset_time.clone().unwrap()))
                 .r#if(self.create_time.clone().is_some(), |w| w.and().eq("create_time", self.create_time.clone().unwrap()))
                 .r#if(self.update_time.clone().is_some(), |w| w.and().eq("update_time", self.update_time.clone().unwrap()));
        rb.fetch_page_by_wrapper::<Self>(wp, &PageRequest::new(curr, ps)).await
    }


    #[allow(dead_code)]
    pub async fn query_list(&self,rb: &Rbatis) -> Result<Vec<Self>, Error> {
        let wp = rb.new_wrapper()
                 .r#if(self.user_id.clone().is_some(), |w| w.and().eq("user_id", self.user_id.clone().unwrap()))
                 .r#if(self.dept_id.clone().is_some(), |w| w.and().eq("dept_id", self.dept_id.clone().unwrap()))
                 .r#if(self.username.clone().is_some(), |w| w.and().eq("username", self.username.clone().unwrap()))
                 .r#if(self.nick_name.clone().is_some(), |w| w.and().eq("nick_name", self.nick_name.clone().unwrap()))
                 .r#if(self.gender.clone().is_some(), |w| w.and().eq("gender", self.gender.clone().unwrap()))
                 .r#if(self.phone.clone().is_some(), |w| w.and().eq("phone", self.phone.clone().unwrap()))
                 .r#if(self.email.clone().is_some(), |w| w.and().eq("email", self.email.clone().unwrap()))
                 .r#if(self.avatar_name.clone().is_some(), |w| w.and().eq("avatar_name", self.avatar_name.clone().unwrap()))
                 .r#if(self.avatar_path.clone().is_some(), |w| w.and().eq("avatar_path", self.avatar_path.clone().unwrap()))
                 .r#if(self.password.clone().is_some(), |w| w.and().eq("password", self.password.clone().unwrap()))
                 .r#if(self.is_admin.clone().is_some(), |w| w.and().eq("is_admin", self.is_admin.clone().unwrap()))
                 .r#if(self.enabled.clone().is_some(), |w| w.and().eq("enabled", self.enabled.clone().unwrap()))
                 .r#if(self.create_by.clone().is_some(), |w| w.and().eq("create_by", self.create_by.clone().unwrap()))
                 .r#if(self.update_by.clone().is_some(), |w| w.and().eq("update_by", self.update_by.clone().unwrap()))
                 .r#if(self.pwd_reset_time.clone().is_some(), |w| w.and().eq("pwd_reset_time", self.pwd_reset_time.clone().unwrap()))
                 .r#if(self.create_time.clone().is_some(), |w| w.and().eq("create_time", self.create_time.clone().unwrap()))
                 .r#if(self.update_time.clone().is_some(), |w| w.and().eq("update_time", self.update_time.clone().unwrap()));
        rb.fetch_list_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn query_all(rb: &Rbatis) -> Result<Vec<Self>, Error> {
        let wp = rb.new_wrapper();
        rb.fetch_list_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn load_username(rb: &Rbatis,username: &String) -> Result<Option<Self>, Error> {
        let wp = rb.new_wrapper()
                 .and().eq("username", username.clone());
        rb.fetch_by_wrapper::<Option<Self>>(wp).await
    }


}

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct UserUpdatePasswordRequest {
    pub old_pwd: String,
    pub new_pwd: String,
}

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct UserUpdateInfoRequest {
    pub nick_name: String,
    pub gender: String,
    pub phone: String,
}

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct UserUpdateEmailRequest {
    pub password: String,
    pub email: String,
    pub code: String,
}

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct UserUpdateAvatarRequest {
    pub old_pwd: String,
    pub new_pwd: String,
}
