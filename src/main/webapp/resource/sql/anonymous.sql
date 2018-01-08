/*
SQLyog v10.2 
MySQL - 5.7.12-log : Database - anonymous
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`anonymous` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `anonymous`;

/*Table structure for table `an_anonym` */

DROP TABLE IF EXISTS `an_anonym`;

CREATE TABLE `an_anonym` (
  `anonymId` varchar(100) NOT NULL COMMENT '主键',
  `nickName` varchar(100) DEFAULT NULL COMMENT '昵称',
  `userName` varchar(100) DEFAULT NULL COMMENT '账号',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `headerImg` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` varchar(50) DEFAULT NULL COMMENT '手机号码',
  `lock` int(5) DEFAULT '1' COMMENT '是否锁定，1-未锁定，0-已锁定',
  `deviceId` varchar(255) DEFAULT NULL COMMENT '设备唯一标识',
  `lockReason` varchar(255) DEFAULT NULL COMMENT '锁定理由',
  `delFlag` int(5) DEFAULT '1' COMMENT '删除标识，1-未删除，0-已删除',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`anonymId`),
  KEY `anonym_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_anonym` */

/*Table structure for table `an_anonymreport` */

DROP TABLE IF EXISTS `an_anonymreport`;

CREATE TABLE `an_anonymreport` (
  `reportId` varchar(100) NOT NULL COMMENT '主键',
  `passiveAnonymId` varchar(100) NOT NULL COMMENT '被举报用户id',
  `activeAnonymId` varchar(100) NOT NULL COMMENT '举报用户id',
  `reportReason` longtext COMMENT '举报理由',
  `isHandle` int(5) DEFAULT NULL COMMENT '是否处理，1-已处理，0-未处理',
  `reportResult` longtext COMMENT '处理结果',
  `repotHandleTime` datetime DEFAULT NULL COMMENT '处理时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`reportId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_anonymreport` */

/*Table structure for table `an_card` */

DROP TABLE IF EXISTS `an_card`;

CREATE TABLE `an_card` (
  `cardId` varchar(100) NOT NULL COMMENT '主键',
  `cardContent` longtext NOT NULL COMMENT '卡片内容',
  `cardImg` varchar(255) DEFAULT NULL COMMENT '卡片图片',
  `lock` int(5) DEFAULT NULL COMMENT '是否锁定，1-未锁定，0-已锁定',
  `lockReason` longtext COMMENT '锁定理由',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `delFlag` int(5) DEFAULT NULL COMMENT '删除标识，1-未删除，0-已删除',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`cardId`),
  KEY `card_anonymId` (`anonymId`),
  CONSTRAINT `card_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_card` */

/*Table structure for table `an_cardcollection` */

DROP TABLE IF EXISTS `an_cardcollection`;

CREATE TABLE `an_cardcollection` (
  `cardCollectiionId` varchar(100) NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  `cardId` varchar(100) DEFAULT NULL COMMENT '卡片id',
  PRIMARY KEY (`cardCollectiionId`),
  KEY `collection_anonymId` (`anonymId`),
  KEY `collection_cardId` (`cardId`),
  CONSTRAINT `collection_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `collection_cardId` FOREIGN KEY (`cardId`) REFERENCES `an_card` (`cardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_cardcollection` */

/*Table structure for table `an_cardcomment` */

DROP TABLE IF EXISTS `an_cardcomment`;

CREATE TABLE `an_cardcomment` (
  `cardCommentId` varchar(100) NOT NULL COMMENT '主键',
  `cardCommentContent` varchar(255) NOT NULL COMMENT '评论内容',
  `carCommentReplyId` varchar(100) DEFAULT NULL COMMENT '回复评论id',
  `delFlag` int(5) DEFAULT NULL COMMENT '删除标识，1-未删除，0-已删除',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  `cardId` varchar(100) DEFAULT NULL COMMENT '卡片id',
  PRIMARY KEY (`cardCommentId`),
  KEY `comment_cardId` (`cardId`),
  KEY `comment_anonymId` (`anonymId`),
  CONSTRAINT `comment_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `comment_cardId` FOREIGN KEY (`cardId`) REFERENCES `an_card` (`cardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_cardcomment` */

/*Table structure for table `an_cardcommentfabulous` */

DROP TABLE IF EXISTS `an_cardcommentfabulous`;

CREATE TABLE `an_cardcommentfabulous` (
  `cardCommentFabulousId` varchar(100) NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `cardCommentId` varchar(100) DEFAULT NULL COMMENT '评论id',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`cardCommentFabulousId`),
  KEY `cardcommentfabulous_anonymId` (`anonymId`),
  KEY `cardcommentfabulous_cardCommentId` (`cardCommentId`),
  CONSTRAINT `cardcommentfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `cardcommentfabulous_cardCommentId` FOREIGN KEY (`cardCommentId`) REFERENCES `an_cardcomment` (`cardCommentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_cardcommentfabulous` */

/*Table structure for table `an_cardfabulous` */

DROP TABLE IF EXISTS `an_cardfabulous`;

CREATE TABLE `an_cardfabulous` (
  `cardFabulousId` varchar(100) NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `cardId` varchar(100) DEFAULT NULL COMMENT '卡片id',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`cardFabulousId`),
  KEY `cardfabulous_anonymId` (`anonymId`),
  KEY `cardfabulous_cardId` (`cardId`),
  CONSTRAINT `cardfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `cardfabulous_cardId` FOREIGN KEY (`cardId`) REFERENCES `an_card` (`cardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_cardfabulous` */

/*Table structure for table `an_story` */

DROP TABLE IF EXISTS `an_story`;

CREATE TABLE `an_story` (
  `storyId` varchar(100) NOT NULL COMMENT '主键',
  `storyTitle` varchar(200) DEFAULT NULL COMMENT '标题',
  `storyContent` longtext COMMENT '内容',
  `lock` int(5) DEFAULT NULL COMMENT '是否锁定，1-未锁定，0-已锁定',
  `lockReason` longtext COMMENT '锁定理由',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '作者（即用户）',
  PRIMARY KEY (`storyId`),
  KEY `story_anonymId` (`anonymId`),
  CONSTRAINT `story_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_story` */

/*Table structure for table `an_storycollection` */

DROP TABLE IF EXISTS `an_storycollection`;

CREATE TABLE `an_storycollection` (
  `storyCollectiionId` varchar(100) NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  `storyId` varchar(100) DEFAULT NULL COMMENT '故事id',
  PRIMARY KEY (`storyCollectiionId`),
  KEY `storycollection_storyId` (`storyId`),
  KEY `storycollection_anonymId` (`anonymId`),
  CONSTRAINT `storycollection_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storycollection_storyId` FOREIGN KEY (`storyId`) REFERENCES `an_story` (`storyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_storycollection` */

/*Table structure for table `an_storycomment` */

DROP TABLE IF EXISTS `an_storycomment`;

CREATE TABLE `an_storycomment` (
  `storyCommentId` varchar(100) NOT NULL COMMENT '主键',
  `storyCommentContent` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `styroReplyCommentId` varchar(100) DEFAULT NULL COMMENT '回复故事的id，不是回复的评论为null',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `delFlag` int(5) DEFAULT NULL COMMENT '删除标识，1-未删除，0-未删除',
  `storyId` varchar(100) DEFAULT NULL COMMENT '故事id',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`storyCommentId`),
  KEY `storycomment_anonymId` (`anonymId`),
  KEY `storycomment_storyId` (`storyId`),
  CONSTRAINT `storycomment_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storycomment_storyId` FOREIGN KEY (`storyId`) REFERENCES `an_story` (`storyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_storycomment` */

/*Table structure for table `an_storycommentfabulous` */

DROP TABLE IF EXISTS `an_storycommentfabulous`;

CREATE TABLE `an_storycommentfabulous` (
  `StoryCommentFabulousId` varchar(100) NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `storyCommentId` varchar(100) DEFAULT NULL COMMENT '评论id',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`StoryCommentFabulousId`),
  KEY `storycommentfabulous_anonymId` (`anonymId`),
  KEY `storycommentfabulous_storyCommentId` (`storyCommentId`),
  CONSTRAINT `storycommentfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storycommentfabulous_storyCommentId` FOREIGN KEY (`storyCommentId`) REFERENCES `an_storycomment` (`storyCommentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_storycommentfabulous` */

/*Table structure for table `an_storyfabulous` */

DROP TABLE IF EXISTS `an_storyfabulous`;

CREATE TABLE `an_storyfabulous` (
  `storyFabulousId` varchar(100) NOT NULL COMMENT '主键',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `storyId` varchar(100) DEFAULT NULL COMMENT '故事id',
  `anonymId` varchar(100) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`storyFabulousId`),
  KEY `storyfabulous_anonymId` (`anonymId`),
  KEY `storyfabulous_storyId` (`storyId`),
  CONSTRAINT `storyfabulous_anonymId` FOREIGN KEY (`anonymId`) REFERENCES `an_anonym` (`anonymId`),
  CONSTRAINT `storyfabulous_storyId` FOREIGN KEY (`storyId`) REFERENCES `an_story` (`storyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `an_storyfabulous` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
