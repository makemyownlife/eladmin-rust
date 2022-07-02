/**
 * Generate the file for chimes_role_menus.rs, 
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
use crate::entity::ChimesRoleInfo;
use crate::entity::ChimesMenuInfo;
use crate::entity::ChimesRoleMenuInfo;
use crate::entity::ChimesPermissionInfo;
use crate::entity::ChimesRolePermissionInfo;

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct ChimesRoleMenus {
    pub role_id: Option<i64>,
    pub name: Option<String>,
    pub level: Option<i32>,
    pub description: Option<String>,
    pub data_scope: Option<String>,
    pub create_by: Option<String>,
    pub update_by: Option<String>,
    pub create_time: Option<rbatis::DateTimeNative>,
    pub update_time: Option<rbatis::DateTimeNative>,
    #[serde(default)]
    pub menus: Vec<ChimesMenuInfo>,
    #[serde(default)]
    pub permissions: Vec<ChimesPermissionInfo>,
}


impl ChimesRoleMenus {
    #[allow(dead_code)]
    pub fn from_role(param: &ChimesRoleInfo) -> Self {
        ChimesRoleMenus {
            role_id: param.role_id.clone(),
            name: param.name.clone(),
            level: param.level.clone(),
            description: param.description.clone(),
            data_scope: param.data_scope.clone(),
            create_by: param.create_by.clone(),
            update_by: param.update_by.clone(),
            create_time: param.create_time.clone(),
            update_time: param.update_time.clone(),
            menus: vec![],
            permissions: vec![],
        }
    }


    #[allow(dead_code)]
    pub fn to_role(&self) -> ChimesRoleInfo {
        ChimesRoleInfo {
            role_id: self.role_id.clone(),
            name: self.name.clone(),
            level: self.level.clone(),
            description: self.description.clone(),
            data_scope: self.data_scope.clone(),
            create_by: self.create_by.clone(),
            update_by: self.update_by.clone(),
            create_time: self.create_time.clone(),
            update_time: self.update_time.clone(),
        }
    }


    #[allow(dead_code)]
    pub async fn load(rb: &Rbatis,role_id: &i64) -> Result<Option<Self>, Error> {
        match ChimesRoleInfo::from_id(rb, role_id).await {
            Ok(ts) => {
                match ts {
                    Some(mp) => {
                        let mut selfmp = Self::from_role(&mp);
                        let mut rb_args = vec![];
                        let sql_menu = "SELECT tp.* FROM chimes_menu tp INNER JOIN chimes_roles_menus mt ON tp.menu_id = mt.menu_id WHERE mt.role_id = ?";
                        rb_args.push(rbson::to_bson(&selfmp.role_id.clone().unwrap_or_default()).unwrap_or_default());
                        selfmp.menus = match rb.fetch(sql_menu, rb_args).await {
                            Ok(lst) => {
                                lst
                            }
                            Err(_) => {
                                vec![]
                            }
                        };
                        let mut rb_args = vec![];
                        let sql_permission = "SELECT tp.* FROM chimes_permission tp INNER JOIN chimes_roles_permissions mt ON tp.id = mt.id WHERE mt.role_id = ?";
                        rb_args.push(rbson::to_bson(&selfmp.role_id.clone().unwrap_or_default()).unwrap_or_default());
                        selfmp.permissions = match rb.fetch(sql_permission, rb_args).await {
                            Ok(lst) => {
                                lst
                            }
                            Err(_) => {
                                vec![]
                            }
                        };
                        Ok(Some(selfmp))
                    }
                    None => {
                        Ok(None)
                    }
                }
            }
            Err(err) => {
                Err(err)
            }
        }
    }


    #[allow(dead_code)]
    pub async fn save(&self,rb: &Rbatis) -> Result<bool, Error> {
        let mut ret: Option<Error> = None;
        let mut self_role = self.to_role();
        if self_role.role_id.is_none() {
            ret = match self_role.save(rb).await {
                Ok(_rs) => {
                    None
                }
                Err(err) => {
                    log::info!("Save role occurred an error {}", err);
                    Some(err)
                }
            }
        }
        else {
            ret = match self_role.update_selective(rb).await {
                Ok(_rs) => {
                    None
                }
                Err(err) => {
                    log::info!("Update role occurred an error {}", err);
                    Some(err)
                }
            }
        }
        // remove batch for ChimesRoleMenuInfo.
        if ret.is_none() {
            let mut rm_role_menu_info = ChimesRoleMenuInfo::default();
            rm_role_menu_info.role_id = self.role_id;
            ret = match rm_role_menu_info.remove_batch(rb).await {
                Ok(_) => {
                    None
                }
                Err(err) => {
                    log::info!("Remove role_menu_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        for row in self.menus.clone() {
            let mut svrow_role_menu_info = ChimesRoleMenuInfo::default();
            svrow_role_menu_info.role_id = self.role_id.clone();
            svrow_role_menu_info.menu_id = row.menu_id.clone();
            ret = match svrow_role_menu_info.save(rb).await {
                Ok(_) => {
                    None
                }
                Err(err) => {
                    log::info!("Save role_menu_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        // remove batch for ChimesRolePermissionInfo.
        if ret.is_none() {
            let mut rm_role_permission_info = ChimesRolePermissionInfo::default();
            rm_role_permission_info.role_id = self.role_id;
            ret = match rm_role_permission_info.remove_batch(rb).await {
                Ok(_) => {
                    None
                }
                Err(err) => {
                    log::info!("Remove role_permission_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        for row in self.permissions.clone() {
            let mut svrow_role_permission_info = ChimesRolePermissionInfo::default();
            svrow_role_permission_info.role_id = self.role_id.clone();
            svrow_role_permission_info.id = row.id.clone();
            ret = match svrow_role_permission_info.save(rb).await {
                Ok(_) => {
                    None
                }
                Err(err) => {
                    log::info!("Save role_permission_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        match ret {
            Some(err) => {
                Err(err)
            }
            None => {
                Ok(true)
            }
        }
    }


    #[allow(dead_code)]
    pub async fn remove(&self,rb: &Rbatis) -> Result<bool, Error> {
        let mut ret: Option<Error> = None;
        // remove batch for ChimesRoleMenuInfo.
        if ret.is_none() {
            let mut rm_role_menu_info = ChimesRoleMenuInfo::default();
            rm_role_menu_info.role_id = self.role_id;
            ret = match rm_role_menu_info.remove_batch(rb).await {
                Ok(_rtremove) => {
                    None
                }
                Err(err) => {
                    log::info!("Remove role_menu_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        // remove batch for ChimesRolePermissionInfo.
        if ret.is_none() {
            let mut rm_role_permission_info = ChimesRolePermissionInfo::default();
            rm_role_permission_info.role_id = self.role_id;
            ret = match rm_role_permission_info.remove_batch(rb).await {
                Ok(_rtremove) => {
                    None
                }
                Err(err) => {
                    log::info!("Remove role_permission_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        if ret.is_none() {
            match self.to_role().remove(rb).await {
                Ok(_rs) => {
                    Ok(true)
                }
                Err(err) => {
                    log::info!("Remove role occurred an error {}", err);
                    Err(err)
                }
            }
        }
        else {
            Err(ret.unwrap())
        }
    }


}

