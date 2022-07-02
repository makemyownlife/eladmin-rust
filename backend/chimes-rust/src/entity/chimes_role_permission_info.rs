/**
 * Generate the file for chimes_role_permission_info.rs, 
 */

use std::fmt::{Debug};
use serde_derive::{Deserialize, Serialize};
use rbatis::crud_table;
use rbatis::rbatis::{Rbatis};
use rbatis::error::Error;
use rbatis::crud::{CRUD, Skip};
use crate::utils::bool_from_str;

#[crud_table(table_name:"chimes_roles_permissions"|table_columns:"role_id,id")]
#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct ChimesRolePermissionInfo {
    pub role_id: Option<i64>,
    pub id: Option<i64>,
}


impl ChimesRolePermissionInfo {
    #[allow(dead_code)]
    pub async fn from_id(rb: &Rbatis,role_id: &i64,id: &i64) -> Result<Option<Self>, Error> {
        let wp = rb.new_wrapper()
            .eq("role_id", role_id)
            .and()
            .eq("id", id);
        rb.fetch_by_wrapper::<Option<Self>>(wp).await
    }


    #[allow(dead_code)]
    pub async fn save(&mut self,rb: &Rbatis) -> Result<u64, Error> {
        match rb.save(self, &[]).await {
            Ok(ds) => {
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
            .eq("role_id", self.role_id)
            .and()
            .eq("id", self.id);
        rb.update_by_wrapper(self, wp, &[Skip::Column("role_id"),Skip::Column("id")]).await
    }


    #[allow(dead_code)]
    pub async fn remove_batch(&self,rb: &Rbatis) -> Result<u64, Error> {
        let wp = rb.new_wrapper()
                 .r#if(self.role_id.clone().is_some(), |w| w.and().eq("role_id", self.role_id.clone().unwrap()))
                 .r#if(self.id.clone().is_some(), |w| w.and().eq("id", self.id.clone().unwrap()));
        rb.remove_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn remove(&mut self,rb: &Rbatis) -> Result<u64, Error> {
        let wp = rb.new_wrapper()
            .eq("role_id", self.role_id)
            .and()
            .eq("id", self.id);
        rb.remove_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn query_list(&self,rb: &Rbatis) -> Result<Vec<Self>, Error> {
        let wp = rb.new_wrapper()
                 .r#if(self.role_id.clone().is_some(), |w| w.and().eq("role_id", self.role_id.clone().unwrap()))
                 .r#if(self.id.clone().is_some(), |w| w.and().eq("id", self.id.clone().unwrap()));
        rb.fetch_list_by_wrapper::<Self>(wp).await
    }


    #[allow(dead_code)]
    pub async fn query_all(rb: &Rbatis) -> Result<Vec<Self>, Error> {
        let wp = rb.new_wrapper();
        rb.fetch_list_by_wrapper::<Self>(wp).await
    }


}

