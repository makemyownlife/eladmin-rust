/*
 Navicat Premium Data Transfer

 Source Server         : courage_localhost
 Source Server Type    : MySQL
 Source Server Version : 50739
 Source Host           : localhost:3306
 Source Schema         : chimesrust

 Target Server Type    : MySQL
 Target Server Version : 50739
 File Encoding         : 65001

 Date: 09/11/2023 17:36:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chimes_dept
-- ----------------------------
DROP TABLE IF EXISTS `chimes_dept`;
CREATE TABLE `chimes_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` bigint(20) DEFAULT NULL COMMENT '上级部门',
  `sub_count` int(11) DEFAULT '0' COMMENT '子部门数目',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `dept_sort` int(11) DEFAULT '999' COMMENT '排序',
  `enabled` tinyint(1) NOT NULL COMMENT '状态',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE,
  KEY `inx_pid` (`pid`),
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='部门';

-- ----------------------------
-- Records of chimes_dept
-- ----------------------------
BEGIN;
INSERT INTO `chimes_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, 7, 1, '研发部', 3, 1, 'admin', 'admin', '2019-03-25 09:15:32', '2020-08-02 14:48:47');
INSERT INTO `chimes_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 7, 0, '运维部', 4, 1, 'admin', 'admin', '2019-03-25 09:20:44', '2020-05-17 14:27:27');
INSERT INTO `chimes_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, 8, 0, '测试部', 6, 1, 'admin', 'admin', '2019-03-25 09:52:18', '2020-06-08 11:59:21');
INSERT INTO `chimes_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (7, NULL, 2, '华南分部', 0, 1, 'admin', 'admin', '2019-03-25 11:04:50', '2020-06-08 12:08:56');
INSERT INTO `chimes_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (8, NULL, 2, '华北分部', 1, 1, 'admin', 'admin', '2019-03-25 11:04:53', '2020-05-14 12:54:00');
INSERT INTO `chimes_dept` (`dept_id`, `pid`, `sub_count`, `name`, `dept_sort`, `enabled`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (17, 8, 0, '研发一组', 999, 1, 'admin', 'admin', '2020-08-02 14:49:07', '2020-08-02 14:49:07');
COMMIT;

-- ----------------------------
-- Table structure for chimes_dict
-- ----------------------------
DROP TABLE IF EXISTS `chimes_dict`;
CREATE TABLE `chimes_dict` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '字典名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='数据字典';

-- ----------------------------
-- Records of chimes_dict
-- ----------------------------
BEGIN;
INSERT INTO `chimes_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, 'user_status', '用户状态', NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `chimes_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (4, 'dept_status', '部门状态', NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `chimes_dict` (`dict_id`, `name`, `description`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 'job_status', '岗位状态', NULL, NULL, '2019-10-27 20:31:36', NULL);
COMMIT;

-- ----------------------------
-- Table structure for chimes_dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `chimes_dict_detail`;
CREATE TABLE `chimes_dict_detail` (
  `detail_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dict_id` bigint(20) DEFAULT NULL COMMENT '字典id',
  `label` varchar(255) NOT NULL COMMENT '字典标签',
  `value` varchar(255) NOT NULL COMMENT '字典值',
  `dict_sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`detail_id`) USING BTREE,
  KEY `FK5tpkputc6d9nboxojdbgnpmyb` (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='数据字典详情';

-- ----------------------------
-- Records of chimes_dict_detail
-- ----------------------------
BEGIN;
INSERT INTO `chimes_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, 1, '激活', 'true', 3, NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `chimes_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, 1, '禁用', 'false', 2, NULL, NULL, NULL, NULL);
INSERT INTO `chimes_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (3, 4, '启用', 'true', 1, NULL, NULL, NULL, NULL);
INSERT INTO `chimes_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (4, 4, '停用', 'false', 2, NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `chimes_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 5, '启用', 'true', 1, NULL, NULL, NULL, NULL);
INSERT INTO `chimes_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, 5, '停用', 'false', 2, NULL, NULL, '2019-10-27 20:31:36', NULL);
INSERT INTO `chimes_dict_detail` (`detail_id`, `dict_id`, `label`, `value`, `dict_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (10, NULL, '未知', 'unknow', 3, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for chimes_job
-- ----------------------------
DROP TABLE IF EXISTS `chimes_job`;
CREATE TABLE `chimes_job` (
  `job_id` bigint(20) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '岗位名称',
  `enabled` tinyint(1) NOT NULL COMMENT '岗位状态',
  `job_sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of chimes_job
-- ----------------------------
BEGIN;
INSERT INTO `chimes_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (8, '人事专员', 1, 3, NULL, NULL, '2019-03-29 14:52:28', NULL);
INSERT INTO `chimes_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (10, '产品经理', 1, 4, NULL, NULL, '2019-03-29 14:55:51', NULL);
INSERT INTO `chimes_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (11, '全栈开发', 1, 2, NULL, 'admin', '2019-03-31 13:39:30', '2020-05-05 11:33:43');
INSERT INTO `chimes_job` (`job_id`, `name`, `enabled`, `job_sort`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (12, '软件测试', 1, 5, NULL, 'admin', '2019-03-31 13:39:43', '2020-05-10 19:56:26');
COMMIT;

-- ----------------------------
-- Table structure for chimes_log
-- ----------------------------
DROP TABLE IF EXISTS `chimes_log`;
CREATE TABLE `chimes_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `description` varchar(255) DEFAULT NULL,
  `log_type` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `params` text,
  `request_ip` varchar(255) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `exception_detail` text,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `log_create_time_index` (`create_time`),
  KEY `inx_log_type` (`log_type`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='系统日志';

-- ----------------------------
-- Records of chimes_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chimes_menu
-- ----------------------------
DROP TABLE IF EXISTS `chimes_menu`;
CREATE TABLE `chimes_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` bigint(20) DEFAULT NULL COMMENT '上级菜单ID',
  `sub_count` int(11) DEFAULT '0' COMMENT '子菜单数目',
  `type` int(11) DEFAULT NULL COMMENT '菜单类型',
  `title` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '菜单标题',
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '组件名称',
  `component` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '组件',
  `menu_sort` int(11) DEFAULT NULL COMMENT '排序',
  `icon` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '图标',
  `path` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '链接地址',
  `i_frame` tinyint(1) DEFAULT NULL COMMENT '是否外链',
  `cache` tinyint(1) DEFAULT '0' COMMENT '缓存',
  `hidden` tinyint(1) DEFAULT '0' COMMENT '隐藏',
  `permission` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限',
  `create_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`menu_id`) USING BTREE,
  UNIQUE KEY `uniq_title` (`title`),
  UNIQUE KEY `uniq_name` (`name`),
  KEY `inx_pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of chimes_menu
-- ----------------------------
BEGIN;
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, NULL, 7, 0, '系统管理', NULL, NULL, 1, 'system', 'system', 0, 0, 0, NULL, NULL, NULL, '2018-12-18 15:11:29', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, 1, 3, 1, '用户管理', 'User', 'system/user/index', 2, 'peoples', 'user', 0, 0, 0, 'user:list', NULL, NULL, '2018-12-18 15:14:44', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (3, 1, 3, 1, '角色管理', 'Role', 'system/role/index', 3, 'role', 'role', 0, 0, 0, 'roles:list', NULL, NULL, '2018-12-18 15:16:07', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (5, 1, 3, 1, '菜单管理', 'Menu', 'system/menu/index', 5, 'menu', 'menu', 0, 0, 0, 'menu:list', NULL, NULL, '2018-12-18 15:17:28', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (6, NULL, 5, 0, '系统监控', NULL, NULL, 10, 'monitor', 'monitor', 0, 0, 0, NULL, NULL, NULL, '2018-12-18 15:17:48', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (7, 6, 0, 1, '操作日志', 'Log', 'monitor/log/index', 11, 'log', 'logs', 0, 1, 0, NULL, NULL, 'admin', '2018-12-18 15:18:26', '2020-06-06 13:11:57');
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (9, 6, 0, 1, 'SQL监控', 'Sql', 'monitor/sql/index', 18, 'sqlMonitor', 'druid', 0, 0, 0, NULL, NULL, NULL, '2018-12-18 15:19:34', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (10, NULL, 5, 0, '组件管理', NULL, NULL, 50, 'zujian', 'components', 0, 0, 1, NULL, NULL, NULL, '2018-12-19 13:38:16', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (11, 10, 0, 1, '图标库', 'Icons', 'components/icons/index', 51, 'icon', 'icon', 0, 0, 0, NULL, NULL, NULL, '2018-12-19 13:38:49', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (14, 36, 0, 1, '邮件工具', 'Email', 'tools/email/index', 35, 'email', 'email', 0, 0, 0, NULL, NULL, NULL, '2018-12-27 10:13:09', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (15, 10, 0, 1, '富文本', 'Editor', 'components/Editor', 52, 'fwb', 'tinymce', 0, 0, 0, NULL, NULL, NULL, '2018-12-27 11:58:25', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (18, 36, 3, 1, '存储管理', 'Storage', 'tools/storage/index', 34, 'qiniu', 'storage', 0, 0, 0, 'storage:list', NULL, NULL, '2018-12-31 11:12:15', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (19, 36, 0, 1, '支付宝工具', 'AliPay', 'tools/aliPay/index', 37, 'alipay', 'aliPay', 0, 0, 0, NULL, NULL, NULL, '2018-12-31 14:52:38', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (21, NULL, 2, 0, '多级菜单', NULL, '', 900, 'menu', 'nested', 0, 0, 1, NULL, NULL, 'admin', '2019-01-04 16:22:03', '2020-06-21 17:27:35');
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (22, 21, 2, 0, '二级菜单1', NULL, '', 999, 'menu', 'menu1', 0, 0, 0, NULL, NULL, 'admin', '2019-01-04 16:23:29', '2020-06-21 17:27:20');
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (23, 21, 0, 1, '二级菜单2', NULL, 'nested/menu2/index', 999, 'menu', 'menu2', 0, 0, 0, NULL, NULL, NULL, '2019-01-04 16:23:57', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (24, 22, 0, 1, '三级菜单1', 'Test', 'nested/menu1/menu1-1', 999, 'menu', 'menu1-1', 0, 0, 0, NULL, NULL, NULL, '2019-01-04 16:24:48', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (27, 22, 0, 1, '三级菜单2', NULL, 'nested/menu1/menu1-2', 999, 'menu', 'menu1-2', 0, 0, 0, NULL, NULL, NULL, '2019-01-07 17:27:32', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (28, 1, 3, 1, '任务调度', 'Timing', 'system/timing/index', 999, 'timing', 'timing', 0, 0, 1, 'timing:list', NULL, NULL, '2019-01-07 20:34:40', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (30, 36, 0, 1, '代码生成', 'GeneratorIndex', 'generator/index', 32, 'dev', 'generator', 0, 1, 0, NULL, NULL, NULL, '2019-01-11 15:45:55', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (32, 6, 0, 1, '异常日志', 'ErrorLog', 'monitor/log/errorLog', 12, 'error', 'errorLog', 0, 0, 0, NULL, NULL, NULL, '2019-01-13 13:49:03', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (33, 10, 0, 1, 'Markdown', 'Markdown', 'components/MarkDown', 53, 'markdown', 'markdown', 0, 0, 0, NULL, NULL, NULL, '2019-03-08 13:46:44', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (34, 10, 0, 1, 'Yaml编辑器', 'YamlEdit', 'components/YamlEdit', 54, 'dev', 'yaml', 0, 0, 0, NULL, NULL, NULL, '2019-03-08 15:49:40', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (35, 1, 3, 1, '部门管理', 'Dept', 'system/dept/index', 6, 'dept', 'dept', 0, 0, 0, 'dept:list', NULL, NULL, '2019-03-25 09:46:00', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (36, NULL, 7, 0, '系统工具', NULL, '', 30, 'sys-tools', 'sys-tools', 0, 0, 1, NULL, NULL, NULL, '2019-03-29 10:57:35', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (37, 1, 3, 1, '岗位管理', 'Job', 'system/job/index', 7, 'Steve-Jobs', 'job', 0, 0, 0, 'job:list', NULL, NULL, '2019-03-29 13:51:18', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (38, 36, 0, 1, '接口文档', 'Swagger', 'tools/swagger/index', 36, 'swagger', 'swagger2', 0, 0, 0, NULL, NULL, NULL, '2019-03-29 19:57:53', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (39, 1, 3, 1, '字典管理', 'Dict', 'system/dict/index', 8, 'dictionary', 'dict', 0, 0, 0, 'dict:list', NULL, NULL, '2019-04-10 11:49:04', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (41, 6, 0, 1, '在线用户', 'OnlineUser', 'monitor/online/index', 10, 'Steve-Jobs', 'online', 0, 0, 0, NULL, NULL, NULL, '2019-10-26 22:08:43', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (44, 2, 0, 2, '用户新增', NULL, '', 2, '', '', 0, 0, 0, 'user:add', NULL, NULL, '2019-10-29 10:59:46', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (45, 2, 0, 2, '用户编辑', NULL, '', 3, '', '', 0, 0, 0, 'user:edit', NULL, NULL, '2019-10-29 11:00:08', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (46, 2, 0, 2, '用户删除', NULL, '', 4, '', '', 0, 0, 0, 'user:del', NULL, NULL, '2019-10-29 11:00:23', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (48, 3, 0, 2, '角色创建', NULL, '', 2, '', '', 0, 0, 0, 'roles:add', NULL, NULL, '2019-10-29 12:45:34', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (49, 3, 0, 2, '角色修改', NULL, '', 3, '', '', 0, 0, 0, 'roles:edit', NULL, NULL, '2019-10-29 12:46:16', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (50, 3, 0, 2, '角色删除', NULL, '', 4, '', '', 0, 0, 0, 'roles:del', NULL, NULL, '2019-10-29 12:46:51', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (52, 5, 0, 2, '菜单新增', NULL, '', 2, '', '', 0, 0, 0, 'menu:add', NULL, NULL, '2019-10-29 12:55:07', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (53, 5, 0, 2, '菜单编辑', NULL, '', 3, '', '', 0, 0, 0, 'menu:edit', NULL, NULL, '2019-10-29 12:55:40', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (54, 5, 0, 2, '菜单删除', NULL, '', 4, '', '', 0, 0, 0, 'menu:del', NULL, NULL, '2019-10-29 12:56:00', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (56, 35, 0, 2, '部门新增', NULL, '', 2, '', '', 0, 0, 0, 'dept:add', NULL, NULL, '2019-10-29 12:57:09', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (57, 35, 0, 2, '部门编辑', NULL, '', 3, '', '', 0, 0, 0, 'dept:edit', NULL, NULL, '2019-10-29 12:57:27', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (58, 35, 0, 2, '部门删除', NULL, '', 4, '', '', 0, 0, 0, 'dept:del', NULL, NULL, '2019-10-29 12:57:41', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (60, 37, 0, 2, '岗位新增', NULL, '', 2, '', '', 0, 0, 0, 'job:add', NULL, NULL, '2019-10-29 12:58:27', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (61, 37, 0, 2, '岗位编辑', NULL, '', 3, '', '', 0, 0, 0, 'job:edit', NULL, NULL, '2019-10-29 12:58:45', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (62, 37, 0, 2, '岗位删除', NULL, '', 4, '', '', 0, 0, 0, 'job:del', NULL, NULL, '2019-10-29 12:59:04', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (64, 39, 0, 2, '字典新增', NULL, '', 2, '', '', 0, 0, 0, 'dict:add', NULL, NULL, '2019-10-29 13:00:17', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (65, 39, 0, 2, '字典编辑', NULL, '', 3, '', '', 0, 0, 0, 'dict:edit', NULL, NULL, '2019-10-29 13:00:42', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (66, 39, 0, 2, '字典删除', NULL, '', 4, '', '', 0, 0, 0, 'dict:del', NULL, NULL, '2019-10-29 13:00:59', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (73, 28, 0, 2, '任务新增', NULL, '', 2, '', '', 0, 0, 0, 'timing:add', NULL, NULL, '2019-10-29 13:07:28', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (74, 28, 0, 2, '任务编辑', NULL, '', 3, '', '', 0, 0, 0, 'timing:edit', NULL, NULL, '2019-10-29 13:07:41', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (75, 28, 0, 2, '任务删除', NULL, '', 4, '', '', 0, 0, 0, 'timing:del', NULL, NULL, '2019-10-29 13:07:54', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (77, 18, 0, 2, '上传文件', NULL, '', 2, '', '', 0, 0, 0, 'storage:add', NULL, NULL, '2019-10-29 13:09:09', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (78, 18, 0, 2, '文件编辑', NULL, '', 3, '', '', 0, 0, 0, 'storage:edit', NULL, NULL, '2019-10-29 13:09:22', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (79, 18, 0, 2, '文件删除', NULL, '', 4, '', '', 0, 0, 0, 'storage:del', NULL, NULL, '2019-10-29 13:09:34', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (80, 6, 0, 1, '服务监控', 'ServerMonitor', 'monitor/server/index', 14, 'codeConsole', 'server', 0, 0, 0, 'monitor:list', NULL, 'admin', '2019-11-07 13:06:39', '2020-05-04 18:20:50');
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (82, 36, 0, 1, '生成配置', 'GeneratorConfig', 'generator/config', 33, 'dev', 'generator/config/:tableName', 0, 1, 1, '', NULL, NULL, '2019-11-17 20:08:56', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (83, 10, 0, 1, '图表库', 'Echarts', 'components/Echarts', 50, 'chart', 'echarts', 0, 1, 0, '', NULL, NULL, '2019-11-21 09:04:32', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (90, NULL, 5, 1, '运维管理', 'Mnt', '', 20, 'mnt', 'mnt', 0, 0, 1, NULL, NULL, NULL, '2019-11-09 10:31:08', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (92, 90, 3, 1, '服务器', 'ServerDeploy', 'mnt/server/index', 22, 'server', 'mnt/serverDeploy', 0, 0, 0, 'serverDeploy:list', NULL, NULL, '2019-11-10 10:29:25', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (93, 90, 3, 1, '应用管理', 'App', 'mnt/app/index', 23, 'app', 'mnt/app', 0, 0, 0, 'app:list', NULL, NULL, '2019-11-10 11:05:16', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (94, 90, 3, 1, '部署管理', 'Deploy', 'mnt/deploy/index', 24, 'deploy', 'mnt/deploy', 0, 0, 0, 'deploy:list', NULL, NULL, '2019-11-10 15:56:55', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (97, 90, 1, 1, '部署备份', 'DeployHistory', 'mnt/deployHistory/index', 25, 'backup', 'mnt/deployHistory', 0, 0, 0, 'deployHistory:list', NULL, NULL, '2019-11-10 16:49:44', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (98, 90, 3, 1, '数据库管理', 'Database', 'mnt/database/index', 26, 'database', 'mnt/database', 0, 0, 0, 'database:list', NULL, NULL, '2019-11-10 20:40:04', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (102, 97, 0, 2, '删除', NULL, '', 999, '', '', 0, 0, 0, 'deployHistory:del', NULL, NULL, '2019-11-17 09:32:48', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (103, 92, 0, 2, '服务器新增', NULL, '', 999, '', '', 0, 0, 0, 'serverDeploy:add', NULL, NULL, '2019-11-17 11:08:33', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (104, 92, 0, 2, '服务器编辑', NULL, '', 999, '', '', 0, 0, 0, 'serverDeploy:edit', NULL, NULL, '2019-11-17 11:08:57', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (105, 92, 0, 2, '服务器删除', NULL, '', 999, '', '', 0, 0, 0, 'serverDeploy:del', NULL, NULL, '2019-11-17 11:09:15', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (106, 93, 0, 2, '应用新增', NULL, '', 999, '', '', 0, 0, 0, 'app:add', NULL, NULL, '2019-11-17 11:10:03', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (107, 93, 0, 2, '应用编辑', NULL, '', 999, '', '', 0, 0, 0, 'app:edit', NULL, NULL, '2019-11-17 11:10:28', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (108, 93, 0, 2, '应用删除', NULL, '', 999, '', '', 0, 0, 0, 'app:del', NULL, NULL, '2019-11-17 11:10:55', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (109, 94, 0, 2, '部署新增', NULL, '', 999, '', '', 0, 0, 0, 'deploy:add', NULL, NULL, '2019-11-17 11:11:22', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (110, 94, 0, 2, '部署编辑', NULL, '', 999, '', '', 0, 0, 0, 'deploy:edit', NULL, NULL, '2019-11-17 11:11:41', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (111, 94, 0, 2, '部署删除', NULL, '', 999, '', '', 0, 0, 0, 'deploy:del', NULL, NULL, '2019-11-17 11:12:01', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (112, 98, 0, 2, '数据库新增', NULL, '', 999, '', '', 0, 0, 0, 'database:add', NULL, NULL, '2019-11-17 11:12:43', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (113, 98, 0, 2, '数据库编辑', NULL, '', 999, '', '', 0, 0, 0, 'database:edit', NULL, NULL, '2019-11-17 11:12:58', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (114, 98, 0, 2, '数据库删除', NULL, '', 999, '', '', 0, 0, 0, 'database:del', NULL, NULL, '2019-11-17 11:13:14', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (116, 36, 0, 1, '生成预览', 'Preview', 'generator/preview', 999, 'java', 'generator/preview/:tableName', 0, 1, 1, NULL, NULL, NULL, '2019-11-26 14:54:36', NULL);
INSERT INTO `chimes_menu` (`menu_id`, `pid`, `sub_count`, `type`, `title`, `name`, `component`, `menu_sort`, `icon`, `path`, `i_frame`, `cache`, `hidden`, `permission`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (118, 1, NULL, 1, '权限资源', 'permission', 'system/permission/index', 11, 'permission', 'permission', 0, 0, 0, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for chimes_permission
-- ----------------------------
DROP TABLE IF EXISTS `chimes_permission`;
CREATE TABLE `chimes_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) DEFAULT NULL,
  `pid` bigint(20) NOT NULL,
  `api_pattern` varchar(255) DEFAULT NULL,
  `service_id` varchar(255) DEFAULT NULL,
  `api_method` varchar(255) DEFAULT NULL,
  `api_bypass` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_permission_service_id_t1` (`service_id`) USING BTREE,
  KEY `idx_permission_name_t2` (`name`) USING BTREE,
  KEY `idx_permission_alias_t2` (`alias`) USING BTREE,
  KEY `idx_permission_name_service_id_t4` (`name`,`service_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1354 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of chimes_permission
-- ----------------------------
BEGIN;
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1252, 'DICTDETAIL', '2022-07-01 17:03:25', '字典详情查询', 0, '/api/v1/dictdetail', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1253, 'QUERY_DICT_DETAIL_PAGED', '2022-07-01 17:03:25', '字典详情查询列表', 1252, '/api/v1/dictdetail/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1254, 'QUERY_DICT_DETAIL_QUERY', '2022-07-01 17:03:25', '字典详情查询分页', 1252, '/api/v1/dictdetail/query', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1255, 'USER', '2022-07-01 17:03:25', '用户', 0, '/api/v1/user', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1256, 'USER_SAVE', '2022-07-01 17:03:25', '用户保存', 1255, '/api/v1/user/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1257, 'USER_UPDATE', '2022-07-01 17:03:25', '用户更新', 1255, '/api/v1/user/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1258, 'USER_DELETE', '2022-07-01 17:03:25', '用户删除', 1255, '/api/v1/user/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1259, 'USER_DELETE_IDS', '2022-07-01 17:03:25', '用户批量删除', 1255, '/api/v1/user/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1260, 'USER_SEARCH', '2022-07-01 17:03:25', '用户查询', 1255, '/api/v1/user/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1261, 'USER_PAGED', '2022-07-01 17:03:25', '用户分页查询', 1255, '/api/v1/user/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1262, 'USER_GET', '2022-07-01 17:03:25', '用户获取', 1255, '/api/v1/user/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1263, 'MENU', '2022-07-01 17:03:25', '菜单', 0, '/api/v1/menu', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1264, 'MENU_SAVE', '2022-07-01 17:03:25', '菜单保存', 1263, '/api/v1/menu/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1265, 'MENU_UPDATE', '2022-07-01 17:03:25', '菜单更新', 1263, '/api/v1/menu/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1266, 'MENU_DELETE', '2022-07-01 17:03:25', '菜单删除', 1263, '/api/v1/menu/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1267, 'MENU_DELETE_IDS', '2022-07-01 17:03:25', '菜单批量删除', 1263, '/api/v1/menu/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1268, 'MENU_SEARCH', '2022-07-01 17:03:25', '菜单查询', 1263, '/api/v1/menu/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1269, 'MENU_PAGED', '2022-07-01 17:03:25', '菜单分页查询', 1263, '/api/v1/menu/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1270, 'MENU_GET', '2022-07-01 17:03:25', '菜单获取', 1263, '/api/v1/menu/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1271, 'MENU_TREE', '2022-07-01 17:03:25', '菜单树形查询', 1263, '/api/v1/menu/tree', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1272, 'PERMISSION', '2022-07-01 17:03:25', '权限资源', 0, '/api/v1/permission', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1273, 'PERMISSION_SAVE', '2022-07-01 17:03:25', '权限资源保存', 1272, '/api/v1/permission/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1274, 'PERMISSION_UPDATE', '2022-07-01 17:03:25', '权限资源更新', 1272, '/api/v1/permission/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1275, 'PERMISSION_DELETE', '2022-07-01 17:03:25', '权限资源删除', 1272, '/api/v1/permission/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1276, 'PERMISSION_DELETE_IDS', '2022-07-01 17:03:25', '权限资源批量删除', 1272, '/api/v1/permission/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1277, 'PERMISSION_SEARCH', '2022-07-01 17:03:25', '权限资源查询', 1272, '/api/v1/permission/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1278, 'PERMISSION_PAGED', '2022-07-01 17:03:25', '权限资源分页查询', 1272, '/api/v1/permission/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1279, 'PERMISSION_GET', '2022-07-01 17:03:25', '权限资源获取', 1272, '/api/v1/permission/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1280, 'PERMISSION_TREE', '2022-07-01 17:03:25', '权限资源树形查询', 1272, '/api/v1/permission/tree', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1281, 'ROLE', '2022-07-01 17:03:25', '角色', 0, '/api/v1/role', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1282, 'ROLE_SAVE', '2022-07-01 17:03:25', '角色保存', 1281, '/api/v1/role/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1283, 'ROLE_UPDATE', '2022-07-01 17:03:25', '角色更新', 1281, '/api/v1/role/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1284, 'ROLE_DELETE', '2022-07-01 17:03:25', '角色删除', 1281, '/api/v1/role/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1285, 'ROLE_DELETE_IDS', '2022-07-01 17:03:25', '角色批量删除', 1281, '/api/v1/role/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1286, 'ROLE_SEARCH', '2022-07-01 17:03:25', '角色查询', 1281, '/api/v1/role/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1287, 'ROLE_PAGED', '2022-07-01 17:03:25', '角色分页查询', 1281, '/api/v1/role/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1288, 'ROLE_GET', '2022-07-01 17:03:25', '角色获取', 1281, '/api/v1/role/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1289, 'DEPT', '2022-07-01 17:03:25', '部门', 0, '/api/v1/dept', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1290, 'DEPT_SAVE', '2022-07-01 17:03:25', '部门保存', 1289, '/api/v1/dept/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1291, 'DEPT_UPDATE', '2022-07-01 17:03:25', '部门更新', 1289, '/api/v1/dept/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1292, 'DEPT_DELETE', '2022-07-01 17:03:25', '部门删除', 1289, '/api/v1/dept/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1293, 'DEPT_DELETE_IDS', '2022-07-01 17:03:25', '部门批量删除', 1289, '/api/v1/dept/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1294, 'DEPT_SEARCH', '2022-07-01 17:03:25', '部门查询', 1289, '/api/v1/dept/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1295, 'DEPT_PAGED', '2022-07-01 17:03:25', '部门分页查询', 1289, '/api/v1/dept/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1296, 'DEPT_GET', '2022-07-01 17:03:25', '部门获取', 1289, '/api/v1/dept/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1297, 'DEPT_TREE', '2022-07-01 17:03:25', '部门树形查询', 1289, '/api/v1/dept/tree', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1298, 'JOB', '2022-07-01 17:03:25', '岗位', 0, '/api/v1/job', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1299, 'JOB_SAVE', '2022-07-01 17:03:25', '岗位保存', 1298, '/api/v1/job/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1300, 'JOB_UPDATE', '2022-07-01 17:03:25', '岗位更新', 1298, '/api/v1/job/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1301, 'JOB_DELETE', '2022-07-01 17:03:25', '岗位删除', 1298, '/api/v1/job/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1302, 'JOB_DELETE_IDS', '2022-07-01 17:03:25', '岗位批量删除', 1298, '/api/v1/job/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1303, 'JOB_SEARCH', '2022-07-01 17:03:25', '岗位查询', 1298, '/api/v1/job/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1304, 'JOB_PAGED', '2022-07-01 17:03:25', '岗位分页查询', 1298, '/api/v1/job/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1305, 'JOB_GET', '2022-07-01 17:03:25', '岗位获取', 1298, '/api/v1/job/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1306, 'DICT', '2022-07-01 17:03:25', '字典', 0, '/api/v1/dict', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1307, 'DICT_SAVE', '2022-07-01 17:03:25', '字典保存', 1306, '/api/v1/dict/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1308, 'DICT_UPDATE', '2022-07-01 17:03:25', '字典更新', 1306, '/api/v1/dict/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1309, 'DICT_DELETE', '2022-07-01 17:03:25', '字典删除', 1306, '/api/v1/dict/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1310, 'DICT_DELETE_IDS', '2022-07-01 17:03:25', '字典批量删除', 1306, '/api/v1/dict/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1311, 'DICT_SEARCH', '2022-07-01 17:03:25', '字典查询', 1306, '/api/v1/dict/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1312, 'DICT_PAGED', '2022-07-01 17:03:25', '字典分页查询', 1306, '/api/v1/dict/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1313, 'DICT_GET', '2022-07-01 17:03:25', '字典获取', 1306, '/api/v1/dict/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1314, 'DICT_DETAIL', '2022-07-01 17:03:25', '字典详情', 0, '/api/v1/dict_detail', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1315, 'DICT_DETAIL_SAVE', '2022-07-01 17:03:25', '字典详情保存', 1314, '/api/v1/dict_detail/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1316, 'DICT_DETAIL_UPDATE', '2022-07-01 17:03:25', '字典详情更新', 1314, '/api/v1/dict_detail/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1317, 'DICT_DETAIL_DELETE', '2022-07-01 17:03:25', '字典详情删除', 1314, '/api/v1/dict_detail/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1318, 'DICT_DETAIL_DELETE_IDS', '2022-07-01 17:03:25', '字典详情批量删除', 1314, '/api/v1/dict_detail/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1319, 'DICT_DETAIL_SEARCH', '2022-07-01 17:03:25', '字典详情查询', 1314, '/api/v1/dict_detail/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1320, 'DICT_DETAIL_PAGED', '2022-07-01 17:03:25', '字典详情分页查询', 1314, '/api/v1/dict_detail/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1321, 'DICT_DETAIL_GET', '2022-07-01 17:03:25', '字典详情获取', 1314, '/api/v1/dict_detail/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1322, 'LOGS', '2022-07-01 17:03:25', '日志', 0, '/api/v1/logs', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1323, 'LOGS_SAVE', '2022-07-01 17:03:25', '日志保存', 1322, '/api/v1/logs/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1324, 'LOGS_UPDATE', '2022-07-01 17:03:25', '日志更新', 1322, '/api/v1/logs/update', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1325, 'LOGS_DELETE', '2022-07-01 17:03:25', '日志删除', 1322, '/api/v1/logs/delete', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1326, 'LOGS_DELETE_IDS', '2022-07-01 17:03:25', '日志批量删除', 1322, '/api/v1/logs/delete_ids', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1327, 'LOGS_SEARCH', '2022-07-01 17:03:25', '日志查询', 1322, '/api/v1/logs/search', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1328, 'LOGS_PAGED', '2022-07-01 17:03:25', '日志分页查询', 1322, '/api/v1/logs/paged/{current}/{size}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1329, 'LOGS_GET', '2022-07-01 17:03:25', '日志获取', 1322, '/api/v1/logs/get/{id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1330, 'USER_ROLES', '2022-07-01 17:03:25', '用户角色关系', 0, '/api/v1/user_roles', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1331, 'USER_ROLES_REL_LOAD', '2022-07-01 17:03:25', '用户角色关系加载', 1330, '/api/v1/user_roles/load/{user_id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1332, 'USER_ROLES_REL_REMOVE', '2022-07-01 17:03:25', '用户角色关系删除', 1330, '/api/v1/user_roles/remove/{user_id}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1333, 'USER_ROLES_REL_SAVE', '2022-07-01 17:03:25', '用户角色关系保存', 1330, '/api/v1/user_roles/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1334, 'ROLE_MENUS', '2022-07-01 17:03:25', '角色菜单功能关系', 0, '/api/v1/role_menus', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1335, 'ROLE_MENUS_REL_LOAD', '2022-07-01 17:03:25', '角色菜单功能关系加载', 1334, '/api/v1/role_menus/load/{role_id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1336, 'ROLE_MENUS_REL_REMOVE', '2022-07-01 17:03:25', '角色菜单功能关系删除', 1334, '/api/v1/role_menus/remove/{role_id}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1337, 'ROLE_MENUS_REL_SAVE', '2022-07-01 17:03:25', '角色菜单功能关系保存', 1334, '/api/v1/role_menus/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1338, 'USER_DETAIL_INFO', '2022-07-01 17:03:25', '用户详情信息', 0, '/api/v1/user_detail_info', 'chimes-rust', NULL, NULL);
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1339, 'USER_DETAIL_INFO_REL_LOAD', '2022-07-01 17:03:25', '用户详情信息加载', 1338, '/api/v1/user_detail_info/load/{user_id}', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1340, 'USER_DETAIL_INFO_REL_REMOVE', '2022-07-01 17:03:25', '用户详情信息删除', 1338, '/api/v1/user_detail_info/remove/{user_id}', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1341, 'USER_DETAIL_INFO_REL_SAVE', '2022-07-01 17:03:25', '用户详情信息保存', 1338, '/api/v1/user_detail_info/save', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1342, 'AUTH_INFO', '2022-07-01 18:32:46', '当前用户认证信息', 0, '/api/v1/auth/info', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1343, 'MENU_BUILD', '2022-07-01 18:35:33', '构建用户菜单树', 1263, '/api/v1/menus/build', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1344, 'MENU_SUPERIOR', '2022-07-01 18:37:06', '菜单树构建', 1263, '/api/v1/menu/superior', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1345, 'ROLE_LEVEL', '2022-07-01 18:40:03', '角色级别', 1281, '/api/v1/role/level', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1346, 'DEPT_SUPERIOR', '2022-07-01 18:40:43', '部门级数', 1289, '/api/v1/dept/superior', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1347, 'PERMISSION_CHILDREN', '2022-07-01 18:42:18', '资源子级', 1272, '/api/v1/permission/children', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1348, 'MENU_CHILDREN', '2022-07-01 18:43:17', '菜单子级', 1263, '/api/v1/menu/children', 'chimes-rust', 'GET', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1349, 'USER_CENTER_UPDATE', '2022-07-02 14:20:46', '用户修改资料', 1255, '/api/v1/user/center/update/info', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1350, 'USER_CENTER_UPDATE_PWD', '2022-07-02 14:21:38', '用户修改密码', 1255, '/api/v1/user/center/update/pwd', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1351, 'USER_CENTER_UPDATE_EMAIL', '2022-07-02 14:22:32', '用户修改邮箱', 1255, '/api/v1/user/center/update/email', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1352, 'USER_CENTER_UPDATE_AVATAR', '2022-07-02 14:23:18', '用户修改头像', 1255, '/api/v1/user/center/update/avatar', 'chimes-rust', 'POST', 'user');
INSERT INTO `chimes_permission` (`id`, `alias`, `create_time`, `name`, `pid`, `api_pattern`, `service_id`, `api_method`, `api_bypass`) VALUES (1353, 'USER_AVATAR', '2022-07-02 19:39:50', '用户头像', 1255, '/api/v1/avatar/{filename}', 'chimes-rust', 'GET', 'anonymous');
COMMIT;

-- ----------------------------
-- Table structure for chimes_profile
-- ----------------------------
DROP TABLE IF EXISTS `chimes_profile`;
CREATE TABLE `chimes_profile` (
  `user_id` bigint(20) NOT NULL,
  `full_name` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `education` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `birth_day` date DEFAULT NULL,
  `create_date` datetime(6) DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of chimes_profile
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chimes_role
-- ----------------------------
DROP TABLE IF EXISTS `chimes_role`;
CREATE TABLE `chimes_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `role_code` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '角色代码',
  `level` int(11) DEFAULT NULL COMMENT '角色级别',
  `description` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '描述',
  `data_scope` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据权限',
  `create_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`name`),
  UNIQUE KEY `chimes_role_UN` (`role_code`),
  KEY `role_name_index` (`name`),
  KEY `chimes_role_role_code_IDX` (`role_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of chimes_role
-- ----------------------------
BEGIN;
INSERT INTO `chimes_role` (`role_id`, `name`, `role_code`, `level`, `description`, `data_scope`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (1, '超级管理员', 'admin', 1, '-', '全部', NULL, 'admin', '2018-11-23 11:04:37', '2020-08-06 16:10:24');
INSERT INTO `chimes_role` (`role_id`, `name`, `role_code`, `level`, `description`, `data_scope`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES (2, '普通用户', 'user', 2, '-', '本级', NULL, 'admin', '2018-11-23 13:09:06', '2020-09-05 10:45:12');
COMMIT;

-- ----------------------------
-- Table structure for chimes_roles_depts
-- ----------------------------
DROP TABLE IF EXISTS `chimes_roles_depts`;
CREATE TABLE `chimes_roles_depts` (
  `role_id` bigint(20) NOT NULL,
  `dept_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE,
  KEY `FK7qg6itn5ajdoa9h9o78v9ksur` (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='角色部门关联';

-- ----------------------------
-- Records of chimes_roles_depts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chimes_roles_menus
-- ----------------------------
DROP TABLE IF EXISTS `chimes_roles_menus`;
CREATE TABLE `chimes_roles_menus` (
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`menu_id`,`role_id`) USING BTREE,
  KEY `FKcngg2qadojhi3a651a5adkvbq` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='角色菜单关联';

-- ----------------------------
-- Records of chimes_roles_menus
-- ----------------------------
BEGIN;
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (1, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (2, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (3, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (5, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (6, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (7, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (9, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (10, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (11, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (14, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (15, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (18, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (19, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (21, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (22, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (23, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (24, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (27, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (28, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (30, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (32, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (33, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (34, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (35, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (36, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (37, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (38, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (39, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (41, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (44, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (45, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (46, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (48, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (49, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (50, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (52, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (53, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (54, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (56, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (57, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (58, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (60, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (61, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (62, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (64, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (65, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (66, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (73, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (74, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (75, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (77, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (78, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (79, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (80, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (82, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (83, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (90, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (92, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (93, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (94, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (97, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (98, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (102, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (103, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (104, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (105, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (106, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (107, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (108, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (109, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (110, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (111, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (112, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (113, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (114, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (116, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (118, 1);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (1, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (2, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (10, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (11, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (14, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (15, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (19, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (21, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (22, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (23, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (24, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (27, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (30, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (32, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (33, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (34, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (36, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (80, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (82, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (83, 2);
INSERT INTO `chimes_roles_menus` (`menu_id`, `role_id`) VALUES (116, 2);
COMMIT;

-- ----------------------------
-- Table structure for chimes_roles_permissions
-- ----------------------------
DROP TABLE IF EXISTS `chimes_roles_permissions`;
CREATE TABLE `chimes_roles_permissions` (
  `role_id` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL COMMENT 'PermissionID',
  PRIMARY KEY (`role_id`,`id`) USING BTREE,
  KEY `fkrkpanhruga5fqej10nnuyghj3` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of chimes_roles_permissions
-- ----------------------------
BEGIN;
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1252);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1252);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1253);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1253);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1254);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1254);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1255);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1255);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1256);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1256);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1257);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1257);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1258);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1258);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1259);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1259);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1260);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1260);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1261);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1261);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1262);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1262);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1263);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1263);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1264);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1264);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1265);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1265);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1266);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1266);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1267);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1267);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1268);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1268);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1269);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1269);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1270);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1270);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1271);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1271);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1272);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1272);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1273);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1273);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1274);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1274);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1275);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1275);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1276);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1276);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1277);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1277);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1278);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1278);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1279);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1279);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1280);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1280);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1281);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1281);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1282);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1282);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1283);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1283);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1284);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1284);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1285);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1285);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1286);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1286);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1287);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1287);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1288);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1288);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1289);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1289);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1290);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1290);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1291);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1291);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1292);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1292);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1293);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1293);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1294);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1294);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1295);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1295);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1296);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1296);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1297);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1297);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1298);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1298);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1299);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1299);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1300);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1300);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1301);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1301);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1302);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1302);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1303);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1303);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1304);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1304);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1305);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1305);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1306);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1306);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1307);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1307);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1308);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1308);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1309);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1309);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1310);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1310);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1311);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1311);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1312);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1312);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1313);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1313);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1314);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1314);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1315);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1315);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1316);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1316);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1317);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1317);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1318);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1318);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1319);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1319);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1320);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1320);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1321);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1321);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1322);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1322);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1323);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1323);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1324);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1324);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1325);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1325);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1326);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1326);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1327);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1327);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1328);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1328);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1329);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1329);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1330);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1330);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1331);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1331);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1332);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1332);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1333);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1333);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1334);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1334);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1335);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1335);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1336);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1336);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1337);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1337);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1338);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1338);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1339);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1339);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1340);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1340);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1341);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (2, 1341);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1342);
INSERT INTO `chimes_roles_permissions` (`role_id`, `id`) VALUES (1, 1343);
COMMIT;

-- ----------------------------
-- Table structure for chimes_user
-- ----------------------------
DROP TABLE IF EXISTS `chimes_user`;
CREATE TABLE `chimes_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门名称',
  `username` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '用户名',
  `nick_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '昵称',
  `gender` varchar(2) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
  `avatar_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像地址',
  `avatar_path` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像真实路径',
  `password` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '密码',
  `is_admin` tinyint(1) DEFAULT '0' COMMENT '是否为admin账号',
  `enabled` int(11) DEFAULT NULL COMMENT '状态：1启用、0禁用',
  `create_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '更新者',
  `pwd_reset_time` datetime DEFAULT NULL COMMENT '修改密码的时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `UK_kpubos9gc2cvtkb0thktkbkes` (`email`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`),
  KEY `FK5rwmryny6jthaaxkogownknqp` (`dept_id`) USING BTREE,
  KEY `FKpq2dhypk2qgt68nauh2by22jb` (`avatar_name`) USING BTREE,
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of chimes_user
-- ----------------------------
BEGIN;
INSERT INTO `chimes_user` (`user_id`, `dept_id`, `username`, `nick_name`, `gender`, `phone`, `email`, `avatar_name`, `avatar_path`, `password`, `is_admin`, `enabled`, `create_by`, `update_by`, `pwd_reset_time`, `create_time`, `update_time`) VALUES (1, 2, 'admin', 'Administrator', '男', '18888888888', 'longzou@hotmail.com', '181bec134b4_385759961688444928.png', 'D:/temp/files/181bec134b4_385759961688444928.png', 'BQMVzBbbKUfJ6QQ5ix3EMyFQ5n/rPYyj2qQ4OlET3edST+GhoJ4/dVMJ0Rp4OmDu0Ualf5Mk9icyaW2+/ArwVg==', 1, 1, NULL, 'admin', '2020-05-03 16:38:31', '2018-08-23 09:11:56', '2020-09-05 10:43:31');
INSERT INTO `chimes_user` (`user_id`, `dept_id`, `username`, `nick_name`, `gender`, `phone`, `email`, `avatar_name`, `avatar_path`, `password`, `is_admin`, `enabled`, `create_by`, `update_by`, `pwd_reset_time`, `create_time`, `update_time`) VALUES (2, 17, 'test1', '测试1', '男', '19999999998', '2231@qq.com', NULL, NULL, 'BQMVzBbbKUfJ6QQ5ix3EMyFQ5n/rPYyj2qQ4OlET3edST+GhoJ4/dVMJ0Rp4OmDu0Ualf5Mk9icyaW2+/ArwVg==', 0, 1, 'admin', 'admin', NULL, '2020-05-05 11:15:49', '2020-09-05 10:43:38');
COMMIT;

-- ----------------------------
-- Table structure for chimes_users_jobs
-- ----------------------------
DROP TABLE IF EXISTS `chimes_users_jobs`;
CREATE TABLE `chimes_users_jobs` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `job_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of chimes_users_jobs
-- ----------------------------
BEGIN;
INSERT INTO `chimes_users_jobs` (`user_id`, `job_id`) VALUES (1, 11);
INSERT INTO `chimes_users_jobs` (`user_id`, `job_id`) VALUES (2, 10);
INSERT INTO `chimes_users_jobs` (`user_id`, `job_id`) VALUES (2, 11);
COMMIT;

-- ----------------------------
-- Table structure for chimes_users_roles
-- ----------------------------
DROP TABLE IF EXISTS `chimes_users_roles`;
CREATE TABLE `chimes_users_roles` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `FKq4eq273l04bpu4efj0jd0jb98` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户角色关联';

-- ----------------------------
-- Records of chimes_users_roles
-- ----------------------------
BEGIN;
INSERT INTO `chimes_users_roles` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `chimes_users_roles` (`user_id`, `role_id`) VALUES (2, 1);
INSERT INTO `chimes_users_roles` (`user_id`, `role_id`) VALUES (2, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
