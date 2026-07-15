/*
 Navicat Premium Dump SQL

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : rescue

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 25/05/2026 17:16:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accident
-- ----------------------------
DROP TABLE IF EXISTS `accident`;
CREATE TABLE `accident`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图片URL',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '事故名称',
  `accident_type_id` bigint NULL DEFAULT NULL COMMENT '事故类型ID',
  `accident_type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '事故类型名称（冗余）',
  `occur_time` datetime NULL DEFAULT NULL COMMENT '发生时间',
  `region` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '事故区域',
  `latitude` double NULL DEFAULT NULL COMMENT '纬度',
  `longitude` double NULL DEFAULT NULL COMMENT '经度',
  `casualty_count` int NULL DEFAULT 0 COMMENT '伤亡人数',
  `property_loss` decimal(15, 2) NULL DEFAULT NULL COMMENT '财产损失（元）',
  `cause` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发生原因',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '详细描述',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'OCCURRED' COMMENT '状态：OCCURRED/HANDLING/RESOLVED',
  `publisher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '事故信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accident
-- ----------------------------
INSERT INTO `accident` VALUES (3, '', '524大事件', 2, '洪水', '2026-05-24 13:38:00', '重庆工程学院', 29.4218, 106.5895, 0, 10000000000.00, '洪水', '', 'OCCURRED', '系统管理员', '2026-05-24 13:39:44', '2026-05-24 20:10:00');
INSERT INTO `accident` VALUES (4, '', '巴南区洪涝灾害', 2, '洪水', '2026-05-22 08:00:00', '重庆市巴南区李家沱', 29.4022, 106.5409, 12, 5000000.00, '持续暴雨导致河水漫堤', '巴南区李家沱街道因连日暴雨引发洪涝，多处低洼地带被淹，居民需要紧急转移', 'HANDLING', '系统管理员', '2026-05-22 08:30:00', '2026-05-24 20:10:00');
INSERT INTO `accident` VALUES (5, '', '南岸区山体滑坡', 4, '泥石流', '2026-05-21 14:00:00', '重庆市南岸区南山街道', 29.5231, 106.6271, 5, 8000000.00, '暴雨引发山体松动', '南山街道发生山体滑坡，道路中断，有居民被困', 'HANDLING', '应急管理员', '2026-05-21 14:30:00', '2026-05-24 20:10:00');
INSERT INTO `accident` VALUES (6, '', '渝北区居民楼火灾', 3, '火灾', '2026-05-20 22:00:00', '重庆市渝北区龙溪街道', 29.6156, 106.5501, 3, 2000000.00, '电路老化短路', '龙溪街道一栋老旧居民楼因电路老化引发火灾，三层以上有居民被困', 'RESOLVED', '系统管理员', '2026-05-20 22:15:00', '2026-05-24 20:10:00');
INSERT INTO `accident` VALUES (7, '', '沙坪坝区地震', 1, '地震', '2026-05-19 03:00:00', '重庆市沙坪坝区歌乐山', 29.56, 106.45, 8, 20000000.00, '地质活动', '歌乐山区域发生4.5级地震，部分老旧房屋出现裂缝，居民恐慌', 'HANDLING', '系统管理员', '2026-05-19 03:10:00', '2026-05-24 20:10:00');
INSERT INTO `accident` VALUES (8, '', '江津区台风受灾', 5, '台风', '2026-05-18 16:00:00', '重庆市江津区几江街道', 29.2903, 106.2597, 2, 3000000.00, '台风过境', '受台风影响，江津区多处树木倒塌，部分房屋受损', 'RESOLVED', '应急管理员', '2026-05-18 16:30:00', '2026-05-24 20:10:00');
INSERT INTO `accident` VALUES (9, '', '北碚区暴雨内涝', 2, '洪水', '2026-05-17 11:00:00', '重庆市北碚区天生街道', 29.8058, 106.4368, 6, 4000000.00, '短时强降雨', '北碚区遭遇短时强降雨，城区多处内涝，地下车库被淹', 'RESOLVED', '系统管理员', '2026-05-17 11:20:00', '2026-05-24 20:10:00');
INSERT INTO `accident` VALUES (10, '', '九龙坡区工厂火灾', 3, '火灾', '2026-05-23 09:00:00', '重庆市九龙坡区白市驿', 29.4513, 106.502, 1, 15000000.00, '化学品泄漏引发', '白市驿一化工厂发生火灾，伴有有毒气体扩散，周边居民需紧急疏散', 'OCCURRED', '系统管理员', '2026-05-23 09:10:00', '2026-05-24 20:10:00');

-- ----------------------------
-- Table structure for accident_type
-- ----------------------------
DROP TABLE IF EXISTS `accident_type`;
CREATE TABLE `accident_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '事故类型名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '事故类型编码',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '事故类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accident_type
-- ----------------------------
INSERT INTO `accident_type` VALUES (1, '地震', 'ACC001', '地震灾害', 1, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `accident_type` VALUES (2, '洪水', 'ACC002', '洪涝灾害', 2, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `accident_type` VALUES (3, '火灾', 'ACC003', '火灾事故', 3, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `accident_type` VALUES (4, '泥石流', 'ACC004', '泥石流灾害', 4, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `accident_type` VALUES (5, '台风', 'ACC005', '台风灾害', 5, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '公告内容',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告类型：NOTICE/EMERGENCY/SYSTEM',
  `priority` int NULL DEFAULT 0 COMMENT '优先级：0-普通 1-重要 2-紧急',
  `publisher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PUBLISHED' COMMENT '状态：DRAFT/PUBLISHED/ARCHIVED',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (1, '别怕有我在', '别担心', 'EMERGENCY', 1, '系统管理员', '2026-05-24 04:36:57', 'PUBLISHED', '2026-05-24 12:36:05', '2026-05-24 12:36:56');
INSERT INTO `announcement` VALUES (2, '关于启动防汛Ⅳ级应急响应的通知', '根据气象部门预报，未来48小时我市将迎来强降雨天气，市防汛抗旱指挥部决定自5月22日8时起启动防汛Ⅳ级应急响应。请各区县做好防范工作，确保人民群众生命财产安全。', 'EMERGENCY', 2, '应急管理员', '2026-05-22 08:00:00', 'PUBLISHED', '2026-05-22 07:30:00', '2026-05-24 20:10:00');
INSERT INTO `announcement` VALUES (3, '九龙坡区化工厂火灾疏散通知', '九龙坡区白市驿工业园区一化工厂发生火灾，伴有有毒气体扩散。请周边3公里内居民立即关好门窗、佩戴防护口罩，并按照社区指引有序疏散。疏散集合点：白市驿镇文化广场。', 'EMERGENCY', 2, '系统管理员', '2026-05-23 09:30:00', 'PUBLISHED', '2026-05-23 09:15:00', '2026-05-24 20:10:00');
INSERT INTO `announcement` VALUES (4, '救灾物资领取指南', '各位受灾居民：救灾物资已在以下地点发放：1.重庆工程学院救助站（南泉校区）；2.巴南区体育馆；3.沙坪坝区人民广场。请携带身份证件前往领取，每人限领一份。', 'NOTICE', 1, '系统管理员', '2026-05-23 14:00:00', 'PUBLISHED', '2026-05-23 13:30:00', '2026-05-24 20:10:00');
INSERT INTO `announcement` VALUES (5, '志愿者招募通知', '因灾情需要，现面向社会招募志愿者，要求：1.年龄18-55周岁；2.身体健康；3.有相关技能者优先。报名方式：在系统中申请成为救助员，或拨打热线023-12345678。', 'NOTICE', 1, '应急管理员', '2026-05-24 08:00:00', 'PUBLISHED', '2026-05-24 07:30:00', '2026-05-24 20:10:00');
INSERT INTO `announcement` VALUES (6, '系统升级维护通知', '为提升服务质量，系统将于5月25日凌晨2:00-4:00进行升级维护，届时系统将暂停服务。请提前做好相关安排，给您带来不便敬请谅解。', 'SYSTEM', 0, '系统管理员', '2026-05-24 18:00:00', 'PUBLISHED', '2026-05-24 17:00:00', '2026-05-24 20:10:00');
INSERT INTO `announcement` VALUES (7, '地震避险知识科普', '地震来临时：1.室内者应就近躲避到坚固家具下或墙角；2.室外者应远离建筑物、电线杆等；3.不要乘坐电梯；4.震后迅速撤离到开阔地带。更多知识请查看科普知识板块。', 'NOTICE', 0, '应急管理员', '2026-05-24 10:00:00', 'PUBLISHED', '2026-05-24 09:30:00', '2026-05-24 20:10:00');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门编码',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门ID',
  `leader` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '应急救援总指挥部', 'HQ001', 0, '总指挥', '13800138000', 1, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `department` VALUES (2, '消防大队', 'FD001', 1, '消防队长', '13800138002', 2, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `department` VALUES (3, '医疗救护队', 'MD001', 1, '医疗队长', '13800138003', 3, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `department` VALUES (4, '物资保障部', 'MT001', 1, '物资主管', '13800138004', 4, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');

-- ----------------------------
-- Table structure for dispatch_record
-- ----------------------------
DROP TABLE IF EXISTS `dispatch_record`;
CREATE TABLE `dispatch_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `help_request_id` bigint NOT NULL COMMENT '关联求助信息ID',
  `rescuer_id` bigint NOT NULL COMMENT '救助员用户ID',
  `rescuer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '救助员姓名（冗余）',
  `accident_id` bigint NULL DEFAULT NULL COMMENT '关联事故ID',
  `accident_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联事故名称（冗余）',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PENDING' COMMENT '状态：PENDING待出发/EN_ROUTE前往中/ARRIVED已到达/COMPLETED已完成/CANCELLED已取消',
  `dispatch_time` datetime NULL DEFAULT NULL COMMENT '派单时间',
  `arrive_time` datetime NULL DEFAULT NULL COMMENT '到达时间',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_help_request_id`(`help_request_id` ASC) USING BTREE,
  INDEX `idx_rescuer_id`(`rescuer_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '出警记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dispatch_record
-- ----------------------------
INSERT INTO `dispatch_record` VALUES (1, 12, 8, '李强', 5, '南岸区山体滑坡', 'COMPLETED', '2026-05-21 15:00:00', '2026-05-21 15:30:00', '2026-05-21 16:00:00', '成功救出被困群众4人', '2026-05-21 15:00:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (2, 13, 9, '赵勇', 6, '渝北区居民楼火灾', 'COMPLETED', '2026-05-20 22:30:00', '2026-05-20 22:45:00', '2026-05-20 23:00:00', '老人安全转移', '2026-05-20 22:30:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (3, 14, 10, '陈刚', 9, '北碚区暴雨内涝', 'COMPLETED', '2026-05-17 12:00:00', '2026-05-17 12:30:00', '2026-05-17 13:00:00', '车内8人全部救出', '2026-05-17 12:00:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (4, 15, 11, '孙丽', 8, '江津区台风受灾', 'COMPLETED', '2026-05-18 17:00:00', '2026-05-18 17:30:00', '2026-05-18 18:00:00', '孕妇及家人安全转移', '2026-05-18 17:00:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (5, 9, 8, '李强', 7, '沙坪坝区地震', 'EN_ROUTE', '2026-05-24 08:30:00', NULL, NULL, '正在前往歌乐山', '2026-05-24 08:30:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (6, 10, 9, '赵勇', 4, '巴南区洪涝灾害', 'EN_ROUTE', '2026-05-24 09:00:00', NULL, NULL, '等待出发', '2026-05-24 09:00:00', '2026-05-24 21:17:07');
INSERT INTO `dispatch_record` VALUES (7, 11, 12, '周明', 10, '九龙坡区工厂火灾', 'ARRIVED', '2026-05-24 09:30:00', '2026-05-24 09:50:00', NULL, '正在组织疏散', '2026-05-24 09:30:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (8, 16, 10, '陈刚', 7, '沙坪坝区地震', 'PENDING', '2026-05-24 08:45:00', NULL, NULL, '准备出发前往磁器口', '2026-05-24 08:45:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (9, 17, 11, '孙丽', 4, '巴南区洪涝灾害', 'PENDING', '2026-05-24 10:15:00', NULL, NULL, '', '2026-05-24 10:15:00', '2026-05-24 20:10:00');
INSERT INTO `dispatch_record` VALUES (10, 18, 12, '周明', 10, '九龙坡区工厂火灾', 'PENDING', '2026-05-24 10:45:00', NULL, NULL, '等待化工厂火势控制后转移', '2026-05-24 10:45:00', '2026-05-24 20:10:00');

-- ----------------------------
-- Table structure for donation
-- ----------------------------
DROP TABLE IF EXISTS `donation`;
CREATE TABLE `donation`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL COMMENT '捐赠用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '捐赠人姓名',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `material_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '捐赠物资名称',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '捐赠数量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '件' COMMENT '单位',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '物资描述',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PENDING' COMMENT '审核状态：PENDING待审核/APPROVED已通过/REJECTED已拒绝',
  `audit_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '物资捐赠表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of donation
-- ----------------------------
INSERT INTO `donation` VALUES (1, 3, '张银', '18523820765', '矿泉水', 500, '箱', '怡宝纯净水500ml*24瓶', 'APPROVED', '系统管理员', '2026-05-23 21:00:00', '物资完好', '2026-05-23 20:30:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (2, 4, '郑昌军', '15023461794', '方便面', 300, '箱', '康师傅红烧牛肉面', 'APPROVED', '系统管理员', '2026-05-23 21:00:00', '保质期内', '2026-05-23 20:35:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (3, 5, '苟一民', '15234679891', '急救包', 100, '个', '含绷带、消毒液、创可贴等', 'APPROVED', '应急管理员', '2026-05-24 08:00:00', '医疗物资优先审核', '2026-05-23 21:00:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (4, 6, '王磊', '13912345678', '帐篷', 50, '顶', '双人防雨帐篷', 'APPROVED', '系统管理员', '2026-05-24 08:30:00', '', '2026-05-24 08:00:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (5, 7, '刘芳', '13698765432', '棉被', 200, '床', '加厚冬季棉被', 'APPROVED', '应急管理员', '2026-05-24 09:00:00', '', '2026-05-24 08:30:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (6, 3, '张银', '18523820765', '手电筒', 150, '个', 'LED强光手电筒', 'PENDING', NULL, NULL, NULL, '2026-05-24 10:00:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (7, 4, '郑昌军', '15023461794', '雨衣', 200, '件', '加厚一次性雨衣', 'PENDING', NULL, NULL, NULL, '2026-05-24 10:30:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (8, 6, '王磊', '13912345678', '大米', 100, '袋', '东北大米10kg装', 'PENDING', NULL, NULL, NULL, '2026-05-24 11:00:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (9, 7, '刘芳', '13698765432', '消毒液', 80, '瓶', '84消毒液500ml', 'REJECTED', '系统管理员', '2026-05-24 12:00:00', '已过期，不符合安全标准', '2026-05-24 11:30:00', '2026-05-24 20:10:00');
INSERT INTO `donation` VALUES (10, 5, '苟一民', '15234679891', '发电机', 5, '台', '便携式柴油发电机5KW', 'PENDING', NULL, NULL, NULL, '2026-05-24 14:00:00', '2026-05-24 20:10:00');

-- ----------------------------
-- Table structure for emergency_plan
-- ----------------------------
DROP TABLE IF EXISTS `emergency_plan`;
CREATE TABLE `emergency_plan`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '方案标题',
  `accident_id` bigint NULL DEFAULT NULL COMMENT '关联事故ID',
  `accident_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联事故名称（冗余）',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `danger_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '危险性等级',
  `accident_feature` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '事故特征',
  `handling_keypoint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '处置要点',
  `precautions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '注意事项',
  `publisher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人姓名',
  `publisher_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人账号',
  `publisher_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人联系电话',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PUBLISHED' COMMENT '状态：DRAFT/PUBLISHED/ARCHIVED',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '应急处置方案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emergency_plan
-- ----------------------------
INSERT INTO `emergency_plan` VALUES (1, '地震应急避险指南', 7, '沙坪坝区地震', '2026-05-19 04:00:00', '高', '突发性强、破坏力大、余震频发', '1.立即就近避震，选择结实遮挡物下或开间小、有支撑物的房间\n2.远离窗户、镜子和外墙\n3.震后迅速撤离到安全开阔地带\n4.搜救被困人员时注意余震风险', '1.不要跳楼或乘坐电梯\n2.震后不要立即返回室内\n3.注意防范余震和次生灾害\n4.保持通讯畅通，等待救援', '系统管理员', 'admin', '13800138000', 'PUBLISHED', '2026-05-19 04:00:00', '2026-05-24 20:10:00');
INSERT INTO `emergency_plan` VALUES (2, '洪涝灾害自救互救指南', 4, '巴南区洪涝灾害', '2026-05-22 09:00:00', '高', '来势凶猛、淹没范围广、持续时间长', '1.迅速向高处转移，不要停留在低洼处\n2.如被困，利用门板、木盆等漂浮物自救\n3.等待救援时保持体力，发出求救信号\n4.注意饮用水安全，防止疫病传播', '1.不要涉水行走，水下可能有暗坑\n2.远离电线和电力设施\n3.不要食用被洪水浸泡的食物\n4.灾后注意消毒和防疫', '应急管理员', 'emergency', '13800138001', 'PUBLISHED', '2026-05-22 09:00:00', '2026-05-24 20:10:00');
INSERT INTO `emergency_plan` VALUES (3, '火灾逃生自救指南', 6, '渝北区居民楼火灾', '2026-05-20 23:00:00', '极高', '蔓延迅速、烟雾有毒、容易恐慌', '1.发现火灾立即报警并通知周围人员\n2.用湿毛巾捂住口鼻，低姿沿安全通道撤离\n3.不乘坐电梯，不贪恋财物\n4.被困时到窗口发出求救信号等待救援', '1.逃生时不要拥挤，防止踩踏\n2.高层不要盲目跳楼\n3.烟雾较大时应匍匐前进\n4.身上着火时就地打滚灭火', '系统管理员', 'admin', '13800138000', 'PUBLISHED', '2026-05-20 23:00:00', '2026-05-24 20:10:00');
INSERT INTO `emergency_plan` VALUES (4, '泥石流防灾避险指南', 5, '南岸区山体滑坡', '2026-05-21 15:00:00', '高', '突发性强、破坏力大、伴随泥沙石块', '1.发现泥石流征兆立即向两侧高地撤离\n2.不要顺着泥石流方向跑\n3.选择坚固的障碍物后躲避\n4.被困时寻找固定物防止被冲走', '1.暴雨后不要进入山谷和沟口\n2.注意观察山体是否有裂缝、落石\n3.听到异常声响立即撤离\n4.灾后不要立即返回，注意二次滑坡', '应急管理员', 'emergency', '13800138001', 'PUBLISHED', '2026-05-21 15:00:00', '2026-05-24 20:10:00');
INSERT INTO `emergency_plan` VALUES (5, '台风防范指南', 8, '江津区台风受灾', '2026-05-18 17:00:00', '中高', '风力强、降雨大、影响范围广', '1.台风来临前关紧门窗，收好室外物品\n2.储备食物、水和应急物资\n3.避免外出，远离广告牌和大树\n4.住在低洼处的居民提前转移', '1.不要在临时搭建物下避雨\n2.远离海岸和河边\n3.注意防范暴雨引发的内涝\n4.台风过后注意检查房屋安全', '系统管理员', 'admin', '13800138000', 'PUBLISHED', '2026-05-18 17:00:00', '2026-05-24 20:10:00');
INSERT INTO `emergency_plan` VALUES (6, '急救常识手册', NULL, NULL, '2026-05-23 10:00:00', '通用', '各类灾害中常见的伤害类型', '1.止血：用干净布料直接按压伤口\n2.骨折：用硬板固定伤肢，不要随意搬动\n3.烧伤：用流动冷水冲洗20分钟以上\n4.心肺复苏：按压频率100-120次/分钟', '1.急救前确保现场安全\n2.不要随意搬动重伤员\n3.保持伤员呼吸道通畅\n4.及时拨打120急救电话', '系统管理员', 'admin', '13800138000', 'PUBLISHED', '2026-05-23 10:00:00', '2026-05-24 20:10:00');

-- ----------------------------
-- Table structure for help_request
-- ----------------------------
DROP TABLE IF EXISTS `help_request`;
CREATE TABLE `help_request`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL COMMENT '求助用户ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `number` int NULL DEFAULT 1 COMMENT '被困人数',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '位置描述',
  `gps` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'GPS坐标',
  `latitude` double NULL DEFAULT NULL COMMENT '纬度',
  `longitude` double NULL DEFAULT NULL COMMENT '经度',
  `special` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '特殊情况',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '待救援' COMMENT '状态：待救援/已救援/已转移',
  `handler` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理人',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '求助信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of help_request
-- ----------------------------
INSERT INTO `help_request` VALUES (1, 3, '', '', 1, '', '29.425470444375634,106.59215831761004', 29.4255, 106.5922, '', '', '已救援', NULL, NULL, '2026-05-23 20:08:41');
INSERT INTO `help_request` VALUES (2, 3, '', '', 1, '', '未知位置', NULL, NULL, '', '', '已救援', NULL, NULL, '2026-05-23 20:23:38');
INSERT INTO `help_request` VALUES (3, 4, '郑昌军', '15023461794', 1, '重庆工程学院（南泉校区）', '未知位置', NULL, NULL, '小孩', '需要医疗物品', '已救援', NULL, NULL, '2026-05-23 20:30:12');
INSERT INTO `help_request` VALUES (4, 3, '张银', '', 1, '重庆工程学院', '未知位置', NULL, NULL, '', '需要食物', '已转移', NULL, NULL, '2026-05-24 11:22:58');
INSERT INTO `help_request` VALUES (5, 6, '王磊', '', 1, '', '29.421802,106.589545', 29.4218, 106.5895, '', '', '已救援', NULL, NULL, '2026-05-24 14:08:18');
INSERT INTO `help_request` VALUES (6, 3, '张银', '18523820765', 10086, '重庆工程学院', '29.421822,106.589514', 29.4218, 106.5895, '郑昌军', '速来', '已救援', NULL, NULL, '2026-05-24 16:05:23');
INSERT INTO `help_request` VALUES (7, 3, '', '', 1, '无', '未知位置', NULL, NULL, '', '', '待救援', NULL, NULL, '2026-05-24 16:15:37');
INSERT INTO `help_request` VALUES (8, 5, '苟一民', '15234679891', 1, '', '29.421824,106.589534', 29.4218, 106.5895, '老人', '', '待救援', NULL, NULL, '2026-05-24 19:48:51');
INSERT INTO `help_request` VALUES (9, 6, '王磊', '13912345678', 3, '沙坪坝区歌乐山街道12号', '29.5600,106.4500', 29.56, 106.45, '老人行动不便', '房屋出现裂缝，需要紧急转移', '待救援', NULL, NULL, '2026-05-19 03:20:00');
INSERT INTO `help_request` VALUES (10, 7, '刘芳', '13698765432', 5, '巴南区李家沱滨江路88号', '29.4022,106.5409', 29.4022, 106.5409, '有婴儿', '一楼已被水淹，困在二楼', '待救援', NULL, NULL, '2026-05-22 09:00:00');
INSERT INTO `help_request` VALUES (11, 3, '张银', '18523820765', 2, '九龙坡区白市驿工业园区', '29.4513,106.5020', 29.4513, 106.502, '呼吸道疾病', '附近化工厂着火，需要疏散', '待救援', NULL, NULL, '2026-05-23 09:30:00');
INSERT INTO `help_request` VALUES (12, 4, '郑昌军', '15023461794', 4, '南岸区南山街道半山腰', '29.5231,106.6271', 29.5231, 106.6271, '小孩', '道路被滑坡堵住，出不去', '已救援', '李强', '2026-05-21 16:00:00', '2026-05-21 14:45:00');
INSERT INTO `help_request` VALUES (13, 5, '苟一民', '15234679891', 1, '渝北区龙溪街道金龙路', '29.6156,106.5501', 29.6156, 106.5501, '老人', '三楼着火，被困阳台', '已救援', '赵勇', '2026-05-20 23:00:00', '2026-05-20 22:20:00');
INSERT INTO `help_request` VALUES (14, 6, '王磊', '13912345678', 8, '北碚区天生路地下车库', '29.8058,106.4368', 29.8058, 106.4368, '', '车库被淹，有人被困车内', '已转移', '陈刚', '2026-05-17 13:00:00', '2026-05-17 11:40:00');
INSERT INTO `help_request` VALUES (15, 7, '刘芳', '13698765432', 3, '江津区几江街道沿江路', '29.2903,106.2597', 29.2903, 106.2597, '孕妇', '房屋屋顶被台风掀翻', '已转移', '孙丽', '2026-05-18 18:00:00', '2026-05-18 16:45:00');
INSERT INTO `help_request` VALUES (16, 3, '张银', '18523820765', 6, '沙坪坝区磁器口古镇', '29.5800,106.4500', 29.58, 106.45, '有老人和小孩', '地震后古镇建筑倾斜，需要转移', '待救援', NULL, NULL, '2026-05-24 08:00:00');
INSERT INTO `help_request` VALUES (17, 4, '郑昌军', '15023461794', 2, '巴南区鱼洞街道', '29.3833,106.5200', 29.3833, 106.52, '', '洪水水位持续上涨', '待救援', NULL, NULL, '2026-05-24 10:00:00');
INSERT INTO `help_request` VALUES (18, 5, '苟一民', '15234679891', 1, '九龙坡区杨家坪步行街', '29.4833,106.5167', 29.4833, 106.5167, '心脏病', '附近有有毒气体，需要转移', '待救援', NULL, NULL, '2026-05-24 10:30:00');
INSERT INTO `help_request` VALUES (19, NULL, '王磊🫤', '15023461794', 1, '', '29.42178256212803,106.58961400778665', 29.42178256212803, 106.58961400778665, '随便', '', '待救援', NULL, NULL, '2026-05-24 20:34:31');
INSERT INTO `help_request` VALUES (20, NULL, '小苟', '15523420051', 10086, '', '29.421847,106.589533', 29.421847, 106.589533, '', '', '待救援', NULL, NULL, '2026-05-24 21:52:34');

-- ----------------------------
-- Table structure for material_category
-- ----------------------------
DROP TABLE IF EXISTS `material_category`;
CREATE TABLE `material_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类编码',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父分类ID',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '物资分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material_category
-- ----------------------------
INSERT INTO `material_category` VALUES (1, '食品类', 'MC001', 0, '食品类物资', 1, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `material_category` VALUES (2, '饮水类', 'MC002', 0, '饮水类物资', 2, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `material_category` VALUES (3, '医疗类', 'MC003', 0, '医疗类物资', 3, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `material_category` VALUES (4, '工具类', 'MC004', 0, '救援工具类', 4, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `material_category` VALUES (5, '帐篷类', 'MC005', 0, '帐篷类物资', 5, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');

-- ----------------------------
-- Table structure for message_board
-- ----------------------------
DROP TABLE IF EXISTS `message_board`;
CREATE TABLE `message_board`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL COMMENT '留言用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '留言人姓名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言内容',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父留言ID（0表示顶级留言）',
  `reply_user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '回复目标用户名',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'VISIBLE' COMMENT '状态：VISIBLE可见/HIDDEN隐藏',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message_board
-- ----------------------------
INSERT INTO `message_board` VALUES (1, 3, '张银', '请问巴南区李家沱的救援队到了吗？我家人还在那边！', 0, NULL, 'VISIBLE', '2026-05-22 09:30:00');
INSERT INTO `message_board` VALUES (2, 8, '李强', '巴南区救援队已出发，预计30分钟到达，请保持电话畅通！', 1, '张银', 'VISIBLE', '2026-05-22 09:35:00');
INSERT INTO `message_board` VALUES (3, 7, '刘芳', '沙坪坝区现在安全吗？想回去拿东西', 0, NULL, 'VISIBLE', '2026-05-19 08:00:00');
INSERT INTO `message_board` VALUES (4, 10, '陈刚', '沙坪坝区目前还在排查中，暂时不要返回，请等待官方通知', 3, '刘芳', 'VISIBLE', '2026-05-19 08:10:00');
INSERT INTO `message_board` VALUES (5, 4, '郑昌军', '请问哪里可以领到救灾物资？', 0, NULL, 'VISIBLE', '2026-05-23 10:00:00');
INSERT INTO `message_board` VALUES (6, 12, '周明', '重庆工程学院救助站可以领取，地址在南泉校区', 5, '郑昌军', 'VISIBLE', '2026-05-23 10:05:00');
INSERT INTO `message_board` VALUES (7, 6, '王磊', '我想捐赠一批物资，请问流程是什么？', 0, NULL, 'VISIBLE', '2026-05-24 07:30:00');
INSERT INTO `message_board` VALUES (8, 1, '系统管理员', '请在用户端\"物资捐赠\"页面提交捐赠申请，审核通过后会有工作人员联系您', 7, '王磊', 'VISIBLE', '2026-05-24 07:35:00');
INSERT INTO `message_board` VALUES (9, 5, '苟一民', '感谢救援人员的辛苦付出！你们是最可爱的人！', 0, NULL, 'VISIBLE', '2026-05-24 12:00:00');
INSERT INTO `message_board` VALUES (10, 3, '张银', '化工厂那边有毒气吗？需要戴口罩吗？', 0, NULL, 'VISIBLE', '2026-05-24 10:00:00');
INSERT INTO `message_board` VALUES (11, 9, '赵勇', '已确认有有害气体扩散，请周边居民佩戴N95口罩，关好门窗，等待疏散通知', 10, '张银', 'VISIBLE', '2026-05-24 10:05:00');
INSERT INTO `message_board` VALUES (12, 7, '刘芳', '北碚区的水退了吗？什么时候可以回家？', 0, NULL, 'VISIBLE', '2026-05-24 14:00:00');
INSERT INTO `message_board` VALUES (13, 4, '郑昌军', '大家注意安全，不要轻信谣言，以官方发布为准', 0, NULL, 'VISIBLE', '2026-05-24 15:00:00');
INSERT INTO `message_board` VALUES (14, 6, '王磊', '建议增加夜间巡逻，防止有人趁灾盗窃', 0, NULL, 'HIDDEN', '2026-05-24 16:00:00');

-- ----------------------------
-- Table structure for rescuer_application
-- ----------------------------
DROP TABLE IF EXISTS `rescuer_application`;
CREATE TABLE `rescuer_application`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '申请人用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `id_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证号',
  `specialty` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '专业特长（如消防、医疗等）',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '申请理由',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PENDING' COMMENT '审核状态：PENDING待审核/APPROVED已通过/REJECTED已拒绝',
  `audit_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '救助员申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rescuer_application
-- ----------------------------
INSERT INTO `rescuer_application` VALUES (1, 8, 'rescuer01', '15800001111', '李强', '500100199001011234', '消防救援', '退伍消防兵，有5年消防救援经验', 'APPROVED', '系统管理员', '2026-05-23 20:00:00', '资质合格', '2026-05-23 19:45:00', '2026-05-24 20:10:00');
INSERT INTO `rescuer_application` VALUES (2, 9, 'rescuer02', '15800002222', '赵勇', '500100199202022345', '水域救援', '持有水域救援证书，多次参与抗洪', 'APPROVED', '系统管理员', '2026-05-23 20:00:00', '资质合格', '2026-05-23 19:46:00', '2026-05-24 20:10:00');
INSERT INTO `rescuer_application` VALUES (3, 10, 'rescuer03', '15800003333', '陈刚', '500100199303033456', '医疗急救', '执业医师，擅长急诊外科', 'APPROVED', '系统管理员', '2026-05-23 20:00:00', '医疗资质齐全', '2026-05-23 19:47:00', '2026-05-24 20:10:00');
INSERT INTO `rescuer_application` VALUES (4, 11, 'rescuer04', '15800004444', '孙丽', '500100199404044567', '心理疏导', '心理咨询师，擅长灾后心理干预', 'APPROVED', '系统管理员', '2026-05-23 20:00:00', '资质合格', '2026-05-23 19:48:00', '2026-05-24 20:10:00');
INSERT INTO `rescuer_application` VALUES (5, 12, 'rescuer05', '15800005555', '周明', '500100199505055678', '物资管理', '物流管理专业，擅长应急物资调配', 'APPROVED', '系统管理员', '2026-05-23 20:00:00', '资质合格', '2026-05-23 19:49:00', '2026-05-24 20:10:00');
INSERT INTO `rescuer_application` VALUES (6, 3, 'zhangyin', '18523820765', '张银', '500100199606066789', '通讯保障', '通信工程专业，能搭建应急通讯', 'PENDING', NULL, NULL, NULL, '2026-05-24 09:00:00', '2026-05-24 20:10:00');
INSERT INTO `rescuer_application` VALUES (7, 7, 'liufang', '13698765432', '刘芳', '500100199707077890', '后勤保障', '有厨师证，可为救援队提供餐饮保障', 'PENDING', NULL, NULL, NULL, '2026-05-24 11:00:00', '2026-05-24 20:10:00');

-- ----------------------------
-- Table structure for sensor_data
-- ----------------------------
DROP TABLE IF EXISTS `sensor_data`;
CREATE TABLE `sensor_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sensor_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '传感器编号',
  `vibration` double NULL DEFAULT NULL COMMENT '震动值(gal)',
  `light` double NULL DEFAULT NULL COMMENT '光照值(lux)',
  `danger_level` int NULL DEFAULT NULL COMMENT '危险等级 1/2/3',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '危险描述',
  `latitude` double NULL DEFAULT NULL COMMENT '纬度',
  `longitude` double NULL DEFAULT NULL COMMENT '经度',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 168 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '传感器数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensor_data
-- ----------------------------
INSERT INTO `sensor_data` VALUES (1, 'SENSOR-001', 37.92446041252021, 237.37295057701903, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-23 20:17:33');
INSERT INTO `sensor_data` VALUES (2, 'SENSOR-001', 48.56026991725051, 346.83559335140893, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-23 20:17:43');
INSERT INTO `sensor_data` VALUES (3, 'SENSOR-001', 30.94818566888007, 32.97450643554383, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-23 20:17:53');
INSERT INTO `sensor_data` VALUES (4, 'SENSOR-001', 0.4214948300304777, 128.4731871849929, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:20:16');
INSERT INTO `sensor_data` VALUES (5, 'SENSOR-001', 14.792183024538751, 546.0325659023988, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:20:26');
INSERT INTO `sensor_data` VALUES (6, 'SENSOR-001', 41.45608821456599, 593.454677299875, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 11:20:36');
INSERT INTO `sensor_data` VALUES (7, 'SENSOR-001', 33.94162963847296, 466.27954859387137, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:20:46');
INSERT INTO `sensor_data` VALUES (8, 'SENSOR-001', 22.124112268227847, 237.80006098414844, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:20:56');
INSERT INTO `sensor_data` VALUES (9, 'SENSOR-001', 1.5832847955307927, 206.92721898040213, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:21:06');
INSERT INTO `sensor_data` VALUES (10, 'SENSOR-001', 11.45709406081491, 591.7864765834977, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:21:16');
INSERT INTO `sensor_data` VALUES (11, 'SENSOR-001', 45.43627012658891, 348.39674247798285, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 11:21:26');
INSERT INTO `sensor_data` VALUES (12, 'SENSOR-001', 37.21008157661351, 292.969704181208, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:21:36');
INSERT INTO `sensor_data` VALUES (13, 'SENSOR-001', 18.583825897595503, 262.26119783657407, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:21:46');
INSERT INTO `sensor_data` VALUES (14, 'SENSOR-001', 27.726308936569886, 206.6651149394221, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:21:56');
INSERT INTO `sensor_data` VALUES (15, 'SENSOR-001', 5.585113019566023, 79.10209019773218, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:26:34');
INSERT INTO `sensor_data` VALUES (16, 'SENSOR-001', 22.86021281795528, 313.1238568538302, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:26:44');
INSERT INTO `sensor_data` VALUES (17, 'SENSOR-001', 14.211581468515588, 593.4833184957429, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:26:54');
INSERT INTO `sensor_data` VALUES (18, 'SENSOR-001', 18.105911679668196, 297.72726554844064, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:27:04');
INSERT INTO `sensor_data` VALUES (19, 'SENSOR-001', 39.8293787694678, 108.63422901396878, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:27:14');
INSERT INTO `sensor_data` VALUES (20, 'SENSOR-001', 43.71691482085404, 437.5685902070834, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 11:27:24');
INSERT INTO `sensor_data` VALUES (21, 'SENSOR-001', 26.810961499274427, 191.8365514410069, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:27:34');
INSERT INTO `sensor_data` VALUES (22, 'SENSOR-001', 45.11521007816811, 225.81502259448342, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 11:27:44');
INSERT INTO `sensor_data` VALUES (23, 'SENSOR-001', 16.570626628832922, 528.8574337499737, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:27:54');
INSERT INTO `sensor_data` VALUES (24, 'SENSOR-001', 10.074475568278807, 192.19261413242074, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:28:04');
INSERT INTO `sensor_data` VALUES (25, 'SENSOR-001', 0.7604741128183712, 70.0332138743207, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:28:14');
INSERT INTO `sensor_data` VALUES (26, 'SENSOR-001', 34.141717497146196, 207.94007207971487, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:28:24');
INSERT INTO `sensor_data` VALUES (27, 'SENSOR-001', 2.452397229421316, 362.3879533239871, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:28:34');
INSERT INTO `sensor_data` VALUES (28, 'SENSOR-001', 40.00748011229545, 131.34279947589195, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 11:28:44');
INSERT INTO `sensor_data` VALUES (29, 'SENSOR-001', 23.54555456707994, 220.76497936084098, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:28:54');
INSERT INTO `sensor_data` VALUES (30, 'SENSOR-001', 2.3941169259026007, 123.1201459601903, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:29:04');
INSERT INTO `sensor_data` VALUES (31, 'SENSOR-001', 30.405996074082857, 423.22734176526933, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:29:14');
INSERT INTO `sensor_data` VALUES (32, 'SENSOR-001', 25.747017118305703, 216.47368085859094, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:29:24');
INSERT INTO `sensor_data` VALUES (33, 'SENSOR-001', 14.616945412715365, 253.62568206835007, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:39:24');
INSERT INTO `sensor_data` VALUES (34, 'SENSOR-001', 19.86698665060266, 32.831670963023996, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:39:34');
INSERT INTO `sensor_data` VALUES (35, 'SENSOR-001', 49.226642809261875, 317.719704568916, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 11:51:34');
INSERT INTO `sensor_data` VALUES (36, 'SENSOR-001', 8.327944976057456, 41.941433247462825, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:51:44');
INSERT INTO `sensor_data` VALUES (37, 'SENSOR-001', 18.234088414220896, 57.97586404054582, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 11:51:53');
INSERT INTO `sensor_data` VALUES (38, 'SENSOR-001', 45.37723739897897, 399.9127340396162, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 11:59:43');
INSERT INTO `sensor_data` VALUES (39, 'SENSOR-001', 28.222738636191814, 420.04999176593725, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 11:59:53');
INSERT INTO `sensor_data` VALUES (40, 'SENSOR-001', 8.856967887721845, 29.840434409004814, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 12:08:20');
INSERT INTO `sensor_data` VALUES (41, 'SENSOR-001', 40.15317580644952, 270.953462104972, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 12:10:15');
INSERT INTO `sensor_data` VALUES (42, 'SENSOR-001', 16.7003149996124, 391.06625339586907, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421854, 106.589538, '2026-05-24 12:10:25');
INSERT INTO `sensor_data` VALUES (43, 'SENSOR-001', 49.8234486757901, 129.84064973344573, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 12:10:27');
INSERT INTO `sensor_data` VALUES (44, 'SENSOR-001', 0.9213335940618184, 524.5562915510766, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 12:18:37');
INSERT INTO `sensor_data` VALUES (45, 'SENSOR-001', 0.3708473085152819, 418.63907036838043, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421791, 106.589519, '2026-05-24 12:18:47');
INSERT INTO `sensor_data` VALUES (46, 'SENSOR-001', 28.495962233772588, 250.92904206596066, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421791, 106.589519, '2026-05-24 12:18:57');
INSERT INTO `sensor_data` VALUES (47, 'SENSOR-001', 24.28280428626647, 404.6216535971013, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421791, 106.589519, '2026-05-24 12:19:07');
INSERT INTO `sensor_data` VALUES (48, 'SENSOR-001', 31.159176292573214, 463.25626109226494, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421791, 106.589519, '2026-05-24 12:19:17');
INSERT INTO `sensor_data` VALUES (49, 'SENSOR-001', 33.91415457124499, 174.8371936229507, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421791, 106.589519, '2026-05-24 12:19:27');
INSERT INTO `sensor_data` VALUES (50, 'SENSOR-001', 30.72986291784716, 529.7078998197879, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421791, 106.589519, '2026-05-24 12:19:37');
INSERT INTO `sensor_data` VALUES (51, 'SENSOR-001', 0.2162247502681458, 559.5688142773256, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421791, 106.589519, '2026-05-24 12:19:47');
INSERT INTO `sensor_data` VALUES (52, 'SENSOR-001', 34.95280363873679, 134.57582438340853, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421791, 106.589519, '2026-05-24 12:19:57');
INSERT INTO `sensor_data` VALUES (53, 'SENSOR-001', 38.80683959420749, 297.9215028075226, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421791, 106.589519, '2026-05-24 12:20:58');
INSERT INTO `sensor_data` VALUES (54, 'SENSOR-001', 4.118816105880551, 155.27967148263585, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421791, 106.589519, '2026-05-24 12:21:59');
INSERT INTO `sensor_data` VALUES (55, 'SENSOR-001', 7.280543122109978, 300.90343264703677, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421791, 106.589519, '2026-05-24 12:23:00');
INSERT INTO `sensor_data` VALUES (56, 'SENSOR-001', 49.11376457479091, 226.85745541030659, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421791, 106.589519, '2026-05-24 12:24:01');
INSERT INTO `sensor_data` VALUES (57, 'SENSOR-001', 7.10451740589515, 48.325196918136506, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 12:36:39');
INSERT INTO `sensor_data` VALUES (58, 'SENSOR-001', 34.77130928975693, 326.91813859806587, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 12:36:41');
INSERT INTO `sensor_data` VALUES (59, 'SENSOR-001', 2.4663758897048913, 576.0979017434671, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:36:51');
INSERT INTO `sensor_data` VALUES (60, 'SENSOR-001', 3.27283092012956, 86.41396215782125, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:37:01');
INSERT INTO `sensor_data` VALUES (61, 'SENSOR-001', 23.50973664449711, 484.94993962659566, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:37:11');
INSERT INTO `sensor_data` VALUES (62, 'SENSOR-001', 24.250869700118205, 420.13886016947794, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:37:21');
INSERT INTO `sensor_data` VALUES (63, 'SENSOR-001', 34.716495844598306, 226.64389972738124, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:37:31');
INSERT INTO `sensor_data` VALUES (64, 'SENSOR-001', 13.875070727059413, 376.491489011601, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:37:41');
INSERT INTO `sensor_data` VALUES (65, 'SENSOR-001', 1.2811117143322226, 258.7717854243022, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:37:51');
INSERT INTO `sensor_data` VALUES (66, 'SENSOR-001', 22.154790757612385, 65.75195874430145, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:38:01');
INSERT INTO `sensor_data` VALUES (67, 'SENSOR-001', 31.35262015037593, 459.3138812426235, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:38:11');
INSERT INTO `sensor_data` VALUES (68, 'SENSOR-001', 23.238522315370158, 293.11800824631223, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:38:21');
INSERT INTO `sensor_data` VALUES (69, 'SENSOR-001', 14.975167980376675, 81.78535048340032, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:38:31');
INSERT INTO `sensor_data` VALUES (70, 'SENSOR-001', 49.723902737542375, 16.144598991636073, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421824, 106.589517, '2026-05-24 12:38:41');
INSERT INTO `sensor_data` VALUES (71, 'SENSOR-001', 45.3643742998752, 326.4053390995636, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421824, 106.589517, '2026-05-24 12:38:51');
INSERT INTO `sensor_data` VALUES (72, 'SENSOR-001', 20.233005391507408, 426.9986883695794, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:39:01');
INSERT INTO `sensor_data` VALUES (73, 'SENSOR-001', 35.227372634583716, 127.3445751953929, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:39:11');
INSERT INTO `sensor_data` VALUES (74, 'SENSOR-001', 3.2444749628256444, 493.51286562575933, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:39:21');
INSERT INTO `sensor_data` VALUES (75, 'SENSOR-001', 12.960973389277436, 472.63372057845817, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:39:31');
INSERT INTO `sensor_data` VALUES (76, 'SENSOR-001', 40.65520977199981, 186.35303994207254, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421824, 106.589517, '2026-05-24 12:39:41');
INSERT INTO `sensor_data` VALUES (77, 'SENSOR-001', 46.65301706339918, 316.1822430008211, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421824, 106.589517, '2026-05-24 12:39:51');
INSERT INTO `sensor_data` VALUES (78, 'SENSOR-001', 18.513048974623906, 279.58021296262876, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:40:01');
INSERT INTO `sensor_data` VALUES (79, 'SENSOR-001', 5.099780569119449, 173.41412137982897, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:40:11');
INSERT INTO `sensor_data` VALUES (80, 'SENSOR-001', 8.38878436646881, 522.4036032099162, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:40:21');
INSERT INTO `sensor_data` VALUES (81, 'SENSOR-001', 18.358973644375315, 450.66935512833425, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:40:31');
INSERT INTO `sensor_data` VALUES (82, 'SENSOR-001', 46.41492627732328, 528.1960344010025, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421824, 106.589517, '2026-05-24 12:40:41');
INSERT INTO `sensor_data` VALUES (83, 'SENSOR-001', 6.538350449419067, 103.8226549725124, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:40:51');
INSERT INTO `sensor_data` VALUES (84, 'SENSOR-001', 15.37335076172311, 49.77246293090414, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:41:01');
INSERT INTO `sensor_data` VALUES (85, 'SENSOR-001', 30.39218634529354, 563.1237384554576, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:41:11');
INSERT INTO `sensor_data` VALUES (86, 'SENSOR-001', 28.40213167260591, 491.0574452963239, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:41:21');
INSERT INTO `sensor_data` VALUES (87, 'SENSOR-001', 2.864916954839558, 136.83900087225265, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:41:31');
INSERT INTO `sensor_data` VALUES (88, 'SENSOR-001', 32.104263095858734, 41.08990869745561, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421824, 106.589517, '2026-05-24 12:41:41');
INSERT INTO `sensor_data` VALUES (89, 'SENSOR-001', 17.211013608279668, 330.6223703150162, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:41:51');
INSERT INTO `sensor_data` VALUES (90, 'SENSOR-001', 17.125243339682893, 187.13410534015867, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:42:01');
INSERT INTO `sensor_data` VALUES (91, 'SENSOR-001', 2.417040338918841, 208.60040934404833, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421824, 106.589517, '2026-05-24 12:42:11');
INSERT INTO `sensor_data` VALUES (92, 'SENSOR-001', 9.71567865617844, 570.8996491049515, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421806, 106.589538, '2026-05-24 12:42:21');
INSERT INTO `sensor_data` VALUES (93, 'SENSOR-001', 48.38675385316362, 283.08023128761965, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421806, 106.589538, '2026-05-24 12:42:31');
INSERT INTO `sensor_data` VALUES (94, 'SENSOR-001', 10.38790182987635, 313.32169406466716, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421806, 106.589538, '2026-05-24 12:42:41');
INSERT INTO `sensor_data` VALUES (95, 'SENSOR-001', 18.14396335733312, 166.9546093164901, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421806, 106.589538, '2026-05-24 12:42:51');
INSERT INTO `sensor_data` VALUES (96, 'SENSOR-001', 40.77417131318645, 312.8054432264602, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421806, 106.589538, '2026-05-24 12:43:01');
INSERT INTO `sensor_data` VALUES (97, 'SENSOR-001', 7.939180663660639, 475.57464145811934, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421806, 106.589538, '2026-05-24 12:43:11');
INSERT INTO `sensor_data` VALUES (98, 'SENSOR-001', 3.568195925249551, 303.379036261625, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421806, 106.589538, '2026-05-24 12:43:21');
INSERT INTO `sensor_data` VALUES (99, 'SENSOR-001', 2.7535475132580034, 165.1446665967413, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421806, 106.589538, '2026-05-24 12:43:31');
INSERT INTO `sensor_data` VALUES (100, 'SENSOR-001', 38.59255644413209, 206.91002783834008, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421806, 106.589538, '2026-05-24 12:43:41');
INSERT INTO `sensor_data` VALUES (101, 'SENSOR-001', 8.274714452047233, 107.67169293837948, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421806, 106.589538, '2026-05-24 12:43:51');
INSERT INTO `sensor_data` VALUES (102, 'SENSOR-001', 20.083024387571697, 154.2416126257871, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.421806, 106.589538, '2026-05-24 12:44:01');
INSERT INTO `sensor_data` VALUES (103, 'SENSOR-001', 28.60362665335342, 139.90388228611636, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 15:59:29');
INSERT INTO `sensor_data` VALUES (104, 'SENSOR-001', 22.352724399928526, 31.801995987457676, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 15:59:49');
INSERT INTO `sensor_data` VALUES (105, 'SENSOR-001', 41.36609035842398, 571.6855859943784, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 15:59:53');
INSERT INTO `sensor_data` VALUES (106, 'SENSOR-001', 5.155335980887344, 54.72751742747288, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 15:59:56');
INSERT INTO `sensor_data` VALUES (107, 'SENSOR-001', 35.77277509679574, 535.3598781448168, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 15:59:58');
INSERT INTO `sensor_data` VALUES (108, 'SENSOR-001', 47.77283706246884, 35.269545896177505, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 16:01:33');
INSERT INTO `sensor_data` VALUES (109, 'SENSOR-001', 22.137952626013924, 219.79201654355796, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 16:04:45');
INSERT INTO `sensor_data` VALUES (110, 'SENSOR-001', 13.548814818567651, 225.278885363853, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 16:12:02');
INSERT INTO `sensor_data` VALUES (111, 'SENSOR-001', 18.64760802646886, 318.68954094691475, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 16:12:12');
INSERT INTO `sensor_data` VALUES (112, 'SENSOR-001', 6.2203967669279265, 29.97947757225703, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 16:13:07');
INSERT INTO `sensor_data` VALUES (113, 'SENSOR-001', 13.524802545412873, 77.84081048287017, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.426118, 106.593415, '2026-05-24 16:13:17');
INSERT INTO `sensor_data` VALUES (114, 'SENSOR-001', 20.591742112378743, 424.001668958384, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.426118, 106.593415, '2026-05-24 16:13:27');
INSERT INTO `sensor_data` VALUES (115, 'SENSOR-001', 38.2360763443043, 353.7776385986531, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.426118, 106.593415, '2026-05-24 16:13:37');
INSERT INTO `sensor_data` VALUES (116, 'SENSOR-001', 25.123291220056, 319.0891470178927, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.426118, 106.593415, '2026-05-24 16:13:47');
INSERT INTO `sensor_data` VALUES (117, 'SENSOR-001', 20.91439598157059, 293.30768233548923, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.426118, 106.593415, '2026-05-24 16:13:57');
INSERT INTO `sensor_data` VALUES (118, 'SENSOR-001', 4.5532763326232075, 381.3813532136531, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.426118, 106.593415, '2026-05-24 16:14:32');
INSERT INTO `sensor_data` VALUES (119, 'SENSOR-001', 23.134373212441794, 257.760338073651, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', 29.426118, 106.593415, '2026-05-24 16:14:37');
INSERT INTO `sensor_data` VALUES (120, 'SENSOR-001', 11.975807707686497, 478.80295086473313, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 16:22:29');
INSERT INTO `sensor_data` VALUES (121, 'SENSOR-001', 33.42958878163172, 535.2900706600402, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 16:22:47');
INSERT INTO `sensor_data` VALUES (122, 'SENSOR-001', 1.1130410008158842, 534.0516334550298, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', 29.421825, 106.589538, '2026-05-24 16:22:57');
INSERT INTO `sensor_data` VALUES (123, 'SENSOR-001', 43.90573517031255, 344.39124368388974, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', 29.421825, 106.589538, '2026-05-24 16:23:07');
INSERT INTO `sensor_data` VALUES (124, 'SENSOR-001', 42.06300315160498, 540.5208783778208, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 16:23:08');
INSERT INTO `sensor_data` VALUES (125, 'SENSOR-001', 30.877938724455834, 554.222164999184, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 16:23:10');
INSERT INTO `sensor_data` VALUES (126, 'SENSOR-001', 34.30542404344469, 36.611598362571065, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 17:05:56');
INSERT INTO `sensor_data` VALUES (127, 'SENSOR-001', 18.656489955653115, 568.1008652681961, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 17:06:06');
INSERT INTO `sensor_data` VALUES (128, 'SENSOR-001', 49.95255617135857, 243.04783776704048, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 19:56:16');
INSERT INTO `sensor_data` VALUES (129, 'SENSOR-001', 16.953854036192844, 106.12187995767097, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 20:32:36');
INSERT INTO `sensor_data` VALUES (130, 'SENSOR-001', 3.194356739969323, 515.8533597081257, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 20:53:28');
INSERT INTO `sensor_data` VALUES (131, 'SENSOR-001', 20.920080647830687, 142.68137329545183, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:02:15');
INSERT INTO `sensor_data` VALUES (132, 'SENSOR-001', 49.89180155659002, 130.7747567884188, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:17:55');
INSERT INTO `sensor_data` VALUES (133, 'SENSOR-001', 41.38855997794549, 250.01875568124, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:18:05');
INSERT INTO `sensor_data` VALUES (134, 'SENSOR-001', 25.955600981318806, 144.92746543588638, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:18:15');
INSERT INTO `sensor_data` VALUES (135, 'SENSOR-001', 19.490855070230488, 113.45797287188692, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:18:25');
INSERT INTO `sensor_data` VALUES (136, 'SENSOR-001', 9.348419227051712, 11.531146066441877, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:18:35');
INSERT INTO `sensor_data` VALUES (137, 'SENSOR-001', 43.96835440207268, 534.4352966036242, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:18:45');
INSERT INTO `sensor_data` VALUES (138, 'SENSOR-001', 23.639407662268695, 544.2228883248612, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:18:55');
INSERT INTO `sensor_data` VALUES (139, 'SENSOR-001', 34.79579172824321, 224.89957973707035, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:19:05');
INSERT INTO `sensor_data` VALUES (140, 'SENSOR-001', 44.165754689494705, 315.1338267030611, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:19:42');
INSERT INTO `sensor_data` VALUES (141, 'SENSOR-001', 20.209956243012922, 399.20055587976634, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:20:42');
INSERT INTO `sensor_data` VALUES (142, 'SENSOR-001', 36.14915880023473, 20.645793025163496, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:21:42');
INSERT INTO `sensor_data` VALUES (143, 'SENSOR-001', 0.5402964334320359, 148.46929609625008, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:22:42');
INSERT INTO `sensor_data` VALUES (144, 'SENSOR-001', 9.301877446417672, 182.25190860048244, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:23:42');
INSERT INTO `sensor_data` VALUES (145, 'SENSOR-001', 37.59886405635234, 338.09610223620723, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:24:42');
INSERT INTO `sensor_data` VALUES (146, 'SENSOR-001', 32.82341940347876, 105.45337778288764, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:25:42');
INSERT INTO `sensor_data` VALUES (147, 'SENSOR-001', 30.619276133536598, 102.74195259273317, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:26:42');
INSERT INTO `sensor_data` VALUES (148, 'SENSOR-001', 36.45564945655643, 448.8073239244751, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:27:42');
INSERT INTO `sensor_data` VALUES (149, 'SENSOR-001', 44.212859298950235, 22.704386492297157, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:28:42');
INSERT INTO `sensor_data` VALUES (150, 'SENSOR-001', 31.233814081859794, 462.79501855120435, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:29:42');
INSERT INTO `sensor_data` VALUES (151, 'SENSOR-001', 47.671924125086356, 92.94491450824584, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:30:42');
INSERT INTO `sensor_data` VALUES (152, 'SENSOR-001', 49.0939745883704, 157.82093693519676, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:31:42');
INSERT INTO `sensor_data` VALUES (153, 'SENSOR-001', 25.454480814537934, 83.98875374735513, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:32:42');
INSERT INTO `sensor_data` VALUES (154, 'SENSOR-001', 9.242669093203087, 448.03667320388433, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:33:42');
INSERT INTO `sensor_data` VALUES (155, 'SENSOR-001', 33.043511056667576, 512.8286933866902, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:34:42');
INSERT INTO `sensor_data` VALUES (156, 'SENSOR-001', 3.950037989946109, 96.98123249926549, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:35:42');
INSERT INTO `sensor_data` VALUES (157, 'SENSOR-001', 15.929874331601285, 326.56252041282085, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:36:42');
INSERT INTO `sensor_data` VALUES (158, 'SENSOR-001', 18.99664242754576, 567.813140988649, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:37:42');
INSERT INTO `sensor_data` VALUES (159, 'SENSOR-001', 38.275124527047076, 296.5372545307484, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:38:42');
INSERT INTO `sensor_data` VALUES (160, 'SENSOR-001', 44.56419556748236, 541.0119642906965, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:39:42');
INSERT INTO `sensor_data` VALUES (161, 'SENSOR-001', 6.6176243852266055, 33.08456796026207, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:40:42');
INSERT INTO `sensor_data` VALUES (162, 'SENSOR-001', 25.57524845592789, 109.94751211828704, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:41:43');
INSERT INTO `sensor_data` VALUES (163, 'SENSOR-001', 49.382402394084835, 379.835017077611, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:42:42');
INSERT INTO `sensor_data` VALUES (164, 'SENSOR-001', 14.314752283684983, 582.2928490113593, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:43:42');
INSERT INTO `sensor_data` VALUES (165, 'SENSOR-001', 8.272275966164393, 206.89255290459306, 1, '✅ 低危险，当前环境相对安全，请保持警惕。', NULL, NULL, '2026-05-24 21:44:42');
INSERT INTO `sensor_data` VALUES (166, 'SENSOR-001', 45.51372889213356, 294.29260254384724, 3, '⚠️ 高危险！强烈震动+光线极弱，可能存在坍塌/被困风险，请立即撤离或求助！', NULL, NULL, '2026-05-24 21:45:42');
INSERT INTO `sensor_data` VALUES (167, 'SENSOR-001', 26.82200739538656, 573.5722304761816, 2, '⚠️ 中危险！有明显震动，建议尽快撤离到安全区域，必要时点击求助。', NULL, NULL, '2026-05-24 21:46:43');

-- ----------------------------
-- Table structure for shelter
-- ----------------------------
DROP TABLE IF EXISTS `shelter`;
CREATE TABLE `shelter`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '物资名称',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '存放位置',
  `latitude` decimal(10, 6) NULL DEFAULT NULL COMMENT '纬度',
  `longitude` decimal(10, 6) NULL DEFAULT NULL COMMENT '经度',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'AVAILABLE' COMMENT '状态：AVAILABLE/UNAVAILABLE/OUT_OF_STOCK',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '救灾物资表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shelter
-- ----------------------------
INSERT INTO `shelter` VALUES (1, '重庆工程学院', '重庆工程学院', 38.898980, 27.334560, '正常', '2026-05-24 11:53:09', '2026-05-24 21:59:07');
INSERT INTO `shelter` VALUES (2, '重庆市渝中区救灾物资储备中心', '重庆市渝中区大坪正街160号', 29.543700, 106.521300, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (3, '重庆市南岸区应急避难场所', '重庆市南岸区南坪南路12号', 29.523400, 106.561200, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (4, '重庆市沙坪坝区救助站', '重庆市沙坪坝区三峡广场28号', 29.541200, 106.457800, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (5, '重庆市江北区应急救援中心', '重庆市江北区观音桥步行街56号', 29.580100, 106.574300, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (6, '重庆市九龙坡区救灾安置点', '重庆市九龙坡区杨家坪正街22号', 29.502300, 106.510800, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (7, '重庆市大渡口区应急物资站', '重庆市大渡口区春晖路88号', 29.483500, 106.482600, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (8, '重庆市渝北区临时安置中心', '重庆市渝北区两路街道义学路2号', 29.718200, 106.631300, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (9, '重庆市巴南区救灾物资中转站', '重庆市巴南区鱼洞街道鱼轻路33号', 29.402100, 106.540500, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (10, '重庆市北碚区应急避难中心', '重庆市北碚区天生路79号', 29.825300, 106.436800, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (11, '重庆市万州区救灾储备库', '重庆市万州区高笋塘广场1号', 30.807800, 108.408800, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (12, '重庆市涪陵区应急救助站', '重庆市涪陵区兴华中路45号', 29.703000, 107.394400, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (13, '重庆市合川区救灾物资站', '重庆市合川区苏家街18号', 29.972700, 106.276100, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (14, '重庆市永川区应急救援中心', '重庆市永川区中山路166号', 29.356000, 105.927000, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (15, '重庆市江津区临时安置点', '重庆市江津区几江街道大同路55号', 29.290300, 106.259300, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');
INSERT INTO `shelter` VALUES (16, '重庆市长寿区救灾物资储备点', '重庆市长寿区凤城街道长寿路12号', 29.857600, 107.081600, '正常', '2026-05-24 22:03:34', '2026-05-24 22:03:34');

-- ----------------------------
-- Table structure for shelter_material
-- ----------------------------
DROP TABLE IF EXISTS `shelter_material`;
CREATE TABLE `shelter_material`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `shelter_id` bigint NOT NULL COMMENT '救助站ID',
  `category_id` bigint NULL DEFAULT NULL COMMENT '物资分类ID',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物资分类名称',
  `quantity` int NULL DEFAULT 0 COMMENT '库存数量',
  `specification` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格型号',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shelter_id`(`shelter_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '救助物资表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shelter_material
-- ----------------------------
INSERT INTO `shelter_material` VALUES (1, 1, 5, '帐篷类', 1000, '6666', 1000.00, '2026-05-24 15:21:06', '2026-05-24 15:21:06');
INSERT INTO `shelter_material` VALUES (2, 1, 1, '食品类', 2000, '方便面/面包/饼干', 15.00, '2026-05-23 20:00:00', '2026-05-24 20:10:00');
INSERT INTO `shelter_material` VALUES (3, 1, 2, '饮水类', 5000, '矿泉水500ml', 2.00, '2026-05-23 20:00:00', '2026-05-24 20:10:00');
INSERT INTO `shelter_material` VALUES (4, 1, 3, '医疗类', 500, '急救包/药品/绷带', 50.00, '2026-05-23 20:00:00', '2026-05-24 20:10:00');
INSERT INTO `shelter_material` VALUES (5, 1, 4, '工具类', 200, '手电筒/绳索/铁锹', 30.00, '2026-05-23 20:00:00', '2026-05-24 20:10:00');
INSERT INTO `shelter_material` VALUES (6, 2, 1, '食品类', 100, '小面包', 2.00, '2026-05-25 11:17:13', '2026-05-25 11:17:13');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码（加密）',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USER' COMMENT '角色：ADMIN/EMERGENCY_MANAGER/USER',
  `department_id` bigint NULL DEFAULT NULL COMMENT '所属部门ID',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE/DISABLED',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '0192023a7bbd73250516f069df18b500', '系统管理员', '13800138000', NULL, 'ADMIN', NULL, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `user` VALUES (2, 'emergency', '7a23d075e5d8a1664382f9c23a141e43', '应急管理员', '13800138001', NULL, 'EMERGENCY_MANAGER', NULL, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `user` VALUES (3, 'zhangyin', 'e10adc3949ba59abbe56e057f20f883e', '张银', '18523820765', 'zhangyin@example.com', 'USER', NULL, 'ACTIVE', '2026-05-23 20:00:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (4, 'zhengchangjun', 'e10adc3949ba59abbe56e057f20f883e', '郑昌军', '15023461794', 'zhengcj@example.com', 'USER', NULL, 'ACTIVE', '2026-05-23 20:00:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (5, 'gouyimin', 'e10adc3949ba59abbe56e057f20f883e', '苟一民', '15234679891', 'gouym@example.com', 'USER', NULL, 'ACTIVE', '2026-05-23 20:00:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (6, 'wanglei', 'e10adc3949ba59abbe56e057f20f883e', '王磊', '13912345678', 'wanglei@example.com', 'USER', NULL, 'ACTIVE', '2026-05-24 10:00:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (7, 'liufang', 'e10adc3949ba59abbe56e057f20f883e', '刘芳', '13698765432', 'liufang@example.com', 'USER', NULL, 'ACTIVE', '2026-05-24 10:00:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (8, 'rescuer01', 'e10adc3949ba59abbe56e057f20f883e', '李强', '15800001111', 'liqiang@example.com', 'RESCUER', 2, 'ACTIVE', '2026-05-23 19:30:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (9, 'rescuer02', 'e10adc3949ba59abbe56e057f20f883e', '赵勇', '15800002222', 'zhaoyong@example.com', 'RESCUER', 2, 'ACTIVE', '2026-05-23 19:30:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (10, 'rescuer03', 'e10adc3949ba59abbe56e057f20f883e', '陈刚', '15800003333', 'chengang@example.com', 'RESCUER', 3, 'ACTIVE', '2026-05-23 19:30:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (11, 'rescuer04', 'e10adc3949ba59abbe56e057f20f883e', '孙丽', '15800004444', 'sunli@example.com', 'RESCUER', 3, 'ACTIVE', '2026-05-23 19:30:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (12, 'rescuer05', 'e10adc3949ba59abbe56e057f20f883e', '周明', '15800005555', 'zhouming@example.com', 'RESCUER', 4, 'ACTIVE', '2026-05-23 19:30:00', '2026-05-24 20:10:00');
INSERT INTO `user` VALUES (13, 'zhaozeyu', 'e10adc3949ba59abbe56e057f20f883e', '赵泽宇', '15234897644', NULL, 'USER', NULL, 'ACTIVE', '2026-05-25 10:46:02', '2026-05-25 10:46:02');

SET FOREIGN_KEY_CHECKS = 1;
