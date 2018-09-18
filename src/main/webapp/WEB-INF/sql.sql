CREATE DATABASE forum DEFAULT CHARSET utf8;
USE forum;

CREATE TABLE `board` (
  `id` INT(11) NOT NULL auto_increment COMMENT '论坛版块ID',
  `name` VARCHAR(150) NOT NULL DEFAULT '' COMMENT '论坛版块名',
  `desc` VARCHAR(255) DEFAULT NULL COMMENT '论坛版块描述',
  `topic_num` INT(11) NOT NULL DEFAULT '0' COMMENT '帖子数目',
  PRIMARY KEY  (`id`),
  KEY `idx_board_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

INSERT INTO `board` VALUES (1,'SpringMVC','Spring 框架提供了构建 Web 应用程序的全功能 MVC 模块\r\n',8);
INSERT INTO `board` VALUES (2,'\r\nSpring Boot','简化新Spring应用的初始搭建以及开发过程，让我们一起来深入这个领域吧',0);
INSERT INTO `board` VALUES (3,'Spring 事务管理','本板块将讨论 Spring 庞杂而强大的事务功能,包括编程式事务和声明式事务 ',0);
INSERT INTO `board` VALUES (4,' IOC和AOP ','IOC和AOP讨论板块',3);
INSERT INTO `board` VALUES (7,'dddddddddddd','ddddddddddddddddddddddddddddddd',0);
INSERT INTO `board` VALUES (8,'SpringMVC','SpringMVC经验~~',0);

CREATE TABLE `user` (
  `id` INT(11) NOT NULL auto_increment COMMENT '用户Id',
  `username` VARCHAR(30) NOT NULL COMMENT '用户名',
  `password` VARCHAR(30) NOT NULL default '' COMMENT '密码',
  `type` tinyINT(4) NOT NULL default '1' COMMENT '1:普通用户 2:管理员',
  `locked` tinyINT(4) NOT NULL default '0' COMMENT '0:未锁定 1:锁定',
  `credit` INT(11) default NULL COMMENT '积分',
  `last_visit` datetime default NULL COMMENT '最后登陆时间',
  `last_ip` VARCHAR(20) default NULL COMMENT '最后登陆IP',
  PRIMARY KEY  (`id`),
  KEY `idx_user_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `user` VALUES (1,'tom','1234',2,0,203,NULL,NULL);
INSERT INTO `user` VALUES (2,'john','1234',2,1,10,NULL,NULL);
INSERT INTO `user` VALUES (3,'ggg','123123',1,0,110,NULL,NULL);

CREATE TABLE `board_manager` (
  `board_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY  (`board_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛管理员';


INSERT INTO `board_manager` VALUES (1,1);
INSERT INTO `board_manager` VALUES (1,2);
INSERT INTO `board_manager` VALUES (5,2);
INSERT INTO `board_manager` VALUES (5,3);

CREATE TABLE `login_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) default NULL,
  `ip` VARCHAR(30) NOT NULL default '',
  `login_time` VARCHAR(30) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `post` (
  `id` INT(11) NOT NULL auto_increment COMMENT '帖子ID',
  `board_id` INT(11) NOT NULL default '0' COMMENT '论坛ID',
  `topic_id` INT(11) NOT NULL default '0' COMMENT '话题ID',
  `user_id` INT(11) NOT NULL default '0' COMMENT '发表者ID',
  `type` tinyINT(4) NOT NULL default '2' COMMENT '帖子类型 1:主帖子 2:回复帖子',
  `title` VARCHAR(50) NOT NULL COMMENT '帖子标题',
  `text` text NOT NULL COMMENT '帖子内容',
  `create_time` date NOT NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`),
  KEY `idx_postopic_id` (`topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='帖子';

INSERT INTO `post` VALUES (1,1,1,1,1,'SpringMVC','Spring Web MVC是一种基于Java的实现了Web MVC设计模式的请求驱动类型的轻量级Web框架\r\n','2016-03-07');
INSERT INTO `post` VALUES (2,1,2,1,1,'配置\r\详解','谁能告诉我SpringMVC的详细配置呢','2016-03-07');
INSERT INTO `post` VALUES (3,1,3,1,1,'test3','http://localhost/forum/boardManage.do?method=addTopicPage&boardId=1','2016-03-16');
INSERT INTO `post` VALUES (4,1,4,1,1,'test5','http://localhost/forum/boardManage.do?method=addTopicPage&boardId=1','2016-03-16');
INSERT INTO `post` VALUES (5,4,5,1,1,'AOP背后的故事','AOP背后的故事\r\n','2016-04-16');
INSERT INTO `post` VALUES (6,0,5,1,2,'铁杵磨成针','铁杵磨成针............\r\n','2016-04-16');
INSERT INTO `post` VALUES (7,4,6,1,1,'IOC的原理一','IOC的原理深入讲解\r\n','2016-04-16');
INSERT INTO `post` VALUES (8,4,7,1,1,'IOC的原理二','IOC的原理深入讲解','2016-04-16');
INSERT INTO `post` VALUES (14,5,14,1,1,'d','dddddddddddddd','2016-04-12');
INSERT INTO `post` VALUES (15,5,15,1,1,'dad','sdfffffffffffffffffff','2016-04-12');
INSERT INTO `post` VALUES (20,1,20,1,1,'测试。。。。','测试。。。。','2016-04-17');
INSERT INTO `post` VALUES (21,1,21,1,1,'测试。。。。','测试。。。。','2016-04-17');
INSERT INTO `post` VALUES (22,1,22,1,1,'SpringMVC集成','SpringMVC集成！！','2016-04-18');
INSERT INTO `post` VALUES (23,1,23,1,1,'SpringMVC集成','SpringMVC集成！！','2016-04-18');
INSERT INTO `post` VALUES (24,1,1,1,2,'SpringMVC集成','SpringMVC集成！！','2016-04-18');

CREATE TABLE `topic` (
  `id` INT(11) NOT NULL auto_increment COMMENT '帖子ID',
  `board_id` INT(11) NOT NULL COMMENT '所属论坛',
  `title` VARCHAR(100) NOT NULL default '' COMMENT '帖子标题',
  `user_id` INT(11) NOT NULL default '0' COMMENT '发表用户',
  `create_time` date NOT NULL COMMENT '发表时间',
  `last_post` date NOT NULL COMMENT '最后回复时间',
  `view_num` INT(11) NOT NULL default '1' COMMENT '浏览数',
  `reply_num` INT(11) NOT NULL default '0' COMMENT '回复数',
  `digest` INT(11) NOT NULL COMMENT '0:不是精华话题 1:是精华话题',
  PRIMARY KEY  (`id`),
  KEY `idx_topic_user_id` (`user_id`),
  KEY `idx_topic_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='话题';

INSERT INTO `topic` VALUES (1,1,'test',1,'2016-03-07','2016-04-18',0,1,1);
INSERT INTO `topic` VALUES (2,1,'test2',1,'2016-03-07','2016-03-07',0,0,1);
INSERT INTO `topic` VALUES (3,1,'test3',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `topic` VALUES (4,1,'test5',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `topic` VALUES (5,4,'AOP背后的故事',1,'2016-03-16','2016-03-16',0,1,1);
INSERT INTO `topic` VALUES (6,4,'IOC的原理一',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `topic` VALUES (7,4,'IOC的原理二',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `topic` VALUES (14,5,'d',1,'2016-04-12','2016-04-12',0,0,0);
INSERT INTO `topic` VALUES (15,5,'dad',1,'2016-04-12','2016-04-12',0,0,0);
INSERT INTO `topic` VALUES (20,1,'测试。。。。',1,'2016-04-17','2016-04-17',0,0,0);
INSERT INTO `topic` VALUES (21,1,'测试。。。。',1,'2016-04-17','2016-04-17',0,0,0);
INSERT INTO `topic` VALUES (22,1,'SpringMVC集成',1,'2016-04-18','2016-04-18',0,0,0);
INSERT INTO `topic` VALUES (23,1,'SpringMVC集成',1,'2016-04-18','2016-04-18',0,0,0);



