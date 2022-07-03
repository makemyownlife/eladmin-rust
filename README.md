# chimes-rust

#### 介绍
使用Rust实现的应用后台管理程序，前端采用最新版的eladmin前端，经过少量修改实现。主要修改是api路径的，以及表格或表单的字段绑定（因为rust的命名规范的要求进行了一些字段的修改）。
Chimes-rust，主要是实现了eladmin中的系统管理功能，以及登录和用户中心。对于其它部分的功能，可能会在后续的版本中进行实现。

#### 软件架构
Chimes-rust采用actix-web作为基础的WEB框架进行开发，而在ORM方面采用了Rbatis，目前暂时没有使用Redis来缓存相应的数据。

#### 重点组件

1.  actix-web
2.  rbatis 
3.  chimes-auth，基于actix-web的MiddleWare提供的权限管控的功能。
4.  jsonwebtoken
5.  rbatis-generator，这是另一个开源的用于生成rbatis为基础的rust源码

#### 特别说明

1. 关于el-admin前端，本应用不是为了提供更好的el-admin的前端，所做的修改都是为了与后台进行对接，所以是尽可能少的修改它。同时，在此特别感谢eladmin的作者，他为应用提供了一个功能丰富的管理前端。
2. chimes-rust的大部分后端代码是采用rbatis-generator进行生成的，基本上达到85%。如对该项目感兴趣的，可以进仓库：https://gitee.com/poethxp/rbatis-generator 看看。

#### 安装教程

1.  创建数据chimesrust，并导入数据 sql/chimesrust.sql；
2.  编译 backend/chimes-rust，可以进入该目录后，直接执行cargo r
3.  打包前端 frontend/eladmin-web
4.  后端的一些配置可以修秘诀backend/chimes-rust/conf/app.yml

#### 运行截图
1. 登录
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/login.png" width="600">

2. Home
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/home.png" width="600">

3. 菜单
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/menus.png" width="600">

4. 角色
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/login.png" width="600">

5. 权限资源
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/permissions.png" width="600">

6. 用户
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/users.png" width="600">

7. 字典
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/dicts.png" width="600">

8. 部门
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/depts.png" width="600">

9. 岗位
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/jobs.png" width="600">

10. 用户中心
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/user_center.png" width="600">

11. 用户中心-修改头像
<img src="https://gitee.com/poethxp/chimes-rust/raw/master/screens/user_center_update_avatar.png" width="600">


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request

