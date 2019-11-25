/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : MINIMALISM

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 15/11/2019 17:45:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for biz_content
-- ----------------------------
DROP TABLE IF EXISTS `biz_content`;
CREATE TABLE `biz_content`  (
  `ID` bigint(20) NOT NULL COMMENT 'ID',
  `TYPE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型',
  `CONTENT_CN` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '中文内容',
  `CONTENT_EN` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '英文内容',
  `COMMIT_QQ` bigint(15) NULL DEFAULT NULL COMMENT '提交人QQ',
  `SHOW_QQ_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '是否同意展示QQ 1-同意 0-不同意',
  `SOURCE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源',
  `CONFIRM_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '审核状态 99-不通过 0-未审核 1-待定 2-通过 ',
  `CONFIRM_USER` bigint(20) NULL DEFAULT NULL COMMENT '审核人',
  `CONFIRM_TIME` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `CREATE_TIME` datetime(0) NOT NULL COMMENT '创建时间',
  `CREATE_USER` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '内容表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_extension
-- ----------------------------
DROP TABLE IF EXISTS `biz_extension`;
CREATE TABLE `biz_extension`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `URL` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地址',
  `DESCCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `PLATFORM` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '平台',
  `STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '生效状态 0-失效 1-生效',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `UPDATE_TIME` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `UPDATE_USER` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '推广链表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_logs`;
CREATE TABLE `sys_logs`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `USER_ID` int(11) NOT NULL COMMENT '用户id',
  `MODULE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模块名',
  `FLAG` tinyint(4) NOT NULL DEFAULT 1 COMMENT '成功失败',
  `REMARK` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `CREATE_TIME` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `userId`(`USER_ID`) USING BTREE,
  INDEX `createTime`(`CREATE_TIME`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `PARENT_ID` int(11) NOT NULL COMMENT '父ID',
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `CSS` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标样式',
  `HREF` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TYPE` tinyint(1) NOT NULL,
  `PERMISSION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SORT` int(11) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (7, 0, '系统设置', 'fa-gears', '', 1, '', 96);
INSERT INTO `sys_permission` VALUES (8, 7, '菜单', 'fa-cog', 'pages/menu/menuList.html', 1, '', 97);
INSERT INTO `sys_permission` VALUES (9, 8, '查询', '', '', 2, 'sys:menu:query', 100);
INSERT INTO `sys_permission` VALUES (10, 8, '新增', '', '', 2, 'sys:menu:add', 100);
INSERT INTO `sys_permission` VALUES (11, 8, '删除', '', '', 2, 'sys:menu:del', 100);
INSERT INTO `sys_permission` VALUES (12, 7, '角色', 'fa-user-secret', 'pages/role/roleList.html', 1, '', 8);
INSERT INTO `sys_permission` VALUES (13, 12, '查询', '', '', 2, 'sys:role:query', 100);
INSERT INTO `sys_permission` VALUES (14, 12, '新增', '', '', 2, 'sys:role:add', 100);
INSERT INTO `sys_permission` VALUES (15, 12, '删除', '', '', 2, 'sys:role:del', 100);
INSERT INTO `sys_permission` VALUES (16, 0, '文件管理', 'fa-folder-open', 'pages/file/fileList.html', 1, '', 8);
INSERT INTO `sys_permission` VALUES (17, 16, '查询', '', '', 2, 'sys:file:query', 100);
INSERT INTO `sys_permission` VALUES (18, 16, '删除', '', '', 2, 'sys:file:del', 100);
INSERT INTO `sys_permission` VALUES (19, 0, '数据源监控', 'fa-eye', 'druid/index.html', 1, '', 9);
INSERT INTO `sys_permission` VALUES (20, 0, '接口swagger', 'fa-file-pdf-o', 'swagger-ui.html', 1, '', 10);
INSERT INTO `sys_permission` VALUES (21, 0, '代码生成', 'fa-wrench', 'pages/generate/edit.html', 1, 'generate:edit', 11);
INSERT INTO `sys_permission` VALUES (26, 0, '日志查询', 'fa-reorder', 'pages/log/logList.html', 1, 'sys:log:query', 13);
INSERT INTO `sys_permission` VALUES (34, 0, 'excel导出', 'fa-arrow-circle-down', 'pages/excel/sql.html', 1, '', 16);
INSERT INTO `sys_permission` VALUES (35, 34, '导出', '', '', 2, 'excel:down', 100);
INSERT INTO `sys_permission` VALUES (36, 34, '页面显示数据', '', '', 2, 'excel:show:datas', 100);
INSERT INTO `sys_permission` VALUES (46, 0, '账套企业管理', 'fa-university ', 'pages/company/companyList.html', 1, '', 1);
INSERT INTO `sys_permission` VALUES (47, 46, '查询', '', '', 2, 'sys:company:query', 100);
INSERT INTO `sys_permission` VALUES (48, 46, '新增企业', '', '', 2, 'sys:company:add', 100);
INSERT INTO `sys_permission` VALUES (49, 46, '删除', '', '', 2, 'sys:company:del', 100);
INSERT INTO `sys_permission` VALUES (50, 0, '税表模板管理', 'fa-file-excel-o', 'pages/taxmodel/taxTableModelList.html', 1, '', 3);
INSERT INTO `sys_permission` VALUES (51, 50, '查询', '', '', 2, 'sys:taxmodel:query', 100);
INSERT INTO `sys_permission` VALUES (52, 50, '新增', '', '', 2, 'sys:taxmodel:add', 100);
INSERT INTO `sys_permission` VALUES (53, 50, '删除', '', '', 2, 'sys:taxmodel:del', 100);
INSERT INTO `sys_permission` VALUES (54, 0, '账套数据管理', 'fa-book', 'pages/bookset-data/booksetDataList.html', 1, '', 2);
INSERT INTO `sys_permission` VALUES (55, 54, '查询', '', '', 2, 'sys:booksetdata:query', 100);
INSERT INTO `sys_permission` VALUES (56, 54, '新增', '', '', 2, 'sys:booksetdata:add', 100);
INSERT INTO `sys_permission` VALUES (57, 54, '删除', '', '', 2, 'sys:booksetdata:del', 100);
INSERT INTO `sys_permission` VALUES (58, 0, '数据统计', 'fa-bar-chart', '', 1, '', 4);
INSERT INTO `sys_permission` VALUES (59, 58, '用户数据统计', 'fa-users', 'pages/metric/user.html', 1, 'sys:metric:user:query', 99);
INSERT INTO `sys_permission` VALUES (60, 58, '账套数据统计', 'fa-calculator', 'pages/metric/bookset.html', 1, 'sys:metric:bookset:query', 100);
INSERT INTO `sys_permission` VALUES (61, 0, '学生账号管理', 'fa-users', 'pages/dz-user/daizhangUserList.html', 1, '', 6);
INSERT INTO `sys_permission` VALUES (62, 0, '配置系统账号管理', 'fa-gears', 'pages/sys-user/systemUserList.html', 1, '', 7);
INSERT INTO `sys_permission` VALUES (63, 62, '查询角色', '', '', 2, 'sys:role:query', 100);
INSERT INTO `sys_permission` VALUES (64, 62, '新增角色', '', '', 2, 'sys:role:add', 100);
INSERT INTO `sys_permission` VALUES (65, 62, '删除角色', '', '', 2, 'sys:role:del', 100);
INSERT INTO `sys_permission` VALUES (66, 62, '查询用户', '', '', 2, 'sys:user:query', 100);
INSERT INTO `sys_permission` VALUES (67, 62, '新增用户', '', '', 2, 'sys:user:add', 100);
INSERT INTO `sys_permission` VALUES (68, 62, '删除用户', '', '', 2, 'sys:user:delete', 100);
INSERT INTO `sys_permission` VALUES (70, 0, '验证码信息', 'fa-paper-plane', 'pages/verify-code/verifyCodeList.html', 1, 'sys:verifycode:query', 12);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `ID` int(11) NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `DESCRIPTION` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (-1, '超管', '超级管理员');
INSERT INTO `sys_role` VALUES (1, '管理员', '普通管理员');
INSERT INTO `sys_role` VALUES (99, '用户', '普通用户');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `ROLE_ID` int(11) NOT NULL COMMENT '角色ID',
  `PERMISSION_ID` int(11) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`ROLE_ID`, `PERMISSION_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `ID` bigint(20) NOT NULL COMMENT '用户ID',
  `USERNAME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `PASSWORD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `NICKNAME` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `CURRENT_LOGIN_TIME` datetime(0) NULL DEFAULT NULL COMMENT '当次登录时间',
  `LAST_LOGIN_TIME` datetime(0) NULL DEFAULT NULL COMMENT '上次登录时间',
  `UPDATE_TIME` datetime(0) NOT NULL COMMENT '更新时间',
  `UPDATE_BY` bigint(20) NOT NULL COMMENT '更新人',
  `CREATE_TIME` datetime(0) NOT NULL COMMENT '创建时间',
  `CREATE_BY` bigint(20) NOT NULL COMMENT '创建人',
  `STATE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '1:启用\n0:停用',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `USER_USERNAME_uindex`(`USERNAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `ROLE_ID` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`USER_ID`, `ROLE_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与角色关联表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
