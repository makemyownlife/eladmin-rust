-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: chimesrust
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chimes_dept`
--

DROP TABLE IF EXISTS `chimes_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` bigint DEFAULT NULL COMMENT '上级部门',
  `sub_count` int DEFAULT '0' COMMENT '子部门数目',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `dept_sort` int DEFAULT '999' COMMENT '排序',
  `enabled` tinyint(1) NOT NULL COMMENT '状态',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE,
  KEY `inx_pid` (`pid`),
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='部门';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_dept`
--

LOCK TABLES `chimes_dept` WRITE;
/*!40000 ALTER TABLE `chimes_dept` DISABLE KEYS */;
INSERT INTO `chimes_dept` VALUES (2,7,1,'研发部',3,1,'admin','admin','2019-03-25 09:15:32','2020-08-02 14:48:47'),(5,7,0,'运维部',4,1,'admin','admin','2019-03-25 09:20:44','2020-05-17 14:27:27'),(6,8,0,'测试部',6,1,'admin','admin','2019-03-25 09:52:18','2020-06-08 11:59:21'),(7,NULL,2,'华南分部',0,1,'admin','admin','2019-03-25 11:04:50','2020-06-08 12:08:56'),(8,NULL,2,'华北分部',1,1,'admin','admin','2019-03-25 11:04:53','2020-05-14 12:54:00'),(17,8,0,'研发一组',999,1,'admin','admin','2020-08-02 14:49:07','2020-08-02 14:49:07');
/*!40000 ALTER TABLE `chimes_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_dict`
--

DROP TABLE IF EXISTS `chimes_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_dict` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '字典名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='数据字典';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_dict`
--

LOCK TABLES `chimes_dict` WRITE;
/*!40000 ALTER TABLE `chimes_dict` DISABLE KEYS */;
INSERT INTO `chimes_dict` VALUES (1,'user_status','用户状态',NULL,NULL,'2019-10-27 20:31:36',NULL),(4,'dept_status','部门状态',NULL,NULL,'2019-10-27 20:31:36',NULL),(5,'job_status','岗位状态',NULL,NULL,'2019-10-27 20:31:36',NULL);
/*!40000 ALTER TABLE `chimes_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_dict_detail`
--

DROP TABLE IF EXISTS `chimes_dict_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_dict_detail` (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dict_id` bigint DEFAULT NULL COMMENT '字典id',
  `label` varchar(255) NOT NULL COMMENT '字典标签',
  `value` varchar(255) NOT NULL COMMENT '字典值',
  `dict_sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`detail_id`) USING BTREE,
  KEY `FK5tpkputc6d9nboxojdbgnpmyb` (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='数据字典详情';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_dict_detail`
--

LOCK TABLES `chimes_dict_detail` WRITE;
/*!40000 ALTER TABLE `chimes_dict_detail` DISABLE KEYS */;
INSERT INTO `chimes_dict_detail` VALUES (1,1,'激活','true',3,NULL,NULL,'2019-10-27 20:31:36',NULL),(2,1,'禁用','false',2,NULL,NULL,NULL,NULL),(3,4,'启用','true',1,NULL,NULL,NULL,NULL),(4,4,'停用','false',2,NULL,NULL,'2019-10-27 20:31:36',NULL),(5,5,'启用','true',1,NULL,NULL,NULL,NULL),(6,5,'停用','false',2,NULL,NULL,'2019-10-27 20:31:36',NULL),(10,NULL,'未知','unknow',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `chimes_dict_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_job`
--

DROP TABLE IF EXISTS `chimes_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '岗位名称',
  `enabled` tinyint(1) NOT NULL COMMENT '岗位状态',
  `job_sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`job_id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`name`),
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='岗位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_job`
--

LOCK TABLES `chimes_job` WRITE;
/*!40000 ALTER TABLE `chimes_job` DISABLE KEYS */;
INSERT INTO `chimes_job` VALUES (8,'人事专员',1,3,NULL,NULL,'2019-03-29 14:52:28',NULL),(10,'产品经理',1,4,NULL,NULL,'2019-03-29 14:55:51',NULL),(11,'全栈开发',1,2,NULL,'admin','2019-03-31 13:39:30','2020-05-05 11:33:43'),(12,'软件测试',1,5,NULL,'admin','2019-03-31 13:39:43','2020-05-10 19:56:26');
/*!40000 ALTER TABLE `chimes_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_log`
--

DROP TABLE IF EXISTS `chimes_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `description` varchar(255) DEFAULT NULL,
  `log_type` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `params` text,
  `request_ip` varchar(255) DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `exception_detail` text,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `log_create_time_index` (`create_time`),
  KEY `inx_log_type` (`log_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3537 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='系统日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_log`
--

LOCK TABLES `chimes_log` WRITE;
/*!40000 ALTER TABLE `chimes_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `chimes_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_menu`
--

DROP TABLE IF EXISTS `chimes_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` bigint DEFAULT NULL COMMENT '上级菜单ID',
  `sub_count` int DEFAULT '0' COMMENT '子菜单数目',
  `type` int DEFAULT NULL COMMENT '菜单类型',
  `title` varchar(255) DEFAULT NULL COMMENT '菜单标题',
  `name` varchar(255) DEFAULT NULL COMMENT '组件名称',
  `component` varchar(255) DEFAULT NULL COMMENT '组件',
  `menu_sort` int DEFAULT NULL COMMENT '排序',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `path` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `i_frame` tinyint(1) DEFAULT NULL COMMENT '是否外链',
  `cache` tinyint(1) DEFAULT '0' COMMENT '缓存',
  `hidden` tinyint(1) DEFAULT '0' COMMENT '隐藏',
  `permission` varchar(255) DEFAULT NULL COMMENT '权限',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`menu_id`) USING BTREE,
  UNIQUE KEY `uniq_title` (`title`),
  UNIQUE KEY `uniq_name` (`name`),
  KEY `inx_pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='系统菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_menu`
--

LOCK TABLES `chimes_menu` WRITE;
/*!40000 ALTER TABLE `chimes_menu` DISABLE KEYS */;
INSERT INTO `chimes_menu` VALUES (1,NULL,7,0,'系统管理',NULL,NULL,1,'system','system',0,0,0,NULL,NULL,NULL,'2018-12-18 15:11:29',NULL),(2,1,3,1,'用户管理','User','system/user/index',2,'peoples','user',0,0,0,'user:list',NULL,NULL,'2018-12-18 15:14:44',NULL),(3,1,3,1,'角色管理','Role','system/role/index',3,'role','role',0,0,0,'roles:list',NULL,NULL,'2018-12-18 15:16:07',NULL),(5,1,3,1,'菜单管理','Menu','system/menu/index',5,'menu','menu',0,0,0,'menu:list',NULL,NULL,'2018-12-18 15:17:28',NULL),(6,NULL,5,0,'系统监控',NULL,NULL,10,'monitor','monitor',0,0,0,NULL,NULL,NULL,'2018-12-18 15:17:48',NULL),(7,6,0,1,'操作日志','Log','monitor/log/index',11,'log','logs',0,1,0,NULL,NULL,'admin','2018-12-18 15:18:26','2020-06-06 13:11:57'),(9,6,0,1,'SQL监控','Sql','monitor/sql/index',18,'sqlMonitor','druid',0,0,0,NULL,NULL,NULL,'2018-12-18 15:19:34',NULL),(10,NULL,5,0,'组件管理',NULL,NULL,50,'zujian','components',0,0,1,NULL,NULL,NULL,'2018-12-19 13:38:16',NULL),(11,10,0,1,'图标库','Icons','components/icons/index',51,'icon','icon',0,0,0,NULL,NULL,NULL,'2018-12-19 13:38:49',NULL),(14,36,0,1,'邮件工具','Email','tools/email/index',35,'email','email',0,0,0,NULL,NULL,NULL,'2018-12-27 10:13:09',NULL),(15,10,0,1,'富文本','Editor','components/Editor',52,'fwb','tinymce',0,0,0,NULL,NULL,NULL,'2018-12-27 11:58:25',NULL),(18,36,3,1,'存储管理','Storage','tools/storage/index',34,'qiniu','storage',0,0,0,'storage:list',NULL,NULL,'2018-12-31 11:12:15',NULL),(19,36,0,1,'支付宝工具','AliPay','tools/aliPay/index',37,'alipay','aliPay',0,0,0,NULL,NULL,NULL,'2018-12-31 14:52:38',NULL),(21,NULL,2,0,'多级菜单',NULL,'',900,'menu','nested',0,0,1,NULL,NULL,'admin','2019-01-04 16:22:03','2020-06-21 17:27:35'),(22,21,2,0,'二级菜单1',NULL,'',999,'menu','menu1',0,0,0,NULL,NULL,'admin','2019-01-04 16:23:29','2020-06-21 17:27:20'),(23,21,0,1,'二级菜单2',NULL,'nested/menu2/index',999,'menu','menu2',0,0,0,NULL,NULL,NULL,'2019-01-04 16:23:57',NULL),(24,22,0,1,'三级菜单1','Test','nested/menu1/menu1-1',999,'menu','menu1-1',0,0,0,NULL,NULL,NULL,'2019-01-04 16:24:48',NULL),(27,22,0,1,'三级菜单2',NULL,'nested/menu1/menu1-2',999,'menu','menu1-2',0,0,0,NULL,NULL,NULL,'2019-01-07 17:27:32',NULL),(28,1,3,1,'任务调度','Timing','system/timing/index',999,'timing','timing',0,0,1,'timing:list',NULL,NULL,'2019-01-07 20:34:40',NULL),(30,36,0,1,'代码生成','GeneratorIndex','generator/index',32,'dev','generator',0,1,0,NULL,NULL,NULL,'2019-01-11 15:45:55',NULL),(32,6,0,1,'异常日志','ErrorLog','monitor/log/errorLog',12,'error','errorLog',0,0,0,NULL,NULL,NULL,'2019-01-13 13:49:03',NULL),(33,10,0,1,'Markdown','Markdown','components/MarkDown',53,'markdown','markdown',0,0,0,NULL,NULL,NULL,'2019-03-08 13:46:44',NULL),(34,10,0,1,'Yaml编辑器','YamlEdit','components/YamlEdit',54,'dev','yaml',0,0,0,NULL,NULL,NULL,'2019-03-08 15:49:40',NULL),(35,1,3,1,'部门管理','Dept','system/dept/index',6,'dept','dept',0,0,0,'dept:list',NULL,NULL,'2019-03-25 09:46:00',NULL),(36,NULL,7,0,'系统工具',NULL,'',30,'sys-tools','sys-tools',0,0,1,NULL,NULL,NULL,'2019-03-29 10:57:35',NULL),(37,1,3,1,'岗位管理','Job','system/job/index',7,'Steve-Jobs','job',0,0,0,'job:list',NULL,NULL,'2019-03-29 13:51:18',NULL),(38,36,0,1,'接口文档','Swagger','tools/swagger/index',36,'swagger','swagger2',0,0,0,NULL,NULL,NULL,'2019-03-29 19:57:53',NULL),(39,1,3,1,'字典管理','Dict','system/dict/index',8,'dictionary','dict',0,0,0,'dict:list',NULL,NULL,'2019-04-10 11:49:04',NULL),(41,6,0,1,'在线用户','OnlineUser','monitor/online/index',10,'Steve-Jobs','online',0,0,0,NULL,NULL,NULL,'2019-10-26 22:08:43',NULL),(44,2,0,2,'用户新增',NULL,'',2,'','',0,0,0,'user:add',NULL,NULL,'2019-10-29 10:59:46',NULL),(45,2,0,2,'用户编辑',NULL,'',3,'','',0,0,0,'user:edit',NULL,NULL,'2019-10-29 11:00:08',NULL),(46,2,0,2,'用户删除',NULL,'',4,'','',0,0,0,'user:del',NULL,NULL,'2019-10-29 11:00:23',NULL),(48,3,0,2,'角色创建',NULL,'',2,'','',0,0,0,'roles:add',NULL,NULL,'2019-10-29 12:45:34',NULL),(49,3,0,2,'角色修改',NULL,'',3,'','',0,0,0,'roles:edit',NULL,NULL,'2019-10-29 12:46:16',NULL),(50,3,0,2,'角色删除',NULL,'',4,'','',0,0,0,'roles:del',NULL,NULL,'2019-10-29 12:46:51',NULL),(52,5,0,2,'菜单新增',NULL,'',2,'','',0,0,0,'menu:add',NULL,NULL,'2019-10-29 12:55:07',NULL),(53,5,0,2,'菜单编辑',NULL,'',3,'','',0,0,0,'menu:edit',NULL,NULL,'2019-10-29 12:55:40',NULL),(54,5,0,2,'菜单删除',NULL,'',4,'','',0,0,0,'menu:del',NULL,NULL,'2019-10-29 12:56:00',NULL),(56,35,0,2,'部门新增',NULL,'',2,'','',0,0,0,'dept:add',NULL,NULL,'2019-10-29 12:57:09',NULL),(57,35,0,2,'部门编辑',NULL,'',3,'','',0,0,0,'dept:edit',NULL,NULL,'2019-10-29 12:57:27',NULL),(58,35,0,2,'部门删除',NULL,'',4,'','',0,0,0,'dept:del',NULL,NULL,'2019-10-29 12:57:41',NULL),(60,37,0,2,'岗位新增',NULL,'',2,'','',0,0,0,'job:add',NULL,NULL,'2019-10-29 12:58:27',NULL),(61,37,0,2,'岗位编辑',NULL,'',3,'','',0,0,0,'job:edit',NULL,NULL,'2019-10-29 12:58:45',NULL),(62,37,0,2,'岗位删除',NULL,'',4,'','',0,0,0,'job:del',NULL,NULL,'2019-10-29 12:59:04',NULL),(64,39,0,2,'字典新增',NULL,'',2,'','',0,0,0,'dict:add',NULL,NULL,'2019-10-29 13:00:17',NULL),(65,39,0,2,'字典编辑',NULL,'',3,'','',0,0,0,'dict:edit',NULL,NULL,'2019-10-29 13:00:42',NULL),(66,39,0,2,'字典删除',NULL,'',4,'','',0,0,0,'dict:del',NULL,NULL,'2019-10-29 13:00:59',NULL),(73,28,0,2,'任务新增',NULL,'',2,'','',0,0,0,'timing:add',NULL,NULL,'2019-10-29 13:07:28',NULL),(74,28,0,2,'任务编辑',NULL,'',3,'','',0,0,0,'timing:edit',NULL,NULL,'2019-10-29 13:07:41',NULL),(75,28,0,2,'任务删除',NULL,'',4,'','',0,0,0,'timing:del',NULL,NULL,'2019-10-29 13:07:54',NULL),(77,18,0,2,'上传文件',NULL,'',2,'','',0,0,0,'storage:add',NULL,NULL,'2019-10-29 13:09:09',NULL),(78,18,0,2,'文件编辑',NULL,'',3,'','',0,0,0,'storage:edit',NULL,NULL,'2019-10-29 13:09:22',NULL),(79,18,0,2,'文件删除',NULL,'',4,'','',0,0,0,'storage:del',NULL,NULL,'2019-10-29 13:09:34',NULL),(80,6,0,1,'服务监控','ServerMonitor','monitor/server/index',14,'codeConsole','server',0,0,0,'monitor:list',NULL,'admin','2019-11-07 13:06:39','2020-05-04 18:20:50'),(82,36,0,1,'生成配置','GeneratorConfig','generator/config',33,'dev','generator/config/:tableName',0,1,1,'',NULL,NULL,'2019-11-17 20:08:56',NULL),(83,10,0,1,'图表库','Echarts','components/Echarts',50,'chart','echarts',0,1,0,'',NULL,NULL,'2019-11-21 09:04:32',NULL),(90,NULL,5,1,'运维管理','Mnt','',20,'mnt','mnt',0,0,1,NULL,NULL,NULL,'2019-11-09 10:31:08',NULL),(92,90,3,1,'服务器','ServerDeploy','mnt/server/index',22,'server','mnt/serverDeploy',0,0,0,'serverDeploy:list',NULL,NULL,'2019-11-10 10:29:25',NULL),(93,90,3,1,'应用管理','App','mnt/app/index',23,'app','mnt/app',0,0,0,'app:list',NULL,NULL,'2019-11-10 11:05:16',NULL),(94,90,3,1,'部署管理','Deploy','mnt/deploy/index',24,'deploy','mnt/deploy',0,0,0,'deploy:list',NULL,NULL,'2019-11-10 15:56:55',NULL),(97,90,1,1,'部署备份','DeployHistory','mnt/deployHistory/index',25,'backup','mnt/deployHistory',0,0,0,'deployHistory:list',NULL,NULL,'2019-11-10 16:49:44',NULL),(98,90,3,1,'数据库管理','Database','mnt/database/index',26,'database','mnt/database',0,0,0,'database:list',NULL,NULL,'2019-11-10 20:40:04',NULL),(102,97,0,2,'删除',NULL,'',999,'','',0,0,0,'deployHistory:del',NULL,NULL,'2019-11-17 09:32:48',NULL),(103,92,0,2,'服务器新增',NULL,'',999,'','',0,0,0,'serverDeploy:add',NULL,NULL,'2019-11-17 11:08:33',NULL),(104,92,0,2,'服务器编辑',NULL,'',999,'','',0,0,0,'serverDeploy:edit',NULL,NULL,'2019-11-17 11:08:57',NULL),(105,92,0,2,'服务器删除',NULL,'',999,'','',0,0,0,'serverDeploy:del',NULL,NULL,'2019-11-17 11:09:15',NULL),(106,93,0,2,'应用新增',NULL,'',999,'','',0,0,0,'app:add',NULL,NULL,'2019-11-17 11:10:03',NULL),(107,93,0,2,'应用编辑',NULL,'',999,'','',0,0,0,'app:edit',NULL,NULL,'2019-11-17 11:10:28',NULL),(108,93,0,2,'应用删除',NULL,'',999,'','',0,0,0,'app:del',NULL,NULL,'2019-11-17 11:10:55',NULL),(109,94,0,2,'部署新增',NULL,'',999,'','',0,0,0,'deploy:add',NULL,NULL,'2019-11-17 11:11:22',NULL),(110,94,0,2,'部署编辑',NULL,'',999,'','',0,0,0,'deploy:edit',NULL,NULL,'2019-11-17 11:11:41',NULL),(111,94,0,2,'部署删除',NULL,'',999,'','',0,0,0,'deploy:del',NULL,NULL,'2019-11-17 11:12:01',NULL),(112,98,0,2,'数据库新增',NULL,'',999,'','',0,0,0,'database:add',NULL,NULL,'2019-11-17 11:12:43',NULL),(113,98,0,2,'数据库编辑',NULL,'',999,'','',0,0,0,'database:edit',NULL,NULL,'2019-11-17 11:12:58',NULL),(114,98,0,2,'数据库删除',NULL,'',999,'','',0,0,0,'database:del',NULL,NULL,'2019-11-17 11:13:14',NULL),(116,36,0,1,'生成预览','Preview','generator/preview',999,'java','generator/preview/:tableName',0,1,1,NULL,NULL,NULL,'2019-11-26 14:54:36',NULL),(118,1,NULL,1,'权限资源','permission','system/permission/index',11,'permission','permission',0,0,0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `chimes_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_permission`
--

DROP TABLE IF EXISTS `chimes_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pid` bigint NOT NULL,
  `api_pattern` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `service_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `api_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `api_bypass` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_permission_service_id_t1` (`service_id`) USING BTREE,
  KEY `idx_permission_name_t2` (`name`) USING BTREE,
  KEY `idx_permission_alias_t2` (`alias`) USING BTREE,
  KEY `idx_permission_name_service_id_t4` (`name`,`service_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1354 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_permission`
--

LOCK TABLES `chimes_permission` WRITE;
/*!40000 ALTER TABLE `chimes_permission` DISABLE KEYS */;
INSERT INTO `chimes_permission` VALUES (1252,'DICTDETAIL','2022-07-01 17:03:25','字典详情查询',0,'/api/v1/dictdetail','chimes-rust',NULL,NULL),(1253,'QUERY_DICT_DETAIL_PAGED','2022-07-01 17:03:25','字典详情查询列表',1252,'/api/v1/dictdetail/paged/{current}/{size}','chimes-rust','POST','user'),(1254,'QUERY_DICT_DETAIL_QUERY','2022-07-01 17:03:25','字典详情查询分页',1252,'/api/v1/dictdetail/query','chimes-rust','POST','user'),(1255,'USER','2022-07-01 17:03:25','用户',0,'/api/v1/user','chimes-rust',NULL,NULL),(1256,'USER_SAVE','2022-07-01 17:03:25','用户保存',1255,'/api/v1/user/save','chimes-rust','POST','user'),(1257,'USER_UPDATE','2022-07-01 17:03:25','用户更新',1255,'/api/v1/user/update','chimes-rust','POST','user'),(1258,'USER_DELETE','2022-07-01 17:03:25','用户删除',1255,'/api/v1/user/delete','chimes-rust','POST','user'),(1259,'USER_DELETE_IDS','2022-07-01 17:03:25','用户批量删除',1255,'/api/v1/user/delete_ids','chimes-rust','POST','user'),(1260,'USER_SEARCH','2022-07-01 17:03:25','用户查询',1255,'/api/v1/user/search','chimes-rust','POST','user'),(1261,'USER_PAGED','2022-07-01 17:03:25','用户分页查询',1255,'/api/v1/user/paged/{current}/{size}','chimes-rust','POST','user'),(1262,'USER_GET','2022-07-01 17:03:25','用户获取',1255,'/api/v1/user/get/{id}','chimes-rust','GET','user'),(1263,'MENU','2022-07-01 17:03:25','菜单',0,'/api/v1/menu','chimes-rust',NULL,NULL),(1264,'MENU_SAVE','2022-07-01 17:03:25','菜单保存',1263,'/api/v1/menu/save','chimes-rust','POST','user'),(1265,'MENU_UPDATE','2022-07-01 17:03:25','菜单更新',1263,'/api/v1/menu/update','chimes-rust','POST','user'),(1266,'MENU_DELETE','2022-07-01 17:03:25','菜单删除',1263,'/api/v1/menu/delete','chimes-rust','POST','user'),(1267,'MENU_DELETE_IDS','2022-07-01 17:03:25','菜单批量删除',1263,'/api/v1/menu/delete_ids','chimes-rust','POST','user'),(1268,'MENU_SEARCH','2022-07-01 17:03:25','菜单查询',1263,'/api/v1/menu/search','chimes-rust','POST','user'),(1269,'MENU_PAGED','2022-07-01 17:03:25','菜单分页查询',1263,'/api/v1/menu/paged/{current}/{size}','chimes-rust','POST','user'),(1270,'MENU_GET','2022-07-01 17:03:25','菜单获取',1263,'/api/v1/menu/get/{id}','chimes-rust','GET','user'),(1271,'MENU_TREE','2022-07-01 17:03:25','菜单树形查询',1263,'/api/v1/menu/tree','chimes-rust','GET','user'),(1272,'PERMISSION','2022-07-01 17:03:25','权限资源',0,'/api/v1/permission','chimes-rust',NULL,NULL),(1273,'PERMISSION_SAVE','2022-07-01 17:03:25','权限资源保存',1272,'/api/v1/permission/save','chimes-rust','POST','user'),(1274,'PERMISSION_UPDATE','2022-07-01 17:03:25','权限资源更新',1272,'/api/v1/permission/update','chimes-rust','POST','user'),(1275,'PERMISSION_DELETE','2022-07-01 17:03:25','权限资源删除',1272,'/api/v1/permission/delete','chimes-rust','POST','user'),(1276,'PERMISSION_DELETE_IDS','2022-07-01 17:03:25','权限资源批量删除',1272,'/api/v1/permission/delete_ids','chimes-rust','POST','user'),(1277,'PERMISSION_SEARCH','2022-07-01 17:03:25','权限资源查询',1272,'/api/v1/permission/search','chimes-rust','POST','user'),(1278,'PERMISSION_PAGED','2022-07-01 17:03:25','权限资源分页查询',1272,'/api/v1/permission/paged/{current}/{size}','chimes-rust','POST','user'),(1279,'PERMISSION_GET','2022-07-01 17:03:25','权限资源获取',1272,'/api/v1/permission/get/{id}','chimes-rust','GET','user'),(1280,'PERMISSION_TREE','2022-07-01 17:03:25','权限资源树形查询',1272,'/api/v1/permission/tree','chimes-rust','GET','user'),(1281,'ROLE','2022-07-01 17:03:25','角色',0,'/api/v1/role','chimes-rust',NULL,NULL),(1282,'ROLE_SAVE','2022-07-01 17:03:25','角色保存',1281,'/api/v1/role/save','chimes-rust','POST','user'),(1283,'ROLE_UPDATE','2022-07-01 17:03:25','角色更新',1281,'/api/v1/role/update','chimes-rust','POST','user'),(1284,'ROLE_DELETE','2022-07-01 17:03:25','角色删除',1281,'/api/v1/role/delete','chimes-rust','POST','user'),(1285,'ROLE_DELETE_IDS','2022-07-01 17:03:25','角色批量删除',1281,'/api/v1/role/delete_ids','chimes-rust','POST','user'),(1286,'ROLE_SEARCH','2022-07-01 17:03:25','角色查询',1281,'/api/v1/role/search','chimes-rust','POST','user'),(1287,'ROLE_PAGED','2022-07-01 17:03:25','角色分页查询',1281,'/api/v1/role/paged/{current}/{size}','chimes-rust','POST','user'),(1288,'ROLE_GET','2022-07-01 17:03:25','角色获取',1281,'/api/v1/role/get/{id}','chimes-rust','GET','user'),(1289,'DEPT','2022-07-01 17:03:25','部门',0,'/api/v1/dept','chimes-rust',NULL,NULL),(1290,'DEPT_SAVE','2022-07-01 17:03:25','部门保存',1289,'/api/v1/dept/save','chimes-rust','POST','user'),(1291,'DEPT_UPDATE','2022-07-01 17:03:25','部门更新',1289,'/api/v1/dept/update','chimes-rust','POST','user'),(1292,'DEPT_DELETE','2022-07-01 17:03:25','部门删除',1289,'/api/v1/dept/delete','chimes-rust','POST','user'),(1293,'DEPT_DELETE_IDS','2022-07-01 17:03:25','部门批量删除',1289,'/api/v1/dept/delete_ids','chimes-rust','POST','user'),(1294,'DEPT_SEARCH','2022-07-01 17:03:25','部门查询',1289,'/api/v1/dept/search','chimes-rust','POST','user'),(1295,'DEPT_PAGED','2022-07-01 17:03:25','部门分页查询',1289,'/api/v1/dept/paged/{current}/{size}','chimes-rust','POST','user'),(1296,'DEPT_GET','2022-07-01 17:03:25','部门获取',1289,'/api/v1/dept/get/{id}','chimes-rust','GET','user'),(1297,'DEPT_TREE','2022-07-01 17:03:25','部门树形查询',1289,'/api/v1/dept/tree','chimes-rust','GET','user'),(1298,'JOB','2022-07-01 17:03:25','岗位',0,'/api/v1/job','chimes-rust',NULL,NULL),(1299,'JOB_SAVE','2022-07-01 17:03:25','岗位保存',1298,'/api/v1/job/save','chimes-rust','POST','user'),(1300,'JOB_UPDATE','2022-07-01 17:03:25','岗位更新',1298,'/api/v1/job/update','chimes-rust','POST','user'),(1301,'JOB_DELETE','2022-07-01 17:03:25','岗位删除',1298,'/api/v1/job/delete','chimes-rust','POST','user'),(1302,'JOB_DELETE_IDS','2022-07-01 17:03:25','岗位批量删除',1298,'/api/v1/job/delete_ids','chimes-rust','POST','user'),(1303,'JOB_SEARCH','2022-07-01 17:03:25','岗位查询',1298,'/api/v1/job/search','chimes-rust','POST','user'),(1304,'JOB_PAGED','2022-07-01 17:03:25','岗位分页查询',1298,'/api/v1/job/paged/{current}/{size}','chimes-rust','POST','user'),(1305,'JOB_GET','2022-07-01 17:03:25','岗位获取',1298,'/api/v1/job/get/{id}','chimes-rust','GET','user'),(1306,'DICT','2022-07-01 17:03:25','字典',0,'/api/v1/dict','chimes-rust',NULL,NULL),(1307,'DICT_SAVE','2022-07-01 17:03:25','字典保存',1306,'/api/v1/dict/save','chimes-rust','POST','user'),(1308,'DICT_UPDATE','2022-07-01 17:03:25','字典更新',1306,'/api/v1/dict/update','chimes-rust','POST','user'),(1309,'DICT_DELETE','2022-07-01 17:03:25','字典删除',1306,'/api/v1/dict/delete','chimes-rust','POST','user'),(1310,'DICT_DELETE_IDS','2022-07-01 17:03:25','字典批量删除',1306,'/api/v1/dict/delete_ids','chimes-rust','POST','user'),(1311,'DICT_SEARCH','2022-07-01 17:03:25','字典查询',1306,'/api/v1/dict/search','chimes-rust','POST','user'),(1312,'DICT_PAGED','2022-07-01 17:03:25','字典分页查询',1306,'/api/v1/dict/paged/{current}/{size}','chimes-rust','POST','user'),(1313,'DICT_GET','2022-07-01 17:03:25','字典获取',1306,'/api/v1/dict/get/{id}','chimes-rust','GET','user'),(1314,'DICT_DETAIL','2022-07-01 17:03:25','字典详情',0,'/api/v1/dict_detail','chimes-rust',NULL,NULL),(1315,'DICT_DETAIL_SAVE','2022-07-01 17:03:25','字典详情保存',1314,'/api/v1/dict_detail/save','chimes-rust','POST','user'),(1316,'DICT_DETAIL_UPDATE','2022-07-01 17:03:25','字典详情更新',1314,'/api/v1/dict_detail/update','chimes-rust','POST','user'),(1317,'DICT_DETAIL_DELETE','2022-07-01 17:03:25','字典详情删除',1314,'/api/v1/dict_detail/delete','chimes-rust','POST','user'),(1318,'DICT_DETAIL_DELETE_IDS','2022-07-01 17:03:25','字典详情批量删除',1314,'/api/v1/dict_detail/delete_ids','chimes-rust','POST','user'),(1319,'DICT_DETAIL_SEARCH','2022-07-01 17:03:25','字典详情查询',1314,'/api/v1/dict_detail/search','chimes-rust','POST','user'),(1320,'DICT_DETAIL_PAGED','2022-07-01 17:03:25','字典详情分页查询',1314,'/api/v1/dict_detail/paged/{current}/{size}','chimes-rust','POST','user'),(1321,'DICT_DETAIL_GET','2022-07-01 17:03:25','字典详情获取',1314,'/api/v1/dict_detail/get/{id}','chimes-rust','GET','user'),(1322,'LOGS','2022-07-01 17:03:25','日志',0,'/api/v1/logs','chimes-rust',NULL,NULL),(1323,'LOGS_SAVE','2022-07-01 17:03:25','日志保存',1322,'/api/v1/logs/save','chimes-rust','POST','user'),(1324,'LOGS_UPDATE','2022-07-01 17:03:25','日志更新',1322,'/api/v1/logs/update','chimes-rust','POST','user'),(1325,'LOGS_DELETE','2022-07-01 17:03:25','日志删除',1322,'/api/v1/logs/delete','chimes-rust','POST','user'),(1326,'LOGS_DELETE_IDS','2022-07-01 17:03:25','日志批量删除',1322,'/api/v1/logs/delete_ids','chimes-rust','POST','user'),(1327,'LOGS_SEARCH','2022-07-01 17:03:25','日志查询',1322,'/api/v1/logs/search','chimes-rust','POST','user'),(1328,'LOGS_PAGED','2022-07-01 17:03:25','日志分页查询',1322,'/api/v1/logs/paged/{current}/{size}','chimes-rust','POST','user'),(1329,'LOGS_GET','2022-07-01 17:03:25','日志获取',1322,'/api/v1/logs/get/{id}','chimes-rust','GET','user'),(1330,'USER_ROLES','2022-07-01 17:03:25','用户角色关系',0,'/api/v1/user_roles','chimes-rust',NULL,NULL),(1331,'USER_ROLES_REL_LOAD','2022-07-01 17:03:25','用户角色关系加载',1330,'/api/v1/user_roles/load/{user_id}','chimes-rust','GET','user'),(1332,'USER_ROLES_REL_REMOVE','2022-07-01 17:03:25','用户角色关系删除',1330,'/api/v1/user_roles/remove/{user_id}','chimes-rust','POST','user'),(1333,'USER_ROLES_REL_SAVE','2022-07-01 17:03:25','用户角色关系保存',1330,'/api/v1/user_roles/save','chimes-rust','POST','user'),(1334,'ROLE_MENUS','2022-07-01 17:03:25','角色菜单功能关系',0,'/api/v1/role_menus','chimes-rust',NULL,NULL),(1335,'ROLE_MENUS_REL_LOAD','2022-07-01 17:03:25','角色菜单功能关系加载',1334,'/api/v1/role_menus/load/{role_id}','chimes-rust','GET','user'),(1336,'ROLE_MENUS_REL_REMOVE','2022-07-01 17:03:25','角色菜单功能关系删除',1334,'/api/v1/role_menus/remove/{role_id}','chimes-rust','POST','user'),(1337,'ROLE_MENUS_REL_SAVE','2022-07-01 17:03:25','角色菜单功能关系保存',1334,'/api/v1/role_menus/save','chimes-rust','POST','user'),(1338,'USER_DETAIL_INFO','2022-07-01 17:03:25','用户详情信息',0,'/api/v1/user_detail_info','chimes-rust',NULL,NULL),(1339,'USER_DETAIL_INFO_REL_LOAD','2022-07-01 17:03:25','用户详情信息加载',1338,'/api/v1/user_detail_info/load/{user_id}','chimes-rust','GET','user'),(1340,'USER_DETAIL_INFO_REL_REMOVE','2022-07-01 17:03:25','用户详情信息删除',1338,'/api/v1/user_detail_info/remove/{user_id}','chimes-rust','POST','user'),(1341,'USER_DETAIL_INFO_REL_SAVE','2022-07-01 17:03:25','用户详情信息保存',1338,'/api/v1/user_detail_info/save','chimes-rust','POST','user'),(1342,'AUTH_INFO','2022-07-01 18:32:46','当前用户认证信息',0,'/api/v1/auth/info','chimes-rust','GET','user'),(1343,'MENU_BUILD','2022-07-01 18:35:33','构建用户菜单树',1263,'/api/v1/menus/build','chimes-rust','GET','user'),(1344,'MENU_SUPERIOR','2022-07-01 18:37:06','菜单树构建',1263,'/api/v1/menu/superior','chimes-rust','POST','user'),(1345,'ROLE_LEVEL','2022-07-01 18:40:03','角色级别',1281,'/api/v1/role/level','chimes-rust','GET','user'),(1346,'DEPT_SUPERIOR','2022-07-01 18:40:43','部门级数',1289,'/api/v1/dept/superior','chimes-rust','POST','user'),(1347,'PERMISSION_CHILDREN','2022-07-01 18:42:18','资源子级',1272,'/api/v1/permission/children','chimes-rust','GET','user'),(1348,'MENU_CHILDREN','2022-07-01 18:43:17','菜单子级',1263,'/api/v1/menu/children','chimes-rust','GET','user'),(1349,'USER_CENTER_UPDATE','2022-07-02 14:20:46','用户修改资料',1255,'/api/v1/user/center/update/info','chimes-rust','POST','user'),(1350,'USER_CENTER_UPDATE_PWD','2022-07-02 14:21:38','用户修改密码',1255,'/api/v1/user/center/update/pwd','chimes-rust','POST','user'),(1351,'USER_CENTER_UPDATE_EMAIL','2022-07-02 14:22:32','用户修改邮箱',1255,'/api/v1/user/center/update/email','chimes-rust','POST','user'),(1352,'USER_CENTER_UPDATE_AVATAR','2022-07-02 14:23:18','用户修改头像',1255,'/api/v1/user/center/update/avatar','chimes-rust','POST','user'),(1353,'USER_AVATAR','2022-07-02 19:39:50','用户头像',1255,'/api/v1/avatar/{filename}','chimes-rust','GET','anonymous');
/*!40000 ALTER TABLE `chimes_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_profile`
--

DROP TABLE IF EXISTS `chimes_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_profile` (
  `user_id` bigint NOT NULL,
  `full_name` varchar(30) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `education` varchar(100) DEFAULT NULL,
  `birth_day` date DEFAULT NULL,
  `create_date` datetime(6) DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_profile`
--

LOCK TABLES `chimes_profile` WRITE;
/*!40000 ALTER TABLE `chimes_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `chimes_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_role`
--

DROP TABLE IF EXISTS `chimes_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `level` int DEFAULT NULL COMMENT '角色级别',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `data_scope` varchar(255) DEFAULT NULL COMMENT '数据权限',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`name`),
  KEY `role_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_role`
--

LOCK TABLES `chimes_role` WRITE;
/*!40000 ALTER TABLE `chimes_role` DISABLE KEYS */;
INSERT INTO `chimes_role` VALUES (1,'超级管理员',1,'-','全部',NULL,'admin','2018-11-23 11:04:37','2020-08-06 16:10:24'),(2,'普通用户',2,'-','本级',NULL,'admin','2018-11-23 13:09:06','2020-09-05 10:45:12');
/*!40000 ALTER TABLE `chimes_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_roles_depts`
--

DROP TABLE IF EXISTS `chimes_roles_depts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_roles_depts` (
  `role_id` bigint NOT NULL,
  `dept_id` bigint NOT NULL,
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE,
  KEY `FK7qg6itn5ajdoa9h9o78v9ksur` (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='角色部门关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_roles_depts`
--

LOCK TABLES `chimes_roles_depts` WRITE;
/*!40000 ALTER TABLE `chimes_roles_depts` DISABLE KEYS */;
/*!40000 ALTER TABLE `chimes_roles_depts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_roles_menus`
--

DROP TABLE IF EXISTS `chimes_roles_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_roles_menus` (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`menu_id`,`role_id`) USING BTREE,
  KEY `FKcngg2qadojhi3a651a5adkvbq` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='角色菜单关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_roles_menus`
--

LOCK TABLES `chimes_roles_menus` WRITE;
/*!40000 ALTER TABLE `chimes_roles_menus` DISABLE KEYS */;
INSERT INTO `chimes_roles_menus` VALUES (1,1),(2,1),(3,1),(5,1),(6,1),(7,1),(9,1),(10,1),(11,1),(14,1),(15,1),(18,1),(19,1),(21,1),(22,1),(23,1),(24,1),(27,1),(28,1),(30,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(41,1),(44,1),(45,1),(46,1),(48,1),(49,1),(50,1),(52,1),(53,1),(54,1),(56,1),(57,1),(58,1),(60,1),(61,1),(62,1),(64,1),(65,1),(66,1),(73,1),(74,1),(75,1),(77,1),(78,1),(79,1),(80,1),(82,1),(83,1),(90,1),(92,1),(93,1),(94,1),(97,1),(98,1),(102,1),(103,1),(104,1),(105,1),(106,1),(107,1),(108,1),(109,1),(110,1),(111,1),(112,1),(113,1),(114,1),(116,1),(118,1),(1,2),(2,2),(10,2),(11,2),(14,2),(15,2),(19,2),(21,2),(22,2),(23,2),(24,2),(27,2),(30,2),(32,2),(33,2),(34,2),(36,2),(80,2),(82,2),(83,2),(116,2);
/*!40000 ALTER TABLE `chimes_roles_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_roles_permissions`
--

DROP TABLE IF EXISTS `chimes_roles_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_roles_permissions` (
  `role_id` bigint NOT NULL,
  `id` bigint NOT NULL COMMENT 'PermissionID',
  PRIMARY KEY (`role_id`,`id`) USING BTREE,
  KEY `fkrkpanhruga5fqej10nnuyghj3` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_roles_permissions`
--

LOCK TABLES `chimes_roles_permissions` WRITE;
/*!40000 ALTER TABLE `chimes_roles_permissions` DISABLE KEYS */;
INSERT INTO `chimes_roles_permissions` VALUES (1,1252),(2,1252),(1,1253),(2,1253),(1,1254),(2,1254),(1,1255),(2,1255),(1,1256),(2,1256),(1,1257),(2,1257),(1,1258),(2,1258),(1,1259),(2,1259),(1,1260),(2,1260),(1,1261),(2,1261),(1,1262),(2,1262),(1,1263),(2,1263),(1,1264),(2,1264),(1,1265),(2,1265),(1,1266),(2,1266),(1,1267),(2,1267),(1,1268),(2,1268),(1,1269),(2,1269),(1,1270),(2,1270),(1,1271),(2,1271),(1,1272),(2,1272),(1,1273),(2,1273),(1,1274),(2,1274),(1,1275),(2,1275),(1,1276),(2,1276),(1,1277),(2,1277),(1,1278),(2,1278),(1,1279),(2,1279),(1,1280),(2,1280),(1,1281),(2,1281),(1,1282),(2,1282),(1,1283),(2,1283),(1,1284),(2,1284),(1,1285),(2,1285),(1,1286),(2,1286),(1,1287),(2,1287),(1,1288),(2,1288),(1,1289),(2,1289),(1,1290),(2,1290),(1,1291),(2,1291),(1,1292),(2,1292),(1,1293),(2,1293),(1,1294),(2,1294),(1,1295),(2,1295),(1,1296),(2,1296),(1,1297),(2,1297),(1,1298),(2,1298),(1,1299),(2,1299),(1,1300),(2,1300),(1,1301),(2,1301),(1,1302),(2,1302),(1,1303),(2,1303),(1,1304),(2,1304),(1,1305),(2,1305),(1,1306),(2,1306),(1,1307),(2,1307),(1,1308),(2,1308),(1,1309),(2,1309),(1,1310),(2,1310),(1,1311),(2,1311),(1,1312),(2,1312),(1,1313),(2,1313),(1,1314),(2,1314),(1,1315),(2,1315),(1,1316),(2,1316),(1,1317),(2,1317),(1,1318),(2,1318),(1,1319),(2,1319),(1,1320),(2,1320),(1,1321),(2,1321),(1,1322),(2,1322),(1,1323),(2,1323),(1,1324),(2,1324),(1,1325),(2,1325),(1,1326),(2,1326),(1,1327),(2,1327),(1,1328),(2,1328),(1,1329),(2,1329),(1,1330),(2,1330),(1,1331),(2,1331),(1,1332),(2,1332),(1,1333),(2,1333),(1,1334),(2,1334),(1,1335),(2,1335),(1,1336),(2,1336),(1,1337),(2,1337),(1,1338),(2,1338),(1,1339),(2,1339),(1,1340),(2,1340),(1,1341),(2,1341),(1,1342),(1,1343);
/*!40000 ALTER TABLE `chimes_roles_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_user`
--

DROP TABLE IF EXISTS `chimes_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门名称',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `nick_name` varchar(255) DEFAULT NULL COMMENT '昵称',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `avatar_name` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `avatar_path` varchar(255) DEFAULT NULL COMMENT '头像真实路径',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `is_admin` tinyint(1) DEFAULT '0' COMMENT '是否为admin账号',
  `enabled` int DEFAULT NULL COMMENT '状态：1启用、0禁用',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='系统用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_user`
--

LOCK TABLES `chimes_user` WRITE;
/*!40000 ALTER TABLE `chimes_user` DISABLE KEYS */;
INSERT INTO `chimes_user` VALUES (1,2,'admin','Administrator','男','18888888888','longzou@hotmail.com','181bec134b4_385759961688444928.png','D:/temp/files/181bec134b4_385759961688444928.png','BQMVzBbbKUfJ6QQ5ix3EMyFQ5n/rPYyj2qQ4OlET3edST+GhoJ4/dVMJ0Rp4OmDu0Ualf5Mk9icyaW2+/ArwVg==',1,1,NULL,'admin','2020-05-03 16:38:31','2018-08-23 09:11:56','2020-09-05 10:43:31'),(2,17,'test1','测试1','男','19999999998','2231@qq.com',NULL,NULL,'BQMVzBbbKUfJ6QQ5ix3EMyFQ5n/rPYyj2qQ4OlET3edST+GhoJ4/dVMJ0Rp4OmDu0Ualf5Mk9icyaW2+/ArwVg==',0,1,'admin','admin',NULL,'2020-05-05 11:15:49','2020-09-05 10:43:38');
/*!40000 ALTER TABLE `chimes_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_users_jobs`
--

DROP TABLE IF EXISTS `chimes_users_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_users_jobs` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `job_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_users_jobs`
--

LOCK TABLES `chimes_users_jobs` WRITE;
/*!40000 ALTER TABLE `chimes_users_jobs` DISABLE KEYS */;
INSERT INTO `chimes_users_jobs` VALUES (1,11),(2,10),(2,11);
/*!40000 ALTER TABLE `chimes_users_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chimes_users_roles`
--

DROP TABLE IF EXISTS `chimes_users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chimes_users_roles` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `FKq4eq273l04bpu4efj0jd0jb98` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户角色关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chimes_users_roles`
--

LOCK TABLES `chimes_users_roles` WRITE;
/*!40000 ALTER TABLE `chimes_users_roles` DISABLE KEYS */;
INSERT INTO `chimes_users_roles` VALUES (1,1),(2,1),(2,2);
/*!40000 ALTER TABLE `chimes_users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'chimesrust'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-02 19:53:31
