/**
 * Generate the file for query_user_menus.rs, 
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

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct QueryUserMenusParams {
    pub username: String,
}


#[crud_table(table_name:"QueryUserMenus"|table_columns:"menu_id,pid,sub_count,type,title,name,component,menu_sort,icon,path,i_frame,cache,hidden,permission,create_by,update_by,create_time,update_time")]
#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct QueryUserMenus {
    pub menu_id: Option<i64>,
    pub pid: Option<i64>,
    pub sub_count: Option<i32>,
    #[serde(rename(deserialize="type"))]
    pub r#type: Option<i32>,
    pub title: Option<String>,
    pub name: Option<String>,
    pub component: Option<String>,
    pub menu_sort: Option<i32>,
    pub icon: Option<String>,
    pub path: Option<String>,
    pub i_frame: Option<bool>,
    pub cache: Option<bool>,
    pub hidden: Option<bool>,
    pub permission: Option<String>,
    pub create_by: Option<String>,
    pub update_by: Option<String>,
    pub create_time: Option<rbatis::DateTimeNative>,
    pub update_time: Option<rbatis::DateTimeNative>,
}


impl QueryUserMenus {
    #[allow(dead_code)]
    pub async fn query(rb: &Rbatis,param: &QueryUserMenusParams) -> Result<Vec<QueryUserMenus>, Error> {
        let sql = "SELECT p.* FROM chimes_menu p INNER JOIN chimes_roles_menus rp ON p.menu_id = rp.menu_id INNER JOIN chimes_users_roles cur ON rp.role_id = cur.role_id  INNER JOIN chimes_user cu ON cur.user_id  = cu.user_id AND cu.username = ?".to_string();
        let mut rb_args = vec![];
        rb_args.push(rbson::to_bson(&param.username).unwrap_or_default());
        return rb.fetch(&sql, rb_args).await
    }


    #[allow(dead_code)]
    pub async fn query_paged(rb: &Rbatis,param: &QueryUserMenusParams,curr: u64,size: u64) -> Result<Page<QueryUserMenus>, Error> {
        let sql = "SELECT p.* FROM chimes_menu p INNER JOIN chimes_roles_menus rp ON p.menu_id = rp.menu_id INNER JOIN chimes_users_roles cur ON rp.role_id = cur.role_id  INNER JOIN chimes_user cu ON cur.user_id  = cu.user_id AND cu.username = ?".to_string();
        let mut rb_args = vec![];
        rb_args.push(rbson::to_bson(&param.username).unwrap_or_default());
        return rb.fetch_page(&sql, rb_args, &PageRequest::new(curr, size)).await
    }


}

