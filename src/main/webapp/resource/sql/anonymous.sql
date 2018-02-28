/*
SQLyog v10.2 
MySQL - 5.7.21 : Database - anonymous
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`anonymous` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `anonymous`;

/*Table structure for table `an_anonym` */

DROP TABLE IF EXISTS `an_anonym`;

CREATE TABLE `an_anonym` (
  `anonymId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `nickName` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '昵称',
  `userName` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '账号',
  `quickPassword` varchar(200) DEFAULT NULL COMMENT '快捷登陆密码',
  `password` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码',
  `headerImg` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '头像',
  `phone` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '手机号码',
  `isLock` int(5) DEFAULT '1' COMMENT '是否锁定，1-未锁定，0-已锁定',
  `deviceId` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '设备唯一标识',
  `lockReason` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '锁定理由',
  `delFlag` int(5) DEFAULT '1' COMMENT '删除标识，1-未删除，0-已删除',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`anonymId`),
  KEY `anonym_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_anonym` */

insert  into `an_anonym`(`anonymId`,`nickName`,`userName`,`quickPassword`,`password`,`headerImg`,`phone`,`isLock`,`deviceId`,`lockReason`,`delFlag`,`createTime`,`updateTime`) values ('a9af89e8-3a26-4386-b379-ae15dde2e05f','张三','18320172397','AD3437AD4CB1D8BE759599AE32E0F50F',NULL,'','18320172397',1,'864664034884823',NULL,1,'2018-02-22 10:23:28','2018-02-22 10:23:28');

/*Table structure for table `an_anonymreport` */

DROP TABLE IF EXISTS `an_anonymreport`;

CREATE TABLE `an_anonymreport` (
  `reportId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `passiveAnonymId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '被举报用户id',
  `activeAnonymId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '举报用户id',
  `reportReason` longtext CHARACTER SET utf8 COMMENT '举报理由',
  `isHandle` int(5) DEFAULT NULL COMMENT '是否处理，1-已处理，0-未处理',
  `reportResult` longtext CHARACTER SET utf8 COMMENT '处理结果',
  `repotHandleTime` datetime DEFAULT NULL COMMENT '处理时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`reportId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_anonymreport` */

/*Table structure for table `an_card` */

DROP TABLE IF EXISTS `an_card`;

CREATE TABLE `an_card` (
  `cardId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `cardContent` varchar(255) NOT NULL COMMENT '卡片内容',
  `cardImg` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '卡片图片',
  `isLock` int(5) DEFAULT '1' COMMENT '是否锁定，1-未锁定，0-已锁定',
  `lockReason` longtext CHARACTER SET utf8 COMMENT '锁定理由',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `delFlag` int(5) DEFAULT '1' COMMENT '删除标识，1-未删除，0-已删除',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`cardId`),
  KEY `card_anonymId` (`anonymId`),
  CONSTRAINT `card_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_card` */

insert  into `an_card`(`cardId`,`cardContent`,`cardImg`,`isLock`,`lockReason`,`createTime`,`updateTime`,`delFlag`,`anonymId`) values ('06551068-2655-460b-9093-bf7490a531b9','啦啦啦我是卖报的小耿家，噶牛股你听?你女你替我???嗯嗯嗯','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqROTqAY0VyAABa7gBWQz07871475',1,NULL,'2018-02-24 11:40:41','2018-02-24 11:40:41',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('0f10203a-478e-42db-a34f-c452ede5f8ce','哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqOzHaAJOh-AABt4LhgBNA2383111',1,NULL,'2018-02-22 15:29:11','2018-02-22 15:29:11',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('35a707ae-427a-4d46-8ded-3d38a800f4b3','哈哈哈哈哈哈哈啦啦啦啦啦嗯嗯嗯嗯???','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqUBc2AahgJAACLbD4Sizg2494109',1,NULL,'2018-02-26 14:40:25','2018-02-26 14:40:25',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('389428d5-c0a8-483a-b9cc-1023ff7c0242','哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啦啦啦啦啦啦啦啦啦啦','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqOzJeAFqClAABt4LhgBNA5973993',1,NULL,'2018-02-22 15:29:44','2018-02-22 15:29:44',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('3dea7b63-5c58-4016-8263-d3b6c695798f','又来了一个??哈哈哈哈哈哈哈????就送','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqOh16ADPhLAABuLQjZLCs6689290',1,NULL,'2018-02-22 10:33:18','2018-02-22 10:33:18',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('43ec2793-bb96-45f1-b8fb-3df409ddca07','哈哈哈哈哈哈哈啦啦啦啦啦啦嗯嗯嗯嗯他他他他','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqRPuiAYsbjAACT8w2EGqc9510388',1,NULL,'2018-02-24 12:05:00','2018-02-24 12:05:00',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('5d1a76f9-e7b4-48e6-992f-b82db0cb0d4c','哈哈还改变哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqOvkOAX8ZfAABuicimwVo4630427',1,NULL,'2018-02-22 14:28:22','2018-02-22 14:28:22',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('a87d57a0-e60a-4d27-954b-a1089f87bcdf','卡片来啦来啦，哈哈哈哈哈哈哈，我又来啦，你怎么样呢？我也不洗了','http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVHumAPvdwAAByMagGqUc0511078',1,NULL,'2018-02-27 10:40:45','2018-02-27 10:40:45',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('aa9e6dc0-d74e-4da6-8cb8-cb4702490914','啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqOzYiAOGBrAABt4LhgBNA7831873',1,NULL,'2018-02-22 15:33:46','2018-02-22 15:33:46',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('d2bf26fd-79f6-4a2e-9032-9417386b255d','哈哈哈哈哈哈哈??啦啦啦????','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqOhuuAaXvPAABuXtfqT2k6908370',1,NULL,'2018-02-22 10:31:23','2018-02-22 10:31:23',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f'),('dbfa2699-43c8-4bbd-8841-57d011320e2c','哈哈哈哈哈哈哈啦啦啦啦啦哈哈哈哈哈哈哈啦啦啦啦啦','http://0gmg8ue.hn3.mofasuidao.cn/group1/M00/00/01/wKgLgVqOzbmABWa-AABt4LhgBNA5244656',1,NULL,'2018-02-22 15:34:35','2018-02-22 15:34:35',1,'a9af89e8-3a26-4386-b379-ae15dde2e05f');

/*Table structure for table `an_cardcollection` */

DROP TABLE IF EXISTS `an_cardcollection`;

CREATE TABLE `an_cardcollection` (
  `cardCollectionId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  `cardId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '卡片id',
  PRIMARY KEY (`cardCollectionId`),
  KEY `collection_anonymId` (`anonymId`),
  KEY `collection_cardId` (`cardId`),
  CONSTRAINT `collection_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `collection_cardId` FOREIGN KEY (`cardId`) REFERENCES `an_card` (`cardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_cardcollection` */

insert  into `an_cardcollection`(`cardCollectionId`,`createTime`,`updateTime`,`anonymId`,`cardId`) values ('b9d303e1-6722-4688-a9fe-d166574af2d3','2018-02-23 14:28:05','2018-02-23 14:28:05','a9af89e8-3a26-4386-b379-ae15dde2e05f','d2bf26fd-79f6-4a2e-9032-9417386b255d');

/*Table structure for table `an_cardcomment` */

DROP TABLE IF EXISTS `an_cardcomment`;

CREATE TABLE `an_cardcomment` (
  `cardCommentId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `cardCommentContent` varchar(255) NOT NULL COMMENT '评论内容',
  `carCommentReplyId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '回复评论id',
  `delFlag` int(5) DEFAULT '1' COMMENT '删除标识，1-未删除，0-已删除',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  `cardId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '卡片id',
  PRIMARY KEY (`cardCommentId`),
  KEY `comment_cardId` (`cardId`),
  KEY `comment_anonymId` (`anonymId`),
  CONSTRAINT `comment_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `comment_cardId` FOREIGN KEY (`cardId`) REFERENCES `an_card` (`cardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_cardcomment` */

insert  into `an_cardcomment`(`cardCommentId`,`cardCommentContent`,`carCommentReplyId`,`delFlag`,`createTime`,`updateTime`,`anonymId`,`cardId`) values ('013b86ab-2f4f-4b38-a6b5-96b8b7815ca4','嗯嗯嗯',NULL,1,'2018-02-22 11:46:38','2018-02-22 11:46:38','a9af89e8-3a26-4386-b379-ae15dde2e05f','d2bf26fd-79f6-4a2e-9032-9417386b255d'),('015dbc07-ac46-4b5b-9b10-3fde99198f7d','哈哈哈哈哈哈哈',NULL,1,'2018-02-22 15:56:29','2018-02-22 15:56:29','a9af89e8-3a26-4386-b379-ae15dde2e05f','aa9e6dc0-d74e-4da6-8cb8-cb4702490914'),('8b9a0980-9fc9-43ac-b40a-dc7c43f3d1b5','哈哈哈哈哈哈哈???',NULL,1,'2018-02-22 11:43:25','2018-02-22 11:43:25','a9af89e8-3a26-4386-b379-ae15dde2e05f','d2bf26fd-79f6-4a2e-9032-9417386b255d'),('e57dc2ef-287c-4606-870c-0af7a0e08567','嗯嗯嗯嗯',NULL,1,'2018-02-23 10:54:47','2018-02-23 10:54:47','a9af89e8-3a26-4386-b379-ae15dde2e05f','5d1a76f9-e7b4-48e6-992f-b82db0cb0d4c');

/*Table structure for table `an_cardcommentfabulous` */

DROP TABLE IF EXISTS `an_cardcommentfabulous`;

CREATE TABLE `an_cardcommentfabulous` (
  `cardCommentFabulousId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `cardCommentId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '评论id',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`cardCommentFabulousId`),
  KEY `cardcommentfabulous_anonymId` (`anonymId`),
  KEY `cardcommentfabulous_cardCommentId` (`cardCommentId`),
  CONSTRAINT `cardcommentfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `cardcommentfabulous_cardCommentId` FOREIGN KEY (`cardCommentId`) REFERENCES `an_cardcomment` (`cardCommentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_cardcommentfabulous` */

insert  into `an_cardcommentfabulous`(`cardCommentFabulousId`,`createTime`,`updateTime`,`cardCommentId`,`anonymId`) values ('37b1dc48-2771-4ba2-aa36-dd1407d57979','2018-02-22 17:22:40','2018-02-22 17:22:40','015dbc07-ac46-4b5b-9b10-3fde99198f7d','a9af89e8-3a26-4386-b379-ae15dde2e05f'),('4ea84cbe-4e2b-4840-807a-8a6305fab270','2018-02-22 11:46:23','2018-02-22 11:46:23','8b9a0980-9fc9-43ac-b40a-dc7c43f3d1b5','a9af89e8-3a26-4386-b379-ae15dde2e05f'),('5c12eb25-87f2-4ade-a3c2-df4250aa24ee','2018-02-22 14:33:14','2018-02-22 14:33:14','013b86ab-2f4f-4b38-a6b5-96b8b7815ca4','a9af89e8-3a26-4386-b379-ae15dde2e05f'),('6f45940d-cf20-4cbe-9062-c3eca7f8d8d4','2018-02-22 15:56:37','2018-02-22 15:56:37','015dbc07-ac46-4b5b-9b10-3fde99198f7d','a9af89e8-3a26-4386-b379-ae15dde2e05f'),('f734657f-58a8-4bab-b4a2-f87dca5e4bb9','2018-02-23 10:54:51','2018-02-23 10:54:51','e57dc2ef-287c-4606-870c-0af7a0e08567','a9af89e8-3a26-4386-b379-ae15dde2e05f');

/*Table structure for table `an_cardfabulous` */

DROP TABLE IF EXISTS `an_cardfabulous`;

CREATE TABLE `an_cardfabulous` (
  `cardFabulousId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `cardId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '卡片id',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`cardFabulousId`),
  KEY `cardfabulous_anonymId` (`anonymId`),
  KEY `cardfabulous_cardId` (`cardId`),
  CONSTRAINT `cardfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `cardfabulous_cardId` FOREIGN KEY (`cardId`) REFERENCES `an_card` (`cardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_cardfabulous` */

insert  into `an_cardfabulous`(`cardFabulousId`,`createTime`,`updateTime`,`cardId`,`anonymId`) values ('d08797cc-4761-4171-9585-738234b4ad95','2018-02-23 11:47:32','2018-02-23 11:47:32','d2bf26fd-79f6-4a2e-9032-9417386b255d','a9af89e8-3a26-4386-b379-ae15dde2e05f');

/*Table structure for table `an_story` */

DROP TABLE IF EXISTS `an_story`;

CREATE TABLE `an_story` (
  `storyId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `storyTitle` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '标题',
  `storyContent` longtext CHARACTER SET utf8 NOT NULL COMMENT '内容',
  `storyArticleSummary` varchar(200) NOT NULL COMMENT '内容概述',
  `isLock` int(5) DEFAULT '1' COMMENT '是否锁定，1-未锁定，0-已锁定',
  `lockReason` longtext CHARACTER SET utf8 COMMENT '锁定理由',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '作者（即用户）',
  PRIMARY KEY (`storyId`),
  KEY `story_anonymId` (`anonymId`),
  CONSTRAINT `story_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_story` */

insert  into `an_story`(`storyId`,`storyTitle`,`storyContent`,`storyArticleSummary`,`isLock`,`lockReason`,`updateTime`,`createTime`,`anonymId`) values ('57de42ea-109f-472b-98fb-52fdd8c45cc9','12级了','回老家了就在啦咯啦咯啦咯啦考虑啦咯YY紧张哈裤子旅游卢嘉威阿里旺旺哈裤子看看你啊咯旅游就<img src=\"http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVUueARhwgAAF0naPDjTM7676344\" width=\"100%\"><br>low龙龙龙卢嘉威low看看你旅游哈裤子斗图啦咯YY或者low窟窿啦咯YY骨科医院哈裤子给了我<img src=\"http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVUv2ATkGUAAA6Yvm_xCQ9362314\" width=\"100%\"><br>花魁小镇胡伟伟胡伟伟故意故意','回老家了就在啦咯啦咯啦咯啦考虑啦咯YY紧张哈裤子旅游卢嘉威阿里旺旺哈裤子看看你啊咯旅游就low龙龙龙卢嘉威low看看你',1,NULL,'2018-02-27 14:28:10','2018-02-27 14:28:10','a9af89e8-3a26-4386-b379-ae15dde2e05f'),('5a327926-32ab-4a88-aecd-3574c3203575','小乖乖','来来来你住您是在给摸席子点赞hoity-toity你一你以为你以为你这你住们去翻去一种订位洗衣液你住一休哥定义你这一嘴洗衣液<img src=\"http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVW6CAMdjAAAYLWs8pYGQ6976265\" width=\"100%\"><br>你要去一只手指用肉在人转切转切也洗衣液跟我说一下三五十万人做人做最肉跟我说一声三五十万人做人做最肉人做人做最肉三五十万三五十万三五十万三五十万三五十万朋友圈7桌7桌搜一下死罪孽1我三五十万搜一下死罪孽1我三五十万在真肉在说切也我是<img src=\"http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVXDiAGmqTAAwgtcuQnOI9915655\" width=\"100%\"><br>还车将计就计里拉萝莉控干嘛窟窿后台好困呵护我骨科医院呼吸机给了我骨科医院哈裤子就我居住证居住证','来来来你住您是在给摸席子点赞hoity-toity你一你以为你以为你这你住们去翻去一种订位洗衣液你住一休哥定义你这一嘴',1,NULL,'2018-02-27 15:32:25','2018-02-27 15:32:25','a9af89e8-3a26-4386-b379-ae15dde2e05f'),('6c17818e-0777-43d0-a8c5-b294052d1789','还哈你住','你住你住洗衣液鸿泥雪爪你以为XP嘻嘻一张纸嘻嘻嘻嘻只上YY是用肉在人转切转切也还没到我怎么只到我会修护做生意去朋友圈用肉在去外婆热公寓害羞死我人做人做最肉人做人做最肉三五十万<img src=\"http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVV82AWVicAAF0naPDjTM3492997\" width=\"100%\"><br>还继续明天河流之王去去一只手指害羞死我一只手指用肉在人做最肉在人转切让学说切转切转切转啥子用肉在人转切也破功鸿泥雪爪心情我是新人笑三五十万三五十万三五十万朋友圈三姨丈三五十万搜狗民<img src=\"http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVV-2AJuYdAAA6Yvm_xCQ0667391\" width=\"100%\"><br>你住洗衣液WPS五XPXP我三五十万小片片朋友圈朋友圈三五十万三五十万随手一拍朋友圈三姨丈三五十万三十万三五十万三五十万朋友圈三姨丈红三五十万三五十万三五十万三五十万三五十万三五十万三五十万三五十万三五十万三姨丈一晚上佩服明<img src=\"http://0gmg8ue.hn3.mofasuidao.cn:80/group1/M00/00/01/wKgLgVqVWBWANIE8AAJlFM2Es3w0246587\" width=\"100%\"><br>你好污一起早睡早起三十万朋友圈','你住你住洗衣液鸿泥雪爪你以为XP嘻嘻一张纸嘻嘻嘻嘻只上YY是用肉在人转切转切也还没到我怎么只到我会修护做生意去朋友圈用',1,NULL,'2018-02-27 14:45:43','2018-02-27 14:45:43','a9af89e8-3a26-4386-b379-ae15dde2e05f');

/*Table structure for table `an_storycollection` */

DROP TABLE IF EXISTS `an_storycollection`;

CREATE TABLE `an_storycollection` (
  `storyCollectiionId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  `storyId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '故事id',
  PRIMARY KEY (`storyCollectiionId`),
  KEY `storycollection_storyId` (`storyId`),
  KEY `storycollection_anonymId` (`anonymId`),
  CONSTRAINT `storycollection_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storycollection_storyId` FOREIGN KEY (`storyId`) REFERENCES `an_story` (`storyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_storycollection` */

/*Table structure for table `an_storycomment` */

DROP TABLE IF EXISTS `an_storycomment`;

CREATE TABLE `an_storycomment` (
  `storyCommentId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `storyCommentContent` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '评论内容',
  `styroReplyCommentId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '回复故事的id，不是回复的评论为null',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `delFlag` int(5) DEFAULT NULL COMMENT '删除标识，1-未删除，0-未删除',
  `storyId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '故事id',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`storyCommentId`),
  KEY `storycomment_anonymId` (`anonymId`),
  KEY `storycomment_storyId` (`storyId`),
  CONSTRAINT `storycomment_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storycomment_storyId` FOREIGN KEY (`storyId`) REFERENCES `an_story` (`storyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_storycomment` */

/*Table structure for table `an_storycommentfabulous` */

DROP TABLE IF EXISTS `an_storycommentfabulous`;

CREATE TABLE `an_storycommentfabulous` (
  `StoryCommentFabulousId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `storyCommentId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '评论id',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`StoryCommentFabulousId`),
  KEY `storycommentfabulous_anonymId` (`anonymId`),
  KEY `storycommentfabulous_storyCommentId` (`storyCommentId`),
  CONSTRAINT `storycommentfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storycommentfabulous_storyCommentId` FOREIGN KEY (`storyCommentId`) REFERENCES `an_storycomment` (`storyCommentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_storycommentfabulous` */

/*Table structure for table `an_storyfabulous` */

DROP TABLE IF EXISTS `an_storyfabulous`;

CREATE TABLE `an_storyfabulous` (
  `storyFabulousId` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `storyId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '故事id',
  `anonymId` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`storyFabulousId`),
  KEY `storyfabulous_anonymId` (`anonymId`),
  KEY `storyfabulous_storyId` (`storyId`),
  CONSTRAINT `storyfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storyfabulous_storyId` FOREIGN KEY (`storyId`) REFERENCES `an_story` (`storyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `an_storyfabulous` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
