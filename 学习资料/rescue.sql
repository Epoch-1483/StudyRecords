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

 Date: 24/05/2026 15:36:42
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
  `casualty_count` int NULL DEFAULT 0 COMMENT '伤亡人数',
  `property_loss` decimal(15, 2) NULL DEFAULT NULL COMMENT '财产损失（元）',
  `cause` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发生原因',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '详细描述',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'OCCURRED' COMMENT '状态：OCCURRED/HANDLING/RESOLVED',
  `publisher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '事故信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accident
-- ----------------------------
INSERT INTO `accident` VALUES (3, '', '524大事件', 2, '洪水', '2026-05-24 13:38:00', '重庆工程学院', 0, 10000000000.00, '洪水', '', 'OCCURRED', '系统管理员', '2026-05-24 13:39:44', '2026-05-24 13:53:28');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (1, '别怕有我在', '别担心', 'EMERGENCY', 1, '系统管理员', '2026-05-24 04:36:57', 'PUBLISHED', '2026-05-24 12:36:05', '2026-05-24 12:36:56');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '应急处置方案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emergency_plan
-- ----------------------------

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
  `special` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '特殊情况',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '待救援' COMMENT '状态：待救援/已救援/已转移',
  `handler` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理人',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '求助信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of help_request
-- ----------------------------
INSERT INTO `help_request` VALUES (1, NULL, '', '', 1, '', '29.425470444375634,106.59215831761004', '', '', '已救援', NULL, NULL, '2026-05-23 20:08:41');
INSERT INTO `help_request` VALUES (2, NULL, '', '', 1, '', '未知位置', '', '', '已救援', NULL, NULL, '2026-05-23 20:23:38');
INSERT INTO `help_request` VALUES (3, NULL, '郑昌军', '15023461794', 1, '重庆工程学院（南泉校区）', '未知位置', '小孩', '需要医疗物品', '已救援', NULL, NULL, '2026-05-23 20:30:12');
INSERT INTO `help_request` VALUES (4, NULL, '张银', '', 1, '重庆工程学院', '未知位置', '', '需要食物', '已转移', NULL, NULL, '2026-05-24 11:22:58');
INSERT INTO `help_request` VALUES (5, NULL, '王磊', '', 1, '', '29.421802,106.589545', '', '', '待救援', NULL, NULL, '2026-05-24 14:08:18');

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
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '传感器数据表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '救灾物资表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shelter
-- ----------------------------
INSERT INTO `shelter` VALUES (1, '重庆工程学院', '重庆工程学院', NULL, NULL, '正常', '2026-05-24 11:53:09', '2026-05-24 15:11:51');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '救助物资表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shelter_material
-- ----------------------------
INSERT INTO `shelter_material` VALUES (1, 1, 5, '帐篷类', 1000, '6666', 1000.00, '2026-05-24 15:21:06', '2026-05-24 15:21:06');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '0192023a7bbd73250516f069df18b500', '系统管理员', '13800138000', NULL, 'ADMIN', NULL, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');
INSERT INTO `user` VALUES (2, 'emergency', '7a23d075e5d8a1664382f9c23a141e43', '应急管理员', '13800138001', NULL, 'EMERGENCY_MANAGER', NULL, 'ACTIVE', '2026-05-23 19:23:45', '2026-05-23 19:23:45');

SET FOREIGN_KEY_CHECKS = 1;
