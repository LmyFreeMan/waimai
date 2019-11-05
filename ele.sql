/*
SQLyog v10.2 
MySQL - 5.7.21-0ubuntu0.16.04.1 : Database - elm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`elm` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `elm`;

/*Table structure for table `elm_access_token` */

DROP TABLE IF EXISTS `elm_access_token`;

CREATE TABLE `elm_access_token` (
  `access_token` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '123456789',
  `expires` int(11) NOT NULL DEFAULT '0' COMMENT '过期时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `elm_access_token` */

/*Table structure for table `elm_address` */

DROP TABLE IF EXISTS `elm_address`;

CREATE TABLE `elm_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `linkman` varchar(255) NOT NULL DEFAULT '' COMMENT '联系人',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `type` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否已删除:0=已删除,1=未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户收货地址表';

/*Data for the table `elm_address` */

insert  into `elm_address`(`id`,`userid`,`linkman`,`mobile`,`address`,`updatetime`,`type`) values (13,1010,'刘','15797638189','综合楼测试地址',1540712939,'1'),(14,1008,'验证','18032841463','我现在',1540691862,'1');

/*Table structure for table `elm_admin` */

DROP TABLE IF EXISTS `elm_admin`;

CREATE TABLE `elm_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(100) NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `token` varchar(59) NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员表';

/*Data for the table `elm_admin` */

insert  into `elm_admin`(`id`,`username`,`nickname`,`password`,`salt`,`avatar`,`email`,`loginfailure`,`logintime`,`createtime`,`updatetime`,`token`,`status`) values (1,'admin','admin','6acd1aef2d2d445c9639907d4c96bb69','gDPo2R','/assets/img/avatar.png','JamesLiu_storm@foxmail.com',0,1540735106,1492186163,1540735106,'0f958011-9233-4c04-88c9-95a2bcbd0358','normal'),(10,'1005','111111','ef68f3a63e07502286c2ecb7f372e28c','rA13Yl','/assets/img/avatar.png','2515946609@qq.com',0,1540734949,1540691260,1540735096,'','normal'),(28,'1027','11111','165881c74b2235332f82804638e184e0','DqGESz','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','1027@shop.com',0,0,1540734824,1540734824,'','normal');

/*Table structure for table `elm_admin_log` */

DROP TABLE IF EXISTS `elm_admin_log`;

CREATE TABLE `elm_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `name` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1291 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员日志表';

/*Data for the table `elm_admin_log` */

insert  into `elm_admin_log`(`id`,`admin_id`,`username`,`url`,`title`,`content`,`ip`,`useragent`,`createtime`) values (1257,8,'1004','/admin/index/login','登录','{\"__token__\":\"9c6d2f050dad300003bd27180fd85d05\",\"username\":\"1004\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540711755),(1258,1,'admin','/admin/index/login','登录','{\"__token__\":\"6273cfb174ec681952b067ddb0f19a30\",\"username\":\"admin\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712337),(1259,8,'1004','/admin/index/login','登录','{\"__token__\":\"79769d1d41abe0629fb027f7511cdc22\",\"username\":\"1004\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712360),(1260,1,'admin','/admin/index/login','登录','{\"__token__\":\"1f77cc373d347a4eede1f1cb01b73e9d\",\"username\":\"admin\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712439),(1261,8,'1004','/admin/index/login','登录','{\"__token__\":\"51cc95c3edc9a5bc342a6dde3506c0a6\",\"username\":\"1004\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712470),(1262,8,'1004','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712475),(1263,8,'1004','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712483),(1264,0,'Unknown','/admin/index/login','登录','{\"__token__\":\"e2325b4aa7e5f20698dfb26ad07594a1\",\"username\":\"1006\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712496),(1265,0,'Unknown','/admin/index/login','登录','{\"__token__\":\"42567bf65ba1b02dee433b69f3603603\",\"username\":\"1005\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712500),(1266,10,'1005','/admin/index/login','登录','{\"__token__\":\"a1a70eebf9d885c3feb562a76fbb2d85\",\"username\":\"1005\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712502),(1267,10,'1005','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712521),(1268,0,'Unknown','/admin/index/login','登录','{\"__token__\":\"b18552cbf3c5d49372bac57fea67cafd\",\"username\":\"admin\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712543),(1269,1,'admin','/admin/index/login','登录','{\"__token__\":\"4736306568f43099ca91bb02ed02b6e1\",\"username\":\"admin\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712548),(1270,1,'admin','/admin/mch/index','商家 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712561),(1271,1,'admin','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712563),(1272,1,'admin','/admin/mch/index','商家 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712564),(1273,1,'admin','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712566),(1274,1,'admin','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712568),(1275,1,'admin','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712569),(1276,1,'admin','/admin/mch/index','商家 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712570),(1277,1,'admin','/admin/mch/index','商家 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540712572),(1278,0,'Unknown','/admin/index/login','','{\"service\":\"WeChatMini.GetOpenid\",\"code\":\"033cC1Uz08prxf1DUDTz0d13Uz0cC1Un\"}','182.246.64.57','Mozilla/5.0 (Linux; Android 8.0.0; MIX 2 Build/OPR1.170623.027; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/62.0.3202.84 Mobile Safari/537.36 MicroMessenger/6.7.3.1360(0x26070336) NetType/WIFI Language/zh_CN Process/toolsmp',1540723454),(1279,8,'1004','/admin/index/login','登录','{\"__token__\":\"f2cdebe3900211815aa61d49f2053047\",\"username\":\"1004\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540733441),(1280,1,'admin','/admin/index/login','登录','{\"__token__\":\"7b6ecd399bd936802a0356c89e460636\",\"username\":\"admin\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540733452),(1281,1,'admin','/admin/mch/add?dialog=1','商家 添加','{\"dialog\":\"1\",\"row\":{\"name\":\"11111\",\"image\":\"\\/uploads\\/20181027\\/e6b866a2ed7396dd4f97c9b97623b47e.jpg\",\"request_price\":\"0.01\",\"send_price\":\"0.01\",\"desc\":\"111111\",\"licence_images\":\"\",\"money\":\"0.00\",\"contact\":\"15797638189\",\"city\":\"\\u5b89\\u5fbd\\u7701\\/\\u829c\\u6e56\\u5e02\\/\\u9e20\\u6c5f\\u533a\",\"addr\":\"111111\",\"usetime\":\"38\",\"lng\":\"0\",\"lat\":\"0\"}}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540734824),(1282,0,'Unknown','/admin/index/login','登录','{\"__token__\":\"1b1d119e93b01949399290bd9925089d\",\"username\":\"1004\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540734911),(1283,8,'1004','/admin/index/login','登录','{\"__token__\":\"1507ce57ea53f8e0cb65c64c9f79c2aa\",\"username\":\"1004\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540734922),(1284,10,'1005','/admin/index/login','登录','{\"__token__\":\"0c8afd8ad8900675472c3657532a5b9f\",\"username\":\"1005\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540734949),(1285,10,'1005','/admin/goodcat/index','商品分类管理 查看','{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540734984),(1286,10,'1005','/admin/goods/add?dialog=1','商品管理 添加','{\"dialog\":\"1\",\"row\":{\"mch_id\":\"1005\",\"goodcat_id\":\"20\",\"name\":\"5555555\",\"image\":\"\\/uploads\\/20181027\\/e6b866a2ed7396dd4f97c9b97623b47e.jpg\",\"desc\":\"00000\",\"price\":\"0.01\"}}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540734999),(1287,1,'admin','/admin/index/login','登录','{\"__token__\":\"9ac11d4ca75344de79146734e042f960\",\"username\":\"admin\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540735106),(1288,1,'admin','/admin/banner/add?dialog=1','首页轮播图 添加','{\"dialog\":\"1\",\"row\":{\"image\":\"\\/uploads\\/20180925\\/c908ad2987e25597eeb3c39ec1d1a3da.png\",\"desc\":\"111\"}}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540735126),(1289,1,'admin','/admin/banner/del/ids/3','首页轮播图 删除','{\"action\":\"del\",\"ids\":\"3\",\"params\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540735280),(1290,1,'admin','/admin/mch/del/ids/1004','商家 删除','{\"action\":\"del\",\"ids\":\"1004\",\"params\":\"\"}','39.161.198.62','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',1540735296);

/*Table structure for table `elm_attachment` */

DROP TABLE IF EXISTS `elm_attachment`;

CREATE TABLE `elm_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) NOT NULL DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `uploadtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `storage` varchar(100) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='附件表';

/*Data for the table `elm_attachment` */

insert  into `elm_attachment`(`id`,`admin_id`,`user_id`,`url`,`imagewidth`,`imageheight`,`imagetype`,`imageframes`,`filesize`,`mimetype`,`extparam`,`createtime`,`updatetime`,`uploadtime`,`storage`,`sha1`) values (8,1,0,'/uploads/20180925/ac8bd2a6c2b39c45cd1fc9073c672495.jpg','121','121','jpg',0,13305,'image/jpeg','',1537857589,1537857589,1537857589,'local','c55de7fe3226995c63bdbb662a35f8b691c1e23d'),(9,1,0,'/uploads/20180925/b5ac378fa232e59fb027f62788ce6372.jpg','121','121','jpg',0,8340,'image/jpeg','',1537857870,1537857870,1537857870,'local','5be7a191d40a2b0307dead8b5664c9671a975f0b'),(10,1,0,'/uploads/20180925/c908ad2987e25597eeb3c39ec1d1a3da.png','1080','460','png',0,546799,'image/png','',1537876618,1537876618,1537876618,'local','be0cc39ce998c48ba75eeda0f67735f4d41dfaee'),(11,1,0,'/uploads/20180925/c908ad2987e25597eeb3c39ec1d1a3da.png','1080','460','png',0,546799,'image/png','',1537876803,1537876803,1537876803,'local','be0cc39ce998c48ba75eeda0f67735f4d41dfaee'),(12,1,0,'/uploads/20180926/c2c5747e54e95f318e78d1412503e00e.jpg','1080','1440','jpg',0,184643,'image/jpeg','',1537892733,1537892733,1537892733,'local','7556d7a79ead825aabdf289b89a14b057c9b78b0'),(13,6,0,'/uploads/20180930/c0d96cbc387f686c2ee3c4dec92d7d1c.png','750','1206','png',0,567970,'image/png','',1538237912,1538237912,1538237912,'local','cf8975f790fb21901f0c8e9ac6795ada926b25da'),(34,8,0,'/uploads/20181001/e78c746241f1ffa0e4b3a15b45e5111d.jpg','1080','1920','jpg',0,271484,'image/jpeg','',1538405940,1538405940,1538405940,'local','f126fa468db69d0aaac15b70f3bc9ffabbe2c2b6'),(35,8,0,'/uploads/20181001/bc4d929c32908a71d5cc282f466ee78e.jpg','1080','1920','jpg',0,321312,'image/jpeg','',1538406039,1538406039,1538406039,'local','07779b00052d244aac647caf0f2875db6ffb4016'),(36,8,0,'/uploads/20181001/e78c746241f1ffa0e4b3a15b45e5111d.jpg','1080','1920','jpg',0,271484,'image/jpeg','',1538407257,1538407257,1538407257,'local','f126fa468db69d0aaac15b70f3bc9ffabbe2c2b6'),(37,1,0,'/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','120','112','jpg',0,2392,'image/jpeg','',1540644520,1540644520,1540644520,'local','d48ab6b3ca9c4eba02187bdc52a198e426a43697'),(38,1,0,'/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','120','112','jpg',0,2392,'image/jpeg','',1540644588,1540644588,1540644588,'local','d48ab6b3ca9c4eba02187bdc52a198e426a43697'),(39,1,0,'/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','120','112','jpg',0,2392,'image/jpeg','',1540645744,1540645744,1540645744,'local','d48ab6b3ca9c4eba02187bdc52a198e426a43697'),(40,1,0,'/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','120','112','jpg',0,2392,'image/jpeg','',1540645834,1540645834,1540645834,'local','d48ab6b3ca9c4eba02187bdc52a198e426a43697'),(41,1,0,'/uploads/20181028/989d0a2362de861be75f23854c388446.png','863','1087','png',0,523886,'image/png','',1540690979,1540690979,1540690979,'local','9d3f08480534dc160134279c12e1104c61cf538f'),(42,1,0,'/uploads/20181028/989d0a2362de861be75f23854c388446.png','863','1087','png',0,523886,'image/png','',1540691101,1540691101,1540691101,'local','9d3f08480534dc160134279c12e1104c61cf538f');

/*Table structure for table `elm_auth_group` */

DROP TABLE IF EXISTS `elm_auth_group`;

CREATE TABLE `elm_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分组表';

/*Data for the table `elm_auth_group` */

insert  into `elm_auth_group`(`id`,`pid`,`name`,`rules`,`createtime`,`updatetime`,`status`) values (1,0,'Admin group','*',1490883540,149088354,'normal'),(2,1,'店家','13,14,16,15,17,23,24,25,28,29,30,31,32,33,34,98,99,100,101,102,104,105,106,107,108,122,1,8,97,103,7,2,121',1490883540,1540104804,'normal');

/*Table structure for table `elm_auth_group_access` */

DROP TABLE IF EXISTS `elm_auth_group_access`;

CREATE TABLE `elm_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='权限分组表';

/*Data for the table `elm_auth_group_access` */

insert  into `elm_auth_group_access`(`uid`,`group_id`) values (1,1),(10,2),(28,2);

/*Table structure for table `elm_auth_rule` */

DROP TABLE IF EXISTS `elm_auth_rule`;

CREATE TABLE `elm_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `weigh` (`weigh`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点表';

/*Data for the table `elm_auth_rule` */

insert  into `elm_auth_rule`(`id`,`type`,`pid`,`name`,`title`,`icon`,`condition`,`remark`,`ismenu`,`createtime`,`updatetime`,`weigh`,`status`) values (1,'file',0,'dashboard','Dashboard','fa fa-dashboard','','Dashboard tips',1,1497429920,1497429920,143,'normal'),(2,'file',0,'general','General','fa fa-cogs','','',1,1497429920,1497430169,137,'normal'),(3,'file',0,'category','Category','fa fa-list','','Category tips',0,1497429920,1537852543,119,'normal'),(4,'file',0,'addon','Addon','fa fa-rocket','','Addon tips',0,1502035509,1537854266,0,'normal'),(5,'file',0,'auth','Auth','fa fa-group','','',1,1497429920,1497430092,99,'normal'),(6,'file',2,'general/config','Config','fa fa-cog','','Config tips',1,1497429920,1497430683,60,'normal'),(7,'file',2,'general/attachment','Attachment','fa fa-file-image-o','','Attachment tips',1,1497429920,1497430699,53,'normal'),(8,'file',2,'general/profile','Profile','fa fa-user','','',1,1497429920,1538248951,34,'normal'),(9,'file',5,'auth/admin','Admin','fa fa-user','','Admin tips',1,1497429920,1497430320,118,'normal'),(10,'file',5,'auth/adminlog','Admin log','fa fa-list-alt','','Admin log tips',1,1497429920,1497430307,113,'normal'),(11,'file',5,'auth/group','Group','fa fa-group','','Group tips',1,1497429920,1497429920,109,'normal'),(12,'file',5,'auth/rule','Rule','fa fa-bars','','Rule tips',1,1497429920,1497430581,104,'normal'),(13,'file',1,'dashboard/index','View','fa fa-circle-o','','',0,1497429920,1497429920,136,'normal'),(14,'file',1,'dashboard/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,135,'normal'),(15,'file',1,'dashboard/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,133,'normal'),(16,'file',1,'dashboard/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,134,'normal'),(17,'file',1,'dashboard/multi','Multi','fa fa-circle-o','','',0,1497429920,1497429920,132,'normal'),(18,'file',6,'general/config/index','View','fa fa-circle-o','','',0,1497429920,1497429920,52,'normal'),(19,'file',6,'general/config/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,51,'normal'),(20,'file',6,'general/config/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,50,'normal'),(21,'file',6,'general/config/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,49,'normal'),(22,'file',6,'general/config/multi','Multi','fa fa-circle-o','','',0,1497429920,1497429920,48,'normal'),(23,'file',7,'general/attachment/index','View','fa fa-circle-o','','Attachment tips',0,1497429920,1497429920,59,'normal'),(24,'file',7,'general/attachment/select','Select attachment','fa fa-circle-o','','',0,1497429920,1497429920,58,'normal'),(25,'file',7,'general/attachment/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,57,'normal'),(26,'file',7,'general/attachment/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,56,'normal'),(27,'file',7,'general/attachment/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,55,'normal'),(28,'file',7,'general/attachment/multi','Multi','fa fa-circle-o','','',0,1497429920,1497429920,54,'normal'),(29,'file',8,'general/profile/index','View','fa fa-circle-o','','',0,1497429920,1538248937,33,'normal'),(30,'file',8,'general/profile/update','Update profile','fa fa-circle-o','','',0,1497429920,1497429920,32,'normal'),(31,'file',8,'general/profile/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,31,'normal'),(32,'file',8,'general/profile/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,30,'normal'),(33,'file',8,'general/profile/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,29,'normal'),(34,'file',8,'general/profile/multi','Multi','fa fa-circle-o','','',0,1497429920,1497429920,28,'normal'),(35,'file',3,'category/index','View','fa fa-circle-o','','Category tips',0,1497429920,1497429920,142,'normal'),(36,'file',3,'category/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,141,'normal'),(37,'file',3,'category/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,140,'normal'),(38,'file',3,'category/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,139,'normal'),(39,'file',3,'category/multi','Multi','fa fa-circle-o','','',0,1497429920,1497429920,138,'normal'),(40,'file',9,'auth/admin/index','View','fa fa-circle-o','','Admin tips',0,1497429920,1497429920,117,'normal'),(41,'file',9,'auth/admin/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,116,'normal'),(42,'file',9,'auth/admin/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,115,'normal'),(43,'file',9,'auth/admin/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,114,'normal'),(44,'file',10,'auth/adminlog/index','View','fa fa-circle-o','','Admin log tips',0,1497429920,1497429920,112,'normal'),(45,'file',10,'auth/adminlog/detail','Detail','fa fa-circle-o','','',0,1497429920,1497429920,111,'normal'),(46,'file',10,'auth/adminlog/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,110,'normal'),(47,'file',11,'auth/group/index','View','fa fa-circle-o','','Group tips',0,1497429920,1497429920,108,'normal'),(48,'file',11,'auth/group/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,107,'normal'),(49,'file',11,'auth/group/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,106,'normal'),(50,'file',11,'auth/group/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,105,'normal'),(51,'file',12,'auth/rule/index','View','fa fa-circle-o','','Rule tips',0,1497429920,1497429920,103,'normal'),(52,'file',12,'auth/rule/add','Add','fa fa-circle-o','','',0,1497429920,1497429920,102,'normal'),(53,'file',12,'auth/rule/edit','Edit','fa fa-circle-o','','',0,1497429920,1497429920,101,'normal'),(54,'file',12,'auth/rule/del','Delete','fa fa-circle-o','','',0,1497429920,1497429920,100,'normal'),(55,'file',4,'addon/index','View','fa fa-circle-o','','Addon tips',0,1502035509,1502035509,0,'normal'),(56,'file',4,'addon/add','Add','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(57,'file',4,'addon/edit','Edit','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(58,'file',4,'addon/del','Delete','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(59,'file',4,'addon/local','Local install','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(60,'file',4,'addon/state','Update state','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(61,'file',4,'addon/install','Install','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(62,'file',4,'addon/uninstall','Uninstall','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(63,'file',4,'addon/config','Setting','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(64,'file',4,'addon/refresh','Refresh','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(65,'file',4,'addon/multi','Multi','fa fa-circle-o','','',0,1502035509,1502035509,0,'normal'),(66,'file',0,'user','User','fa fa-list','','',0,1516374729,1538237255,0,'normal'),(67,'file',66,'user/user','User','fa fa-user','','',1,1516374729,1516374729,0,'normal'),(68,'file',67,'user/user/index','View','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(69,'file',67,'user/user/edit','Edit','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(70,'file',67,'user/user/add','Add','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(71,'file',67,'user/user/del','Del','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(72,'file',67,'user/user/multi','Multi','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(73,'file',66,'user/group','User group','fa fa-users','','',1,1516374729,1516374729,0,'normal'),(74,'file',73,'user/group/add','Add','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(75,'file',73,'user/group/edit','Edit','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(76,'file',73,'user/group/index','View','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(77,'file',73,'user/group/del','Del','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(78,'file',73,'user/group/multi','Multi','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(79,'file',66,'user/rule','User rule','fa fa-circle-o','','',1,1516374729,1516374729,0,'normal'),(80,'file',79,'user/rule/index','View','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(81,'file',79,'user/rule/del','Del','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(82,'file',79,'user/rule/add','Add','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(83,'file',79,'user/rule/edit','Edit','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(84,'file',79,'user/rule/multi','Multi','fa fa-circle-o','','',0,1516374729,1516374729,0,'normal'),(85,'file',0,'mch','商家','fa fa-circle-o','','',1,1537855157,1537855157,0,'normal'),(86,'file',85,'mch/index','查看','fa fa-circle-o','','',0,1537855157,1537857515,0,'normal'),(87,'file',85,'mch/add','添加','fa fa-circle-o','','',0,1537855157,1537857515,0,'normal'),(88,'file',85,'mch/edit','编辑','fa fa-circle-o','','',0,1537855157,1537857515,0,'normal'),(89,'file',85,'mch/del','删除','fa fa-circle-o','','',0,1537855157,1537857515,0,'normal'),(90,'file',85,'mch/multi','批量更新','fa fa-circle-o','','',0,1537855157,1537857515,0,'normal'),(91,'file',0,'banner','首页轮播图','fa fa-circle-o','','',1,1537877409,1537877409,0,'normal'),(92,'file',91,'banner/index','查看','fa fa-circle-o','','',0,1537877409,1537877409,0,'normal'),(93,'file',91,'banner/add','添加','fa fa-circle-o','','',0,1537877409,1537877409,0,'normal'),(94,'file',91,'banner/edit','编辑','fa fa-circle-o','','',0,1537877409,1537877409,0,'normal'),(95,'file',91,'banner/del','删除','fa fa-circle-o','','',0,1537877409,1537877409,0,'normal'),(96,'file',91,'banner/multi','批量更新','fa fa-circle-o','','',0,1537877409,1537877409,0,'normal'),(97,'file',0,'goodcat','商品分类管理','fa fa-circle-o','','',1,1537934161,1537934161,0,'normal'),(98,'file',97,'goodcat/index','查看','fa fa-circle-o','','',0,1537934161,1537934427,0,'normal'),(99,'file',97,'goodcat/add','添加','fa fa-circle-o','','',0,1537934161,1537934427,0,'normal'),(100,'file',97,'goodcat/edit','编辑','fa fa-circle-o','','',0,1537934161,1537934427,0,'normal'),(101,'file',97,'goodcat/del','删除','fa fa-circle-o','','',0,1537934161,1537934427,0,'normal'),(102,'file',97,'goodcat/multi','批量更新','fa fa-circle-o','','',0,1537934161,1537934427,0,'normal'),(103,'file',0,'goods','商品管理','fa fa-circle-o','','',1,1537935054,1537935054,0,'normal'),(104,'file',103,'goods/index','查看','fa fa-circle-o','','',0,1537935054,1537935977,0,'normal'),(105,'file',103,'goods/add','添加','fa fa-circle-o','','',0,1537935054,1537935977,0,'normal'),(106,'file',103,'goods/edit','编辑','fa fa-circle-o','','',0,1537935054,1537935977,0,'normal'),(107,'file',103,'goods/del','删除','fa fa-circle-o','','',0,1537935054,1537935977,0,'normal'),(108,'file',103,'goods/multi','批量更新','fa fa-circle-o','','',0,1537935054,1537935977,0,'normal'),(109,'file',0,'member','用户管理','fa fa-circle-o','','',1,1537972505,1537972505,0,'normal'),(110,'file',109,'member/index','查看','fa fa-circle-o','','',0,1537972505,1540109428,0,'normal'),(111,'file',109,'member/add','添加','fa fa-circle-o','','',0,1537972505,1540109428,0,'normal'),(112,'file',109,'member/edit','编辑','fa fa-circle-o','','',0,1537972505,1540109428,0,'normal'),(113,'file',109,'member/del','删除','fa fa-circle-o','','',0,1537972505,1540109428,0,'normal'),(114,'file',109,'member/multi','批量更新','fa fa-circle-o','','',0,1537972505,1540109428,0,'normal'),(115,'file',0,'address','用户收货地址管理','fa fa-circle-o','','',1,1537984078,1537984078,0,'normal'),(116,'file',115,'address/index','查看','fa fa-circle-o','','',0,1537984078,1540063097,0,'normal'),(117,'file',115,'address/add','添加','fa fa-circle-o','','',0,1537984078,1540063097,0,'normal'),(118,'file',115,'address/edit','编辑','fa fa-circle-o','','',0,1537984078,1540063097,0,'normal'),(119,'file',115,'address/del','删除','fa fa-circle-o','','',0,1537984078,1540063097,0,'normal'),(120,'file',115,'address/multi','批量更新','fa fa-circle-o','','',0,1537984078,1540063097,0,'normal'),(121,'file',0,'order','订单管理','fa fa-circle-o','','',1,1538210518,1538210518,0,'normal'),(122,'file',121,'order/index','查看','fa fa-circle-o','','',0,1538210518,1538230337,0,'normal'),(123,'file',121,'order/add','添加','fa fa-circle-o','','',0,1538210518,1538230337,0,'normal'),(124,'file',121,'order/edit','编辑','fa fa-circle-o','','',0,1538210518,1538230337,0,'normal'),(125,'file',121,'order/del','删除','fa fa-circle-o','','',0,1538210518,1538230337,0,'normal'),(126,'file',121,'order/multi','批量更新','fa fa-circle-o','','',0,1538210518,1538230337,0,'normal'),(127,'file',0,'sender','配送员管理','fa fa-circle-o','','',1,1540100680,1540100680,0,'normal'),(128,'file',127,'sender/index','查看','fa fa-circle-o','','',0,1540100680,1540658258,0,'normal'),(129,'file',127,'sender/add','添加','fa fa-circle-o','','',0,1540100680,1540658258,0,'normal'),(130,'file',127,'sender/edit','编辑','fa fa-circle-o','','',0,1540100680,1540658258,0,'normal'),(131,'file',127,'sender/del','删除','fa fa-circle-o','','',0,1540100680,1540658258,0,'normal'),(132,'file',127,'sender/multi','批量更新','fa fa-circle-o','','',0,1540100680,1540658258,0,'normal');

/*Table structure for table `elm_banner` */

DROP TABLE IF EXISTS `elm_banner`;

CREATE TABLE `elm_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `image` varchar(255) NOT NULL COMMENT '轮播图',
  `desc` varchar(500) NOT NULL COMMENT '图片描述',
  `createtime` int(11) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='首页轮播图';

/*Data for the table `elm_banner` */

insert  into `elm_banner`(`id`,`image`,`desc`,`createtime`) values (4,'/uploads/20180925/b5ac378fa232e59fb027f62788ce6372.jpg','banner2',1540711400),(5,'/uploads/20180925/c908ad2987e25597eeb3c39ec1d1a3da.png','111',1540735126);

/*Table structure for table `elm_category` */

DROP TABLE IF EXISTS `elm_category`;

CREATE TABLE `elm_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) NOT NULL DEFAULT '',
  `nickname` varchar(50) NOT NULL DEFAULT '',
  `flag` set('hot','index','recommend') NOT NULL DEFAULT '',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) NOT NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `weigh` (`weigh`,`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分类表';

/*Data for the table `elm_category` */

/*Table structure for table `elm_config` */

DROP TABLE IF EXISTS `elm_config`;

CREATE TABLE `elm_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text NOT NULL COMMENT '变量值',
  `content` text NOT NULL COMMENT '变量字典数据',
  `rule` varchar(100) NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统配置';

/*Data for the table `elm_config` */

insert  into `elm_config`(`id`,`name`,`group`,`title`,`tip`,`type`,`value`,`content`,`rule`,`extend`) values (1,'name','basic','Site name','请填写站点名称','string','外卖系统','','required',''),(2,'beian','basic','Beian','粤ICP备15054802号-4','string','','','',''),(3,'cdnurl','basic','Cdn url','如果静态资源使用第三方云储存请配置该值','string','','','',''),(4,'version','basic','Version','如果静态资源有变动请重新配置该值','string','1.0.1','','required',''),(5,'timezone','basic','Timezone','','string','Asia/Shanghai','','required',''),(6,'forbiddenip','basic','Forbidden ip','一行一条记录','text','','','',''),(7,'languages','basic','Languages','','array','{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}','','required',''),(8,'fixedpage','basic','Fixed page','请尽量输入左侧菜单栏存在的链接','string','dashboard','','required','');

/*Table structure for table `elm_goodcat` */

DROP TABLE IF EXISTS `elm_goodcat`;

CREATE TABLE `elm_goodcat` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mch_id` int(11) NOT NULL COMMENT '商户号',
  `name` varchar(10) NOT NULL COMMENT '分类名(不超过10字)',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重(可拖曳排序)',
  `updatetime` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

/*Data for the table `elm_goodcat` */

insert  into `elm_goodcat`(`id`,`mch_id`,`name`,`weigh`,`updatetime`) values (11,1004,'套餐系列',11,1540659753),(12,1004,'鸡排系列',12,1540659742),(13,1004,'奶茶系列',13,1540659783),(14,1004,'鲜果汁系类',14,1540659801),(15,1004,'鲜果茶系列',15,1540659824),(16,1004,'热饮系列',16,1540659840),(17,1004,'冰沙系列',17,1540659858),(18,1004,'热咖系列',18,1540659879),(19,1004,'四季圣代',19,1540659911),(20,1005,'1分钱测试',20,1540698416);

/*Table structure for table `elm_goods` */

DROP TABLE IF EXISTS `elm_goods`;

CREATE TABLE `elm_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mch_id` int(11) NOT NULL COMMENT '商户号',
  `goodcat_id` int(11) NOT NULL COMMENT '分类id',
  `name` varchar(15) NOT NULL COMMENT '商品名(不超过15字)',
  `image` varchar(255) NOT NULL COMMENT '商品图片',
  `desc` varchar(20) DEFAULT NULL COMMENT '商品描述(不超过20字)',
  `price` decimal(10,2) NOT NULL DEFAULT '0.01' COMMENT '商品价格(最低0.01元)',
  `sales` int(11) DEFAULT '0' COMMENT '月销量',
  `updatetime` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='商品表';

/*Data for the table `elm_goods` */

insert  into `elm_goods`(`id`,`mch_id`,`goodcat_id`,`name`,`image`,`desc`,`price`,`sales`,`updatetime`) values (19,1004,12,'骨肉相连7串','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','7串','10.00',0,1540660048),(20,1004,12,'骨肉相连3串','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','3串','5.00',0,1540660036),(21,1004,12,'孜然鸡排','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','孜然味','8.55',0,1540660108),(22,1004,12,'甘梅鸡排','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','甘梅味','8.55',0,1540660165),(23,1004,12,'香酥炸中鸡腿','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','4只装','7.50',0,1540660254),(24,1004,12,'香辣脆皮玉米','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','香辣味','6.00',0,1540660291),(25,1004,12,'甘梅脆皮玉米','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','甘梅味','6.00',0,1540660330),(26,1004,12,'大薯条','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','6.00',0,1540660373),(27,1004,12,'烤香肠','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','3根','5.50',0,1540660441),(28,1004,11,'香辣汉堡+骨肉相连3串','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','9.90',0,1540660506),(29,1004,11,'香辣汉堡+鸡肉卷','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','9.90',0,1540660548),(30,1004,11,'鸡排+橙汁','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','12.00',0,1540660575),(31,1004,11,'鸡排+西柚汁','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','12.00',0,1540660608),(32,1004,17,'草莓冰沙','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','8.00',0,1540660777),(33,1004,17,'芒果冰沙','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','8.00',0,1540660803),(34,1004,17,'蓝莓冰沙','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','8.00',0,1540660827),(35,1004,17,'红豆冰沙','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','8.00',0,1540660852),(36,1004,17,'绿豆冰沙','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','8.00',0,1540660874),(37,1004,19,'巧克力圣代','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','6.00',0,1540660928),(38,1004,13,'黑钻奶茶','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','烧仙草与龟苓膏的结合，嫩滑弹糯','4.00',0,1540661008),(39,1004,13,'红豆奶茶','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','4.00',0,1540661051),(40,1004,13,'珍珠奶茶','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','','4.00',0,1540661077),(41,1005,20,'dd','/uploads/20181028/989d0a2362de861be75f23854c388446.png','dd','0.01',0,1540698424),(42,1005,20,'5555555','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','00000','0.01',0,1540734999);

/*Table structure for table `elm_mch` */

DROP TABLE IF EXISTS `elm_mch`;

CREATE TABLE `elm_mch` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商户号',
  `name` varchar(255) NOT NULL COMMENT '商家名称',
  `image` varchar(255) NOT NULL COMMENT '商家logo',
  `request_price` decimal(10,2) DEFAULT '0.00' COMMENT '起送价',
  `send_price` decimal(10,2) DEFAULT '0.00' COMMENT '配送费',
  `desc` varchar(500) NOT NULL COMMENT '店铺描述',
  `licence_images` varchar(500) DEFAULT NULL COMMENT '营业执照',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商家余额',
  `contact` varchar(255) NOT NULL COMMENT '商家电话',
  `city` varchar(255) NOT NULL COMMENT '地区',
  `addr` varchar(255) NOT NULL COMMENT '地址',
  `usetime` int(2) NOT NULL DEFAULT '38' COMMENT '预计送达时间(整数)',
  `lng` varchar(255) DEFAULT '0' COMMENT '位置：经度',
  `lat` varchar(255) DEFAULT '0' COMMENT '位置：纬度',
  `createtime` int(11) DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1028 DEFAULT CHARSET=utf8 COMMENT='商家';

/*Data for the table `elm_mch` */

insert  into `elm_mch`(`id`,`name`,`image`,`request_price`,`send_price`,`desc`,`licence_images`,`money`,`contact`,`city`,`addr`,`usetime`,`lng`,`lat`,`createtime`) values (1005,'111111','/uploads/20181028/989d0a2362de861be75f23854c388446.png','0.01','0.01','dsa ','','0.04','18032841463','海南省/东方市/天安乡','das',28,'0','0',1540691012),(1027,'11111','/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg','0.01','0.01','111111','','0.00','15797638189','安徽省/芜湖市/鸠江区','111111',38,'0','0',1540734824);

/*Table structure for table `elm_member` */

DROP TABLE IF EXISTS `elm_member`;

CREATE TABLE `elm_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `openid` varchar(255) NOT NULL DEFAULT '' COMMENT 'openid',
  `nickname` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `gender` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '性别:0=保密,1=男,2=女',
  `senderid` int(11) DEFAULT NULL COMMENT '配送员id',
  `logintime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `lastip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `openid` (`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';

/*Data for the table `elm_member` */

insert  into `elm_member`(`id`,`openid`,`nickname`,`mobile`,`image`,`gender`,`senderid`,`logintime`,`lastip`,`createtime`,`updatetime`) values (1008,'oKmj15cmR7qa1gGC2w0csEkFnc-s','小胖','133','https://wx.qlogo.cn/mmopen/vi_32/DjB30TCOeyNTmayUZtqk7PE94pfYY5DjYabmia6zCHicPrFU7j9F7swPf1WnqFNcqbKIUiaY8M1f50M6wowue5agQ/132','1',1001,1540050651,'106.114.207.193',1540050651,1540109568),(1009,'oKmj15R4sg1-FgoBQVu2scm5VS3U','从小就是前三名','133','https://wx.qlogo.cn/mmopen/vi_32/ObicznN9AmRl4DMSuyJUHIA5xq4fHFV37aeJkRU1omWyGqbztJFYrTVlF20h97xQzP7MQH1T4LgjKsLCHiauYpSg/132','2',1000,1540091092,'221.192.178.134',1540091092,1540109558),(1010,'oKmj15SQctK1xRyVKNTvuz7EREto','JamesLiu','15797638189','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJrNjweL80MOlfRWWhEhn2pRkpibMgPvviaM5HUW2Yt6YibyaAgqfCfhdAaDVRnlibmQVRvYzes6a8yicA/132','1',1000,1540126964,'223.82.96.10',1540126964,1540128107),(1011,'oKmj15ci5798-7JoHWxa7Vra5Kac','','','https://wx.qlogo.cn/mmopen/vi_32/9I18anuM1NZulyTibL8Q5ic7b4r9aGHiaOZENenlyzHLYxLmcbVY8iaGHlHYODTWQhodKqBV1cCIILibnG8biaGPtMWg/132','1',NULL,1540127392,'221.192.180.117',1540127392,1540127392),(1012,'oKmj15eMVC4MCYvetEh8GdPRAy2Q','武松','','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJA8emicf4S47jydDkeibT3IGib3tp1eymFkjyg1ibzhhaibSvgF9gZa94Rch4qxibibYWon7IKLiaPewGQyA/132','0',NULL,1540714378,'101.227.139.173',1540714378,1540714378),(1013,'oKmj15e7ebk4mNGBGu-cXuJxDrJ8','张清','','https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIhZtMuP2sXfBNoHN56jicLrH5gGCmx5Ob9YIJJT9icIVSfKhVnlTmBWaQHJDHJH5eCIA9GaicTMmUMg/132','0',NULL,1540730779,'101.91.60.110',1540730779,1540730779);

/*Table structure for table `elm_order` */

DROP TABLE IF EXISTS `elm_order`;

CREATE TABLE `elm_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `mchid` int(11) NOT NULL COMMENT '店铺id',
  `addressid` int(11) NOT NULL COMMENT '地址id',
  `senderid` int(11) DEFAULT NULL COMMENT '配送员id',
  `order` text NOT NULL COMMENT '货物清单',
  `sendprice` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送费',
  `totalprice` decimal(10,2) NOT NULL DEFAULT '0.01' COMMENT '付款金额',
  `status` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1' COMMENT '订单状态:1=待支付,2=待接单,3=待配送,4=配送中,5=已完成,0=已取消',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `paytime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付时间',
  `gettime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接单时间',
  `sendtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配送时间',
  `finishtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '完成时间',
  `canceltime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '取消时间',
  `desc` varchar(255) DEFAULT '感谢您对我们的信任,期待再次光临' COMMENT '备注',
  `formid` varchar(255) DEFAULT NULL COMMENT '通知formid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1182 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单表';

/*Data for the table `elm_order` */

insert  into `elm_order`(`id`,`userid`,`mchid`,`addressid`,`senderid`,`order`,`sendprice`,`totalprice`,`status`,`createtime`,`paytime`,`gettime`,`sendtime`,`finishtime`,`canceltime`,`desc`,`formid`) values (1172,1010,1004,13,1000,'[{\"price\":\"9.90\",\"num\":2,\"mark\":\"a0b11\",\"name\":\"香辣汉堡+鸡肉卷\",\"image\":\"/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg\",\"index\":0,\"parentIndex\":\"11\",\"totalprice\":\"19.80\"}]','2.00','21.80','1',1540661439,0,0,0,0,0,'订单待支付',NULL),(1173,1010,1004,13,1000,'[{\"price\":\"4.00\",\"num\":3,\"mark\":\"a0b13\",\"name\":\"黑钻奶茶\",\"image\":\"/uploads/20181027/e6b866a2ed7396dd4f97c9b97623b47e.jpg\",\"index\":0,\"parentIndex\":\"13\",\"totalprice\":\"12.00\"}]','2.00','14.00','1',1540661815,0,0,0,0,0,'订单待支付',NULL),(1178,1010,1005,13,1005,'[{\"price\":\"0.01\",\"num\":1,\"mark\":\"a0b17\",\"name\":\"dd\",\"image\":\"/uploads/20181028/989d0a2362de861be75f23854c388446.png\",\"index\":0,\"parentIndex\":\"17\",\"totalprice\":\"0.01\"}]','0.01','0.02','5',1540691659,1540691667,1540691667,1540691667,1540692454,0,'订单已完成，期待下次光临','wx280954199633523d143d26d53364282945'),(1181,1008,1005,14,1005,'[{\"price\":\"0.01\",\"num\":1,\"mark\":\"a0b17\",\"name\":\"dd\",\"image\":\"/uploads/20181028/989d0a2362de861be75f23854c388446.png\",\"index\":0,\"parentIndex\":\"17\",\"totalprice\":\"0.01\"}]','0.01','0.02','4',1540692485,1540692491,1540692491,1540692491,0,0,'您的订单正在配送中，请稍后','wx28100805552943896a1b384e1526876537');

/*Table structure for table `elm_sender` */

DROP TABLE IF EXISTS `elm_sender`;

CREATE TABLE `elm_sender` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '配送员ID',
  `name` varchar(255) NOT NULL COMMENT '配送员电话姓名',
  `phone` varchar(255) NOT NULL COMMENT '配送员电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8 COMMENT='配送员表';

/*Data for the table `elm_sender` */

insert  into `elm_sender`(`id`,`name`,`phone`) values (1000,'待支付','勿动'),(1004,'李龙轩','15947622092'),(1005,'季俊彤','15132841715');

/*Table structure for table `elm_user` */

DROP TABLE IF EXISTS `elm_user`;

CREATE TABLE `elm_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) NOT NULL DEFAULT '' COMMENT '格言',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `logintime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `loginip` varchar(50) NOT NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) NOT NULL DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) NOT NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员表';

/*Data for the table `elm_user` */

/*Table structure for table `elm_user_group` */

DROP TABLE IF EXISTS `elm_user_group`;

CREATE TABLE `elm_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '组名',
  `rules` text COMMENT '权限节点',
  `createtime` int(10) DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员组表';

/*Data for the table `elm_user_group` */

insert  into `elm_user_group`(`id`,`name`,`rules`,`createtime`,`updatetime`,`status`) values (1,'默认组','1,2,3,4,5,6,7,8,9,10,11,12',1515386468,1516168298,'normal');

/*Table structure for table `elm_user_rule` */

DROP TABLE IF EXISTS `elm_user_rule`;

CREATE TABLE `elm_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `title` varchar(50) DEFAULT '' COMMENT '标题',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员规则表';

/*Data for the table `elm_user_rule` */

insert  into `elm_user_rule`(`id`,`pid`,`name`,`title`,`remark`,`ismenu`,`createtime`,`updatetime`,`weigh`,`status`) values (1,0,'index','前台','',1,1516168079,1516168079,1,'normal'),(2,0,'api','API接口','',1,1516168062,1516168062,2,'normal'),(3,1,'user','会员模块','',1,1515386221,1516168103,12,'normal'),(4,2,'user','会员模块','',1,1515386221,1516168092,11,'normal'),(5,3,'index/user/login','登录','',0,1515386247,1515386247,5,'normal'),(6,3,'index/user/register','注册','',0,1515386262,1516015236,7,'normal'),(7,3,'index/user/index','会员中心','',0,1516015012,1516015012,9,'normal'),(8,3,'index/user/profile','个人资料','',0,1516015012,1516015012,4,'normal'),(9,4,'api/user/login','登录','',0,1515386247,1515386247,6,'normal'),(10,4,'api/user/register','注册','',0,1515386262,1516015236,8,'normal'),(11,4,'api/user/index','会员中心','',0,1516015012,1516015012,10,'normal'),(12,4,'api/user/profile','个人资料','',0,1516015012,1516015012,3,'normal');

/*Table structure for table `elm_user_score_log` */

DROP TABLE IF EXISTS `elm_user_score_log`;

CREATE TABLE `elm_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员积分变动表';

/*Data for the table `elm_user_score_log` */

/*Table structure for table `elm_user_token` */

DROP TABLE IF EXISTS `elm_user_token`;

CREATE TABLE `elm_user_token` (
  `token` varchar(50) NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `expiretime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员Token表';

/*Data for the table `elm_user_token` */

/*Table structure for table `elm_version` */

DROP TABLE IF EXISTS `elm_version`;

CREATE TABLE `elm_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) NOT NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) NOT NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) NOT NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) NOT NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) NOT NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='版本表';

/*Data for the table `elm_version` */

insert  into `elm_version`(`id`,`oldversion`,`newversion`,`packagesize`,`content`,`downloadurl`,`enforce`,`createtime`,`updatetime`,`weigh`,`status`) values (1,'1.1.1,2','1.2.1','20M','更新内容','https://www.fastadmin.net/download.html',1,1520425318,0,0,'normal');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
