/*
 Navicat Premium Dump SQL

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : db_ssmfive

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 10/06/2026 15:21:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lab_safety_check_item
-- ----------------------------
DROP TABLE IF EXISTS `lab_safety_check_item`;
CREATE TABLE `lab_safety_check_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `main_id` int NOT NULL COMMENT '所属检查主表ID',
  `big_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大类别',
  `small_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小类别',
  `check_standard` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '检查标准',
  `check_result` tinyint NULL DEFAULT NULL COMMENT '检查结果 1-合格 0-不合格',
  `item_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '项目备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_main_id`(`main_id` ASC) USING BTREE,
  CONSTRAINT `lab_safety_check_item_ibfk_1` FOREIGN KEY (`main_id`) REFERENCES `lab_safety_check_main` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '实验室安全检查明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lab_safety_check_item
-- ----------------------------
INSERT INTO `lab_safety_check_item` VALUES (1, 1, '消防安全', '灭火器', '灭火器数量充足、压力正常、未过期', 1, '全部合格', '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (2, 1, '消防安全', '消防通道', '消防通道畅通无阻，标识清晰', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (3, 1, '消防安全', '烟感报警器', '烟感报警器工作正常，指示灯闪烁', 0, '2楼走廊烟感器故障，已报修', '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (4, 1, '用电安全', '电源线路', '电源线路无老化、裸露、私拉乱接现象', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (5, 1, '用电安全', '插座开关', '插座开关完好，无过载使用', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (6, 1, '环境卫生', '实验台面', '实验台面整洁，无杂物堆放', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (7, 2, '化学品管理', '危化品存放', '危化品分类存放，标签清晰，MSDS齐全', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (8, 2, '化学品管理', '废液处理', '废液分类收集，容器密封，标识清楚', 0, '部分废液标签脱落，需重新贴标', '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (9, 2, '个人防护', '防护设备', '实验人员正确佩戴防护眼镜、手套等', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (10, 2, '环境卫生', '通风设施', '通风橱运行正常，排风效果良好', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (11, 3, '用电安全', '配电箱', '配电箱标识清晰，门锁完好，周围无堆放物', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (12, 3, '消防安全', '灭火器', '灭火器数量充足、压力正常、未过期', 1, NULL, '2026-06-09 14:54:04');
INSERT INTO `lab_safety_check_item` VALUES (13, 4, '消防安全', '灭火器', '灭火器数量充足、压力正常、未过期', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (14, 4, '消防安全', '消防通道', '消防通道畅通无阻，标识清晰', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (15, 4, '消防安全', '烟感报警器', '烟感报警器工作正常，指示灯闪烁', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (16, 4, '用电安全', '电源线路', '电源线路无老化、裸露、私拉乱接现象', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (17, 4, '用电安全', '插座开关', '插座开关完好，无过载使用', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (18, 4, '用电安全', '配电箱', '配电箱标识清晰，门锁完好，周围无堆放物', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (19, 4, '化学品管理', '危化品存放', '危化品分类存放，标签清晰，MSDS齐全', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (20, 4, '化学品管理', '废液处理', '废液分类收集，容器密封，标识清楚', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (21, 4, '环境卫生', '实验台面', '实验台面整洁，无杂物堆放', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (22, 4, '环境卫生', '通风设施', '通风橱运行正常，排风效果良好', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (23, 4, '个人防护', '防护设备', '实验人员正确佩戴防护眼镜、手套等', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (24, 4, '个人防护', '应急设备', '洗眼器、喷淋装置功能正常', 1, '', '2026-06-09 16:01:54');
INSERT INTO `lab_safety_check_item` VALUES (25, 5, '111', '222', '1', 1, '', '2026-06-09 16:20:49');

-- ----------------------------
-- Table structure for lab_safety_check_main
-- ----------------------------
DROP TABLE IF EXISTS `lab_safety_check_main`;
CREATE TABLE `lab_safety_check_main`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `dept_id` int NOT NULL COMMENT '部门ID',
  `check_date` date NOT NULL COMMENT '检查日期',
  `checker_id` int NULL DEFAULT NULL COMMENT '检查人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1-已提交 0-草稿',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_check_date`(`check_date` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE,
  INDEX `checker_id`(`checker_id` ASC) USING BTREE,
  CONSTRAINT `lab_safety_check_main_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `t_department` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `lab_safety_check_main_ibfk_2` FOREIGN KEY (`checker_id`) REFERENCES `student` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '实验室安全检查主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lab_safety_check_main
-- ----------------------------
INSERT INTO `lab_safety_check_main` VALUES (1, 1, '2026-05-15', 2, '2026-06-09 14:54:04', '2026-06-09 14:54:04', '本月例行安全检查', 1);
INSERT INTO `lab_safety_check_main` VALUES (2, 2, '2026-05-20', 3, '2026-06-09 14:54:04', '2026-06-09 14:54:04', '化学实验室专项检查', 1);
INSERT INTO `lab_safety_check_main` VALUES (3, 3, '2026-06-01', 2, '2026-06-09 14:54:04', '2026-06-09 14:54:04', '物理实验室日常巡查', 0);
INSERT INTO `lab_safety_check_main` VALUES (4, 1, '2026-06-09', 1, '2026-06-09 16:01:54', '2026-06-09 16:01:54', '', 1);
INSERT INTO `lab_safety_check_main` VALUES (5, 6, '2026-06-02', 1, '2026-06-09 16:20:49', '2026-06-09 16:20:49', '', 1);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `userpwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `sex` tinyint NULL DEFAULT NULL COMMENT '性别 1-男 0-女',
  `tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1-启用 0-禁用',
  `dept_id` int NULL DEFAULT NULL COMMENT '所属部门ID',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '普通用户' COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `dept_id`(`dept_id` ASC) USING BTREE,
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `t_department` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户/学生表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 'admin', '123456', 1, '13800138000', '1990-01-01', '系统管理员', '2026-06-09 14:54:04', '2026-06-09 14:54:04', 1, NULL, '管理员');
INSERT INTO `student` VALUES (2, 'zhangsafe', '123456', 1, '13700137001', '1995-03-20', '张安全', '2026-06-09 14:54:04', '2026-06-09 14:54:04', 1, 1, '安全员');
INSERT INTO `student` VALUES (3, 'licheck', '123456', 0, '13700137002', '1996-07-10', '李检查', '2026-06-09 14:54:04', '2026-06-09 14:54:04', 1, 2, '安全员');
INSERT INTO `student` VALUES (4, 'student001', '123456', 1, '13600136001', '2001-01-15', '王学生', '2026-06-09 14:54:04', '2026-06-09 14:54:04', 1, 3, '普通用户');
INSERT INTO `student` VALUES (5, 'student002', '123456', 0, '13600136002', '2001-03-22', '赵同学', '2026-06-09 14:54:04', '2026-06-09 14:54:04', 1, 4, '普通用户');
INSERT INTO `student` VALUES (6, 'student003', '123456', 1, '13600136003', '2000-11-08', '刘宿舍', '2026-06-09 14:54:04', '2026-06-09 14:54:04', 1, 1, '普通用户');
INSERT INTO `student` VALUES (7, 'admin02', '123456', 0, '13800138002', '1988-12-25', '副管理员', '2026-06-09 14:54:04', '2026-06-09 14:54:04', 1, NULL, '管理员');
INSERT INTO `student` VALUES (10, 'wl', '123456', 1, '15023461793', '2026-06-03', 'wl', '2026-06-09 16:44:27', '2026-06-09 16:44:27', 1, 1, '普通用户');
INSERT INTO `student` VALUES (11, 'zcj', '123456', 1, '15023461794', '2026-06-10', '郑昌军', '2026-06-09 16:44:58', '2026-06-09 16:44:58', 1, 2, '普通用户');
INSERT INTO `student` VALUES (12, 'gym', '123456', 1, '15023461797', '2026-05-06', '苟一民', '2026-06-09 16:45:22', '2026-06-09 16:45:22', 1, 2, '普通用户');

-- ----------------------------
-- Table structure for t_check_item_template
-- ----------------------------
DROP TABLE IF EXISTS `t_check_item_template`;
CREATE TABLE `t_check_item_template`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `big_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大类别',
  `small_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小类别',
  `check_standard` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '检查标准',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序号',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否启用 1-启用 0-禁用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '检查项目模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_check_item_template
-- ----------------------------
INSERT INTO `t_check_item_template` VALUES (1, '消防安全', '灭火器', '灭火器数量充足、压力正常、未过期', 1, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (2, '消防安全', '消防通道', '消防通道畅通无阻，标识清晰', 2, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (3, '消防安全', '烟感报警器', '烟感报警器工作正常，指示灯闪烁', 3, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (4, '用电安全', '电源线路', '电源线路无老化、裸露、私拉乱接现象', 4, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (5, '用电安全', '插座开关', '插座开关完好，无过载使用', 5, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (6, '用电安全', '配电箱', '配电箱标识清晰，门锁完好，周围无堆放物', 6, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (7, '化学品管理', '危化品存放', '危化品分类存放，标签清晰，MSDS齐全', 7, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (8, '化学品管理', '废液处理', '废液分类收集，容器密封，标识清楚', 8, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (9, '环境卫生', '实验台面', '实验台面整洁，无杂物堆放', 9, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (10, '环境卫生', '通风设施', '通风橱运行正常，排风效果良好', 10, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (11, '个人防护', '防护设备', '实验人员正确佩戴防护眼镜、手套等', 11, 1, '2026-06-09 14:54:04');
INSERT INTO `t_check_item_template` VALUES (12, '个人防护', '应急设备', '洗眼器、喷淋装置功能正常', 12, 1, '2026-06-09 14:54:04');

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `leader` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES (1, '实验室安全管理部', '张部长', '负责实验室安全综合管理', '2026-06-09 14:54:04');
INSERT INTO `t_department` VALUES (2, '化学实验中心', '李主任', '负责化学实验室安全巡查', '2026-06-09 14:54:04');
INSERT INTO `t_department` VALUES (3, '物理实验中心', '王经理', '负责物理实验室后勤保障', '2026-06-09 14:54:04');
INSERT INTO `t_department` VALUES (4, '生物实验中心', '赵老师', '负责生物实验室学生事务', '2026-06-09 14:54:04');
INSERT INTO `t_department` VALUES (6, '安全负责检查部', '苟一民', '6668888', '2026-06-09 16:01:29');

SET FOREIGN_KEY_CHECKS = 1;
