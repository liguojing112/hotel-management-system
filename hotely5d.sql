/*
 Navicat Premium Data Transfer

 Source Server         : mysql57_3306
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : hotely5d

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 29/12/2024 23:17:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '1', '张峰', 1);
INSERT INTO `admin` VALUES (2, 'wz', '1', '王芝', 2);

-- ----------------------------
-- Table structure for operator
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '经营者' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for appointment
-- ----------------------------
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `member_id` int(11) NULL DEFAULT NULL COMMENT '用户',
  `room_id` int(11) NULL DEFAULT NULL COMMENT '房间',
  `start_time` date NULL DEFAULT NULL COMMENT '入住时间',
  `days` int(11) NULL DEFAULT NULL COMMENT '居住天数',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `money` decimal(10, 2) NULL DEFAULT NULL COMMENT '已付金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '预订' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of appointment
-- ----------------------------
INSERT INTO `appointment` VALUES (19, 4, 1, '2024-11-09', 1, 2, NULL, 300.00);
INSERT INTO `appointment` VALUES (20, 3, 1, '2024-11-10', 2, 3, '抱歉，此房间已满请重新预订其它房间', 300.00);
INSERT INTO `appointment` VALUES (21, 3, 1, '2024-11-10', 1, 2, NULL, 300.00);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间类型',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间图片',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `live_num` int(11) NULL DEFAULT NULL COMMENT '可住人数',
  `bed_num` int(11) NULL DEFAULT NULL COMMENT '床位数',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '面积',
  `introduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '介绍',
  `lat` double NULL DEFAULT NULL COMMENT '纬度',
  `lng` double NULL DEFAULT NULL COMMENT '经度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '房型' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (2, '豪华单人房', '1.jpg', 300.00, 1, 1, '30', '豪华单人房');
INSERT INTO `category` VALUES (3, '经济双人房', '2.jpg', 350.00, 1, 2, '20', '经济双人房');
INSERT INTO `category` VALUES (4, '总统套房', '3.jpg', 600.00, 2, 2, '20', '总统套房');
INSERT INTO `category` VALUES (5, '经济单人房', '4.jpg', 120.00, 1, 1, '30', '经济单人房');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `idcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `head` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime NULL DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (3, 'fxr', '1', '方晓冉', 2, '18112345678', '430223197809127890', 'b11.jpg', '2024-10-20 17:25:08');
INSERT INTO `member` VALUES (4, 'zxf', '1', '周先锋', 1, '17612345678', '430223197809121234', 'b15.jpg', '2024-10-20 17:26:09');
INSERT INTO `member` VALUES (5, 'qy', '1', '贺青阳', 1, '18175131235', '43566709875676', 'u/j/w/1735485197229366954.png', '2024-12-29 23:12:21');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `member_id` int(11) NULL DEFAULT NULL COMMENT '用户',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言',
  `reply` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复',
  `create_time` datetime NULL DEFAULT NULL COMMENT '留言时间',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '回复时间',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '留言' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 3, '很好的住宿体验！', '谢谢光临！', '2024-10-23 09:52:07', '2023-10-23 10:10:11', 2);
INSERT INTO `message` VALUES (2, 4, '性价比很高', '欢迎下次光临！', '2024-10-21 09:56:15', '2023-10-23 09:56:20', 2);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '公告内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, ' 公司本次股东大会的召集和召开程序符合《公司法》、《证券法》等相关法律、行政法规、《股东大会规则》和《公司章程》的规定；出席本次股东大会的人员和召集人的资格合法有效；本次股东大会的表决程序和表决结果合法有效。\n特此公告。', '2024-10-23 09:06:41', '2024 年第二次临时股东大会决议公告');
INSERT INTO `notice` VALUES (3, ' 时尚之旅酒店管理有限公司（以下简称“时尚之旅”或“标的股权”）为上海锦江国际酒店股份有限公司（以下简称“公司”）全资子公司，拥有 21 家酒店物业。公司所持时尚之旅 100%股权的评估价值为人民币 165,498.89 万元，公司将以不低于经国资备案的评估价值作为挂牌底价，最终交易价格根据公开挂牌结果确定。\n\n根据国有资产管理的有关规定，在正式挂牌转让前，公司将在上海联合产权交易所进行预挂牌。\n\n本次股权转让事项不构成《上市公司重大资产重组管理办法》规定的重大资产重组。', '2024-10-27 10:59:14', '关于挂牌转让时尚之旅酒店管理有限公司 100%股权的公告');
INSERT INTO `notice` VALUES (4, '一、 本公司董事会、监事会及董事、监事、高级管理人员保证半年度报告内容的真实性、准确性、完整\n    性，不存在虚假记载、误导性陈述或重大遗漏，并承担个别和连带的法律责任。\n\n二、 本公司第十届董事会第十八次会议于 2023 年 8 月 28 日审议通过了本半年度报告。公司全体董事\n    出席董事会会议。\n三、 本半年度报告未经审计。本公司按中国企业会计准则编制 2023 年半年度财务报表，经德勤华永会\n    计师事务所（特殊普通合伙）审阅，并出具了德师报(阅)字(23)第 R00044 号标准无保留意见的审\n    阅报告。\n四、 公司负责人董事长张晓强先生、首席执行官沈莉女士、主管会计工作负责人首席财务官艾耕云及\n    会计机构负责人吴琳女士声明：保证半年度报告中财务报告的真实、准确、完整。', '2024-10-27 14:24:14', '2024 年半年度报告');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `member_id` int(11) NULL DEFAULT NULL COMMENT '用户',
  `room_id` int(11) NULL DEFAULT NULL COMMENT '房间',
  `start_time` datetime NULL DEFAULT NULL COMMENT '入住时间',
  `days` int(11) NULL DEFAULT NULL COMMENT '居住天数',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态(1-已预订 2-已入住 3-已退房)',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `money` decimal(10, 2) NULL DEFAULT NULL COMMENT '实付金额',
  `check_out_time` datetime NULL DEFAULT NULL COMMENT '退房时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '入住' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (8, 3, 1, '2024-11-10 00:00:00', 1, 3, NULL, 300.00, NULL);

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `room_num` int(11) NULL DEFAULT NULL COMMENT '房间号',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '房型',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客房' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, 101, 2, 1);
INSERT INTO `room` VALUES (2, 102, 3, 1);
INSERT INTO `room` VALUES (3, 103, 4, 1);
INSERT INTO `room` VALUES (4, 201, 3, 1);
INSERT INTO `room` VALUES (5, 202, 4, 1);
INSERT INTO `room` VALUES (6, 203, 5, 1);

-- ----------------------------
-- Table structure for scenic_spot
-- ----------------------------
DROP TABLE IF EXISTS `scenic_spot`;
CREATE TABLE `scenic_spot`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `city_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '景区名称',
  `lat` double NULL DEFAULT NULL COMMENT '纬度',
  `lng` double NULL DEFAULT NULL COMMENT '经度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '景区坐标配置' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of scenic_spot
-- ----------------------------
INSERT INTO `scenic_spot` VALUES (1, '漓江', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (2, '象鼻山', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (3, '阳朔西街', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (4, '龙脊梯田', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (5, '两江四湖', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (6, '银子岩', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (7, '兴坪古镇', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (8, '遇龙河', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (9, '十里画廊', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (10, '世外桃源', NULL, NULL);
INSERT INTO `scenic_spot` VALUES (11, '靖江王府', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
