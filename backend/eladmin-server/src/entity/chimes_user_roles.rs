/**
 * Generate the file for chimes_user_roles.rs, 
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
use crate::entity::ChimesUserInfo;
use crate::entity::ChimeProfileInfo;
use crate::entity::ChimesRoleInfo;
use crate::entity::ChimesUserRoleInfo;

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
pub struct ChimesUserRoles {
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
    pub is_admin: Option<bool>,
    pub enabled: Option<i32>,
    pub create_by: Option<String>,
    pub update_by: Option<String>,
    pub pwd_reset_time: Option<rbatis::DateTimeNative>,
    pub create_time: Option<rbatis::DateTimeNative>,
    pub update_time: Option<rbatis::DateTimeNative>,
    #[serde(rename(deserialize="user_id"))]
    pub profile: Option<ChimeProfileInfo>,
    #[serde(rename(deserialize="role_id"))]
    pub roles: Vec<ChimesRoleInfo>,
}


impl ChimesUserRoles {
    #[allow(dead_code)]
    pub fn from_user(param: &ChimesUserInfo) -> Self {
        ChimesUserRoles {
            user_id: param.user_id.clone(),
            dept_id: param.dept_id.clone(),
            username: param.username.clone(),
            nick_name: param.nick_name.clone(),
            gender: param.gender.clone(),
            phone: param.phone.clone(),
            email: param.email.clone(),
            avatar_name: param.avatar_name.clone(),
            avatar_path: param.avatar_path.clone(),
            password: param.password.clone(),
            is_admin: param.is_admin.clone(),
            enabled: param.enabled.clone(),
            create_by: param.create_by.clone(),
            update_by: param.update_by.clone(),
            pwd_reset_time: param.pwd_reset_time.clone(),
            create_time: param.create_time.clone(),
            update_time: param.update_time.clone(),
            profile: None,
            roles: vec![],
        }
    }


    #[allow(dead_code)]
    pub fn to_user(&self) -> ChimesUserInfo {
        ChimesUserInfo {
            user_id: self.user_id.clone(),
            dept_id: self.dept_id.clone(),
            username: self.username.clone(),
            nick_name: self.nick_name.clone(),
            gender: self.gender.clone(),
            phone: self.phone.clone(),
            email: self.email.clone(),
            avatar_name: self.avatar_name.clone(),
            avatar_path: self.avatar_path.clone(),
            password: self.password.clone(),
            is_admin: self.is_admin.clone(),
            enabled: self.enabled.clone(),
            create_by: self.create_by.clone(),
            update_by: self.update_by.clone(),
            pwd_reset_time: self.pwd_reset_time.clone(),
            create_time: self.create_time.clone(),
            update_time: self.update_time.clone(),
        }
    }


    #[allow(dead_code)]
    pub async fn load(rb: &Rbatis,user_id: &i64) -> Result<Option<Self>, Error> {
        match ChimesUserInfo::from_id(rb, user_id).await {
            Ok(ts) => {
                match ts {
                    Some(mp) => {
                        let mut selfmp = Self::from_user(&mp);
                        let mut tmp_profile = ChimeProfileInfo::default();
                        tmp_profile.user_id = selfmp.user_id.clone();
                        selfmp.profile = match tmp_profile.query_list(rb).await {
                            Ok(lst) => {
                                if lst.len() > 0 {
                                    Some(lst[0].clone())
                                } else {
                                    None
                                }
                            }
                            Err(_) => {
                                None
                            }
                        };
                        let mut rb_args = vec![];
                        let sql_role = "SELECT tp.* FROM chimes_role tp INNER JOIN chimes_users_roles mt ON tp.role_id = mt.role_id WHERE mt.user_id = ?";
                        rb_args.push(rbson::to_bson(&selfmp.user_id.clone().unwrap_or_default()).unwrap_or_default());
                        selfmp.roles = match rb.fetch(sql_role, rb_args).await {
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
        let mut self_user = self.to_user();
        if self_user.user_id.is_none() {
            ret = match self_user.save(rb).await {
                Ok(_rs) => {
                    None
                }
                Err(err) => {
                    log::info!("Save user occurred an error {}", err);
                    Some(err)
                }
            }
        }
        else {
            ret = match self_user.update(rb).await {
                Ok(_rs) => {
                    None
                }
                Err(err) => {
                    log::info!("Update user occurred an error {}", err);
                    Some(err)
                }
            }
        }
        if ret.is_none() {
            ret = match self.profile.clone() {
                Some(tp) => {
                    let mut mtp = tp.clone();
                    mtp.user_id = self_user.user_id.clone();
                    if mtp.user_id.is_none() {
                        match mtp.save(rb).await {
                            Ok(_mtpsave) => {
                                None
                            }
                            Err(err) => {
                                log::info!("Save profile occurred an error {}", err);
                                Some(err)
                            }
                        }
                    } else {
                        match mtp.update(rb).await {
                            Ok(_mtpsave) => {
                                None
                            }
                            Err(err) => {
                                log::info!("Save profile occurred an error {}", err);
                                Some(err)
                            }
                        }
                    }
                }
                None => {
                    None
                }
            };
        }
        // remove batch for ChimesUserRoleInfo.
        if ret.is_none() {
            let mut rm_user_role_info = ChimesUserRoleInfo::default();
            rm_user_role_info.role_id = self.user_id;
            ret = match rm_user_role_info.remove_batch(rb).await {
                Ok(_) => {
                    None
                }
                Err(err) => {
                    log::info!("Remove user_role_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        for row in self.roles.clone() {
            let mut svrow_user_role_info = ChimesUserRoleInfo::default();
            svrow_user_role_info.user_id = self.user_id.clone();
            svrow_user_role_info.role_id = row.role_id.clone();
            ret = match svrow_user_role_info.save(rb).await {
                Ok(_) => {
                    None
                }
                Err(err) => {
                    log::info!("Save user_role_info occurred an error {}", err);
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
        if ret.is_none() {
            ret = match self.profile.clone() {
                Some(tp) => {
                    let mut mtp = tp.clone();
                    match mtp.remove(rb).await {
                        Ok(_rtremove) => {
                            None
                        }
                        Err(err) => {
                            log::info!("Remove profile occurred an error {}", err);
                            Some(err)
                        }
                    }
                }
                None => {
                    None
                }
            };
        }
        // remove batch for ChimesUserRoleInfo.
        if ret.is_none() {
            let mut rm_user_role_info = ChimesUserRoleInfo::default();
            rm_user_role_info.role_id = self.user_id;
            ret = match rm_user_role_info.remove_batch(rb).await {
                Ok(_rtremove) => {
                    None
                }
                Err(err) => {
                    log::info!("Remove user_role_info occurred an error {}", err);
                    Some(err)
                }
            };
        }
        if ret.is_none() {
            match self.to_user().remove(rb).await {
                Ok(_rs) => {
                    Ok(true)
                }
                Err(err) => {
                    log::info!("Remove user occurred an error {}", err);
                    Err(err)
                }
            }
        }
        else {
            Err(ret.unwrap())
        }
    }


}

