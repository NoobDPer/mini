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



INSERT INTO `biz_content` VALUES (3, '1', '所谓成长，就是在听到波涛汹涌四个字，再也联想不到大海了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (11, '1', '一些年轻人，通过高端消费来营造自己高端收入的形象。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (12, '1', '一个姑娘的介绍：思想上的女流氓，生活中的好姑娘。 然而给我的感觉是：心思活络的丑逼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (13, '1', '谢谢你，在我每次需要你的时候都掉链子', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (14, '1', '先生，你这张卡上的钱也不够……', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (15, '1', '喜欢就去表白，不然你不会知道自己长得多丑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (16, '1', '所有抱怨社会不公和制度的人翻译过来只有一句话：请给我金钱，女人和社会地位。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (17, '1', '虽然我学得慢，但是我放弃的快啊！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (18, '1', '死并不可怕，怕的是再也不能活了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (19, '1', '谁说我不会乐器？我退堂鼓打的可好了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (20, '1', '世界这么大，我想去看看，什么地方要饭比较方便！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (21, '1', '世界上本没有鸡汤，鸡死了，便做成了鸡汤。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (22, '1', '诗和远方越远越脏 以梦为马越骑越傻！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (23, '1', '生活不止眼前的苟且，还有读不懂的诗和到不了的远方。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (24, '1', '上帝为你关上一道防盗门，还会顺手给你上了一把钛合金锁。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (25, '1', '如果所有人都理解你，那你得普通成什么样！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (26, '1', '如果十年之后你未娶，我未嫁，那真是太惨了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (27, '1', '人生不如意，十之有十！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (28, '1', '人人都想拯救世界，却没人帮妈妈洗碗。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (29, '1', '其实只要不要脸，很多人生难题都能迎刃而解。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (30, '1', '女人假装高潮来维持恋爱，而男人假装恋爱以获得高潮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (31, '1', '你每天都那么努力，忍受了那么多的寂寞和痛苦。可我也没见你有多优秀！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (32, '1', '你多努力一点，获得的打击就多一点。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (33, '1', '那些年立下的FLAG自己删了吧，反正也没人记得。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (34, '1', '没有什么事情能把人一次击倒，只要足够坚强，它会持续的把你击倒！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (35, '1', '没有人能让那你放弃减肥，你自己想想就会放弃了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (36, '1', '厉害的不是你有多少后台，而是你能成为多少人的后台！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (37, '1', '就算睡得晚，不会找你的人还是不会找你！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (38, '1', '今天的事不用放在今天做，万一明天死了呢，就可以不用做了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (39, '1', '很多时候，乐观的态度和好听的话帮不了你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (40, '1', '狗是人类最好的朋友。 然而狗最好的朋友是「屎」。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (41, '1', '给你的梦想插上翅膀，虽然不一定飞得很远，但肯定摔的很重！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (42, '1', '当你觉得生活对你不公时，秤秤体重，照照镜子，你会觉得一切又合乎情理。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (43, '1', '打趴下就不要爬起来了，反正还是会被打到趴下！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (44, '1', '曾经我也是打算靠脸吃饭的，后来差点饿死才放弃的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (45, '1', '不要以为世界抛弃了你，世界根本没空搭理你！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (46, '1', '别总骂恨铁不成钢，是你自己忘了，铁本来就不能成钢的啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (47, '1', '别人问你有谈恋爱吗？就说现在没有。可以机智地掩盖过去也没有的事实。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (48, '1', '别看我平时对你漠不关心，其实私下里我每天都盼着你出事！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (49, '1', '抱怨不会改变生活，但是钱可以！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (50, '1', '白天嘈杂得不愿意醒，夜晚安静得舍不得睡。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (51, '1', '做政治试卷，是我这辈子，说谎最多的时候。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (52, '1', '做一天的好人并不难，难的是做一辈子有钱人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (53, '1', '做题前，先想想出题者的用意，我觉得他想我死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (54, '1', '做事一定要考虑别人的感受，千万不能让他们太开心了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (55, '1', '做任何事情一定要坚持下去，总会让你看到，失败的那一天。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (56, '1', '做人要谦虚，多听听他人的意见，然后认真记下他们的名字。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (57, '1', '做人要安安稳稳本本分分，因为，你也根本搞不出什么幺蛾子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (58, '1', '做人如果没点追求，那么，该多轻松啊…', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (59, '1', '做梦梦到自己在考试，然后被吓醒，发现自己真的在考试。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (60, '1', '做了一个风险非常大的投资，要是成功一下就能挣几个亿，要失败我这两块就打水漂了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (61, '1', '做好万全的准备，就是为了当机会来临时，你可以巧妙地避开它。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (62, '1', '做好人没希望，做坏人不擅长。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (63, '1', '作为失败的典型，你实在是太成功了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (64, '1', '昨天遇见小学同班同学，没想到他混的这么差，只往我碗里放了一块钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (65, '1', '昨天一个小偷，来我家偷钱，我们一起找了一晚上。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (66, '1', '最怕你一生碌碌无为，还安慰自己说平凡可贵。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (67, '1', '最近一个月，总有那么三十天很不顺。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (68, '1', '最近改掉了熬夜的壞習慣，改通宵了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (69, '1', '纵然人生坎坷，但我从不向命运屈服！我通常都是直接屈膝Orz。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (70, '1', '總以為退一步海闊天空，沒想到腳下落空。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (71, '1', '总是在重复，尤其是错误！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (72, '1', '总是在凌晨想通很多事情，又在天亮之后，忘得一干二净。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (73, '1', '总结一下你的2018，留下你的不开心，让大家开心开心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (74, '1', '自由从来不是什么理所当然的东西，而是一项需要极高成本的特权。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (75, '1', '自古情深留不住，总是套路得人心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (76, '1', '装逼只是瞬间，不要脸那才是永恒。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (77, '1', '赚钱就像便秘 — 老难了，花钱就像拉稀 — 憋不住。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (78, '1', '转角一般不会遇到爱，只会遇到乞丐。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (79, '1', '注重细节，从小事做起，因为你根本做不了大事。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (80, '1', '众里寻她千百度，蓦然回首，那人依旧对我不屑一顾。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (81, '1', '终于中了500万，兑奖的时候，笑醒了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (82, '1', '至少在夏天，富得流油你已经做到了一半。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (83, '1', '知识给你力量，无知会给你更强大无畏，且无法预测的力量。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (84, '1', '知道为什么天妒英才吗？ 因为没人去管笨蛋活了多久。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (85, '1', '知道为何自古红颜多薄命吗？因为没人在意丑的人活多久。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (86, '1', '只有在车站大排长龙时，才能真正意识到，自己是龙的传人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (87, '1', '只有在，请假扣工资时，才觉得自己工资高。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (88, '1', '只有努力过了才知道，智商上的差距是不可逾越的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (89, '1', '只有努力过了才知道，智商上的差距，是不可逾越的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (90, '1', '只有努力过的人才知道，背景是多么重要！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (91, '1', '只有多替领导背锅，领导才会把你，当成傻子啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (92, '1', '只要有快递还在路上，就感觉这生活，还算有点希望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (93, '1', '只要选对了人生的方向，很容易就成功了，让我们恭喜只要和很容易。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (94, '1', '只要我肯努力，没什么事情是我搞不砸的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (95, '1', '只要我吃的夠快，体重绝对追不上我！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (96, '1', '只要是石头，到哪里都不会发光。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (97, '1', '只要努力的时间足够长，搞不好，你还可以失败的更彻底。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (98, '1', '只要你每天坚持学习，最终胜利肯定是属于，在考场上发挥好的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (99, '1', '只要你肯吃苦，肯努力，肯放下身段，去要饭，总会有人赶的', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (100, '1', '只要能用钱解决的事情，我一件都解决不了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (101, '1', '只要坚持不懈，嘲笑你的人，迟早会被你笑死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (102, '1', '只要功夫深铁杵磨成针，但真把铁杵磨成针的，绝对是大傻瓜。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (103, '1', '只要锄头挥得好，没有墙角挖不倒。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (104, '1', '只是因为在人群中，多看了你一眼，你就以为我要坐你的摩的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (105, '1', '挣钱是一种能力，花钱是一种技术，我能力有限技术却很高。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (106, '1', '正在输入…，给了多少人希望，又给了多少人失望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (107, '1', '正月初五迎财神，那都是有钱人的事，你就洗洗睡吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (108, '1', '真正努力过的人才知道，智商上的差距是不可逾越的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (109, '1', '真正努力过的人，就会明白，天赋是有多么重要。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (110, '1', '真正的勇士，敢于直面银行卡上的余额，敢于正视磅秤上的数字。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (111, '1', '真正的吃货，是可以把月供看成月饼的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (112, '1', '真希望有一天我的钱包，可以和我的脸皮一样厚。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (113, '1', '这一秒不放弃，下一秒，就更绝望了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (114, '1', '这世上如果有什么真理，那就是活该！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (115, '1', '这世上没谁离不开谁，就算是一条鱼离开水，也能烤着吃。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (116, '1', '这年头有些人靠脸吃饭，而有些人，靠不要脸吃饭。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (117, '1', '这年头放个假真不容易，连放假都要沾老祖宗的光。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (118, '1', '这年头，哪有不分手的恋爱，只有不伤手的立白。遇事得看开一点。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (119, '1', '这么多年没掉入桃色陷阱，靠的就是两个字，没钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (120, '1', '这两天雨水多，下雨记得打伞，否则脑袋容易进水。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (121, '1', '这孩子不是笨，就是学习方法不对。学习方法都找不对还不是笨啊？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (122, '1', '这个年纪会在你耳边唱歌，喜欢你的肉体还会送你包的，只剩下蚊子了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (123, '1', '这次期末考，我会用实力告诉你，我们年级共有多少人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (124, '1', '这辈子最灿烂的笑容，大概都奉献给，我的手机屏幕了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (125, '1', '这辈子这么苦，别太拼，下辈子还会更苦的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (126, '1', '找对象还是眼光高点好，你总得为，没有人喜欢你找个借口吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (127, '1', '找对象的时候，不要光看对方外表，得先看看自己外表！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (128, '1', '仗义每从屠狗辈，负心多是读书人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (129, '1', '长的美与不美不重要，想的美才是真的美！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (130, '1', '长的好看的才能叫吃货，长的不好看的只能叫饭桶。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (131, '1', '长的丑不是我的错，只是我在落地时太匆忙了，来不急打扮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (132, '1', '长得帅的踢键子都帅，长得丑的，打高尔夫都像在铲屎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (133, '1', '长得好看的才叫吃货，长得不好看的那叫饭桶！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (134, '1', '长得丑怎么了？我自己又看不到，恶心的是你们！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (135, '1', '债主，就是那个你破了产，也不会抛弃你的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (136, '1', '扎心？不存在的！心都没有扎哪里？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (137, '1', '早睡早起身体好，可是晚睡晚起真的心情好。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (138, '1', '早上醒来，我以为自己长大了，原来是被子盖横了～', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (139, '1', '早起的鸟儿有虫吃，可惜你是那条虫。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (140, '1', '早点睡吧，因为你喜欢的人，早就跟别人睡着了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (141, '1', '早晨起来照镜子，安慰自己说没事，还有比我更丑的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (142, '1', '糟糕的从来都不只是今天，还有你的以后。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (143, '1', '攒了一年头皮屑，只为给你下场雪。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (144, '1', '在最美的年纪遇见你，我想说，真是倒了血霉了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (145, '1', '在你最需要帮助的时候，只有鬼才来帮你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (146, '1', '在出租车内疯狂放臭屁，可以极大的降低，司机带你绕路的概率。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (147, '1', '再也沒有任何事情，比晚睡更快樂了，除了晚起。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (148, '1', '再努力一点，你就能走向，人生癫疯。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (149, '1', '再苦不能苦孩子，再穷也得穷得瑟。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (150, '1', '再不疯狂就老了，疯狂过后发现老的更快。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (151, '1', '运动一周瘦不下来不要紧，因为运动十周也瘦不下来的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (152, '1', '运动后，你会惊喜地发现，自己只是从肥胖变成壮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (153, '1', '月亮代表我的心，坑坑洼洼冷冰冰???。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (154, '1', '月老麻烦下次为我牵红线，能换成钢丝吗？红线老TM断。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (155, '1', '愿你以后，有酒有肉有姑娘，姑娘丑的不像样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (156, '1', '愿你的烦恼，像你的头发一样，越来越少。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (157, '1', '愿得一人心，免得老相亲。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (158, '1', '远方的路，除了未知，还有绝望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (159, '1', '遇到喜欢的人就勇敢追求，这样你才能知道，拒绝你的人远不止一个。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (160, '1', '遇到喜欢的女生要勇敢表白，只有你主动了，才知道她名花有主。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (161, '1', '遇到闪电记得要微笑，因为那是天空在给你拍照。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (162, '1', '遇到你之前，我的世界是黑白的，遇见你之后 哇靠 全黑了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (163, '1', '遇到困难的时候暂时放一放，第二天的时候，就再也想不起来了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (164, '1', '遇到困难的三个步骤，面对它 处理它，放弃它。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (165, '1', '愚人节表白算什么，清明节表白才是王道，失败了还可以说是鬼附身了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (166, '1', '愚人节，只是给说谎的人，一个说真话的机会。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (167, '1', '鱼与熊掌不可兼得，但穷和丑可以啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (168, '1', '鱼和熊掌不可兼得，但单身和穷可以！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (169, '1', '余生不想请你指教了，领教够了', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (170, '1', '又一天过去了，怎么样，是不是梦想更遥远了？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (171, '1', '又到了一切矛盾，都能用「大过年的」四个字，解决的时候了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (172, '1', '有缘千里来相会，无缘倒也省话费。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (173, '1', '有一天你会遇到一个妹子，她不要你的房也不要你的车，她也不要你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (174, '1', '有一段情，叫自作多情。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (175, '1', '有些事情还是要坚持的，比如睡觉，特别是闹钟响起的那一刻。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (176, '1', '有些事或人，不是你有钱就可以搞定的，你得有很多钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (177, '1', '有些事不是我不在意，而是我在意了，又能怎样？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (178, '1', '有些事，不说是个结，说了是个疤。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (179, '1', '有些人一旦错过了，真特么谢天谢地。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (180, '1', '有些人是好看的，有些人是难看的，而你是好难看的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (181, '1', '有些人努力了一辈子，就是从社会的四流，挤入了三流。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (182, '1', '有些人就是四，除了二，还是二。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (183, '1', '有些人出现在你的生活里，是想告诉你，你真好骗啊！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (184, '1', '有些人表面光鲜亮丽，实际上，船袜已经滑到了脚底板。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (185, '1', '有时你会觉得自己就是个SB，别灰心，至少感觉是对的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (186, '1', '有时候别人对你很冷淡，可能并不是你的问题。他也许只是不喜欢丑的而已。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (187, '1', '有时候，只要你下定决心做某件事，全世界都会拖你后腿。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (188, '1', '有什么不开心就睡一觉，没什么是睡一觉不能解决的，如果有那就再睡个回笼觉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (189, '1', '有人一笑就很好看，你是一看就挺好笑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (190, '1', '有人考试靠实力，有人考试靠视力，尼玛我考试靠想象力！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (191, '1', '有人存你号码是为了打给你，我不一样，我是为了不接。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (192, '1', '有钱人终成眷属，没钱人只能吃土。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (193, '1', '有钱人终成眷属，没钱人亲眼目睹。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (194, '1', '有钱人离我好近，有钱离我好远！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (195, '1', '有钱人可以选择低调，而你，却只能低调。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (196, '1', '有钱能买来幸福吗？不能，有钱本身就是幸福！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (197, '1', '有钱了不起啊？有钱，真的了不起。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (198, '1', '有朋自远方来，虽远必诛。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (199, '1', '有困难要帮，没有困难，制造困难也要帮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (200, '1', '有很多时候，面子不是别人给的，是自己凑上来丢的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (201, '1', '有股强烈的学习欲望，幸好我自制力强，压下去了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (202, '1', '有个姑娘问我借钱去整容，整的挺成功，我再没认出是谁问我借的钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (203, '1', '友谊是什么？你智障多年，我不离不弃。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (204, '1', '友情越来越少，礼尚往来越来越多。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (205, '1', '由于性格太内向，一直做不出，抢着结账这种事。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (206, '1', '用钱当然买不到快乐，只是有钱，别人会想办法让你快乐。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (207, '1', '用美颜手机自拍多了，越来越不知道，自己有多丑了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (208, '1', '用扯淡的态度，面对操蛋的人生。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (209, '1', '用2B形容你，人家铅笔不乐意。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (210, '1', '勇敢面对磨难，那些杀不死你的顶多是让你，留下残疾。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (211, '1', '永远不要自暴自弃，一旦开始放弃，你就会发现非常开心', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (212, '1', '英雄一怒为红颜，红颜一怒，得花钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (213, '1', '因为穷我连关心你都不敢，就怕你说嘘寒问暖，不如打笔巨款。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (214, '1', '以我的资历和文凭，将来这个城市的大街，都归我扫。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (215, '1', '以前我每天都会买彩票，终于有一天，我连彩票都买不起了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (216, '1', '以前虽然穷但是很开心。现在不同往日了，不止穷还不开心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (217, '1', '以前上学是拿钱混日子，现在工作了，是在拿日子混钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (218, '1', '以前觉得靠关系的人，一定很无能，接触后发现人家样样比我强。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (219, '1', '以前过年就图个热闹，现在就想图个清静。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (220, '1', '以前除了读书什么都不懂，现在除了读书什么都懂。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (221, '1', '以后要对女朋友好一点，毕竟她已经瞎了，不能再受伤害了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (222, '1', '以后没钱了先找我借，我不想做最后一个，让你失望的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (223, '1', '一想到你，我的丑脸，就泛起微笑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (224, '1', '一无所有到，没有什么可以放弃时，别忘了你还能放弃治疗。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (225, '1', '一天不玩手机，人是不会死的，命还在但是魂丢啦！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (226, '1', '一路上有你，苦一点也愿意，苦很多免谈。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (227, '1', '一懒众衫小，薪尽自然凉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (228, '1', '一见钟情就是好看，深思熟虑就是没钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (229, '1', '一个人最长的恋爱史，大概就是自恋了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (230, '1', '一个成年人是不会挑食的，他们会说，我对这个过敏。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (231, '1', '一顿操作猛如虎，一看工资二千五。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (232, '1', '夜撩了酒，酒撩了你 你撩了我，穷困潦倒了我们。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (233, '1', '也许睡眠，才是人类真正的活动形态，难怪我总是睡不醒。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (234, '1', '也许命运扼住你的咽喉，只是让你少吃两口。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (235, '1', '要笑着走下去吧，反正来到这个世界上，谁也没打算活着回去。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (236, '1', '要相信自己，别人能做到的，你也做不到。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (237, '1', '要感谢那些把你打倒的人，因为你会发现躺倒真的很舒服', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (238, '1', '腰缠万贯，全是脂肪。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (239, '1', '眼睛千万不要对着手机太久，专家说了，那样手机会没电。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (240, '1', '研究证明常年抽烟喝酒的人，患老年痴呆的概率较低，因为早死的概率较高。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (241, '1', '学校教学楼放镜子，是为了让你知道，人丑就要多读书。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (242, '1', '学习使人快乐，不学习使人，更快乐。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (243, '1', '学海无涯，回头是岸。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (244, '1', '学过很多技能，到头来才发现，最有用的技能是——想开点！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (245, '1', '学而不思则罔，思而不学则殆。不思不学成网贷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (246, '1', '选择比努力更重要，所以我选择不努力', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (247, '1', '秀恩爱的最好在中午秀，因为，早晚都会有报应。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (248, '1', '胸怀鸿鹄之志，手无缚鸡之力。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (249, '1', '兄弟听我一句劝，游戏没了还能重玩，媳妇没了游戏就能一直玩了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (250, '1', '幸亏你去年没洗头，要不然你今年，炒菜连油都没有。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (251, '1', '醒醒，你这不是丧而是，没有钱和性生活的正常表现。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (252, '1', '信就信，不信就不信，还TM整个微信。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (253, '1', '心是伟大的诗人，而嘴是蹩脚的编辑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (254, '1', '心软不是病，回头才致命。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (255, '1', '心灵鸡汤是给吃惯了鲍参翅肚的人做的换口味小菜，屌丝以为喝一碗鸡汤就营养全面提升了？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (256, '1', '心比天高，命比纸薄。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (257, '1', '卸妆对你来说，又叫洗钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (258, '1', '小学的英语水平支撑到现在，越来越力不从心了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (259, '1', '小时候做过的最蠢的事，可能是盼着长大吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (260, '1', '小时候最讨厌吃饭和睡觉，现在想想真贱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (261, '1', '小时候最怕梦到自己找厕所，最最可怕的是，人没醒来厕所却找到了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (262, '1', '小时候我们都很快乐，因为那个时候我们，丑和穷都还不是那么明显。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (263, '1', '小时候我常想，长大了是上北大还是清华，现在想想原来是我想多了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (264, '1', '小时候的梦想是当一个英雄，没想到手机里就能轻松实现，而且选择还挺多的呢。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (265, '1', '小时候不爱吃饭，导致现在个矮。现在爱吃饭了导致又胖又矮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (266, '1', '小三是个好东西，她带走了不爱你的狗东西。 ???', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (267, '1', '小明长期被爸妈蒙在鼓里，导致窒息而死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (268, '1', '像你这样的人，哪怕把土豪两个字贴在脸上，别人也会反过来读。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (269, '1', '想做你的太阳，高兴的时候温暖你，不高兴的时候晒死你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (270, '1', '想要打起精神，却一不小心把他打死了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (271, '1', '想要逼死一个强迫症，那实在是太简了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (272, '1', '想买一辆保时捷卡宴，请问买过的朋友，你们的钱都是从哪里来的！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (273, '1', '想和男朋友去看电影，有什么好看的，男朋友介绍吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (274, '1', '想好了的是假象，认真的做了也没前途。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (275, '1', '想奋斗？手机能从你的手上拿下来，就算是拼搏了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (276, '1', '想变美就多睡觉，睡懵了就觉得自己美了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (277, '1', '相信你一定不会被生活打倒，因为你的体重，超过了生活的预料。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (278, '1', '相亲最大的好处是，如果以后婚姻出问题，你可以把责任推给媒人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (279, '1', '乡愁是一张小小的车票，我在这头，黄牛在那头。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (280, '1', '現在矮矬窮不要緊，要相信將來有一天，你會變成矮矬窮老…', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (281, '1', '现在流的泪，都是当初脑子进的水。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (282, '1', '现在苦点没关系，人只要活着就一定会有好事，发生在别人身上。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (283, '1', '现在的时代，不是属于00后的，是属于厚脸皮的！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (284, '1', '现在的女生太不像话了，领口开这么低，还看不到事业线', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (285, '1', '现在的女孩子如果不努力，是会被抓去结婚的，并且还要生二胎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (286, '1', '现在的年轻人，除了睡觉时间不想睡，其它时间都想睡觉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (287, '1', '现实就是，你这个前浪还没开始浪，就已经被拍死在沙滩上了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (288, '1', '咸鱼翻身是为了晒得透彻，你翻身是因为手被压麻了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (289, '1', '咸鱼翻了身，也还是咸鱼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (290, '1', '喜欢一个人是藏不住的，就算躲在衣柜里，还是会被她老公发现。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (291, '1', '喜欢一个人就去表白，万一，成备胎了呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (292, '1', '喜欢就要表白，这样才能知道你是几号备胎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (293, '1', '希望有些事情可以自己解决，不是我自己，是事情自己。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (294, '1', '希望无时无刻不在，而你，每时每刻都错过。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (295, '1', '希望是火，失望是烟，人生就是一边生火一边冒烟。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (296, '1', '西游记告诉我们，有个猪一样的队友，能让团队上西天。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (297, '1', '物以类聚人以穷分，有钱人终成眷属。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (298, '1', '武则天证明了，成功和性别没关系，你证明了成功和你没关系。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (299, '1', '吾日三省吾身，吾没钱 吾没车 吾没房。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (300, '1', '无论最后我们疏远成什么样，一个红包，就能回到当初。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (301, '1', '无论遇到任何事情，在哪里跌倒，就在那多躺一会吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (302, '1', '无论你二或不二，二就在那里，不三不四。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (303, '1', '无毒的身躯扛下有毒的疫苗，你是教育我从小就要坚强！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (304, '1', '我最大的缺点，就是缺点钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (305, '1', '我知道虚度年华不对，但是这样，真的好过瘾啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (306, '1', '我知道岁月会磨平我的棱角，但没想到，是把我按在地上摩擦。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (307, '1', '我只想和你叙叙旧，你却问我要不要代购。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (308, '1', '我真的挺羡慕你的皮肤，你说你是怎么能，把它保养的那么厚呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (309, '1', '我这人从来不记仇，一般有仇当场就报了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (310, '1', '我这人不太懂音乐，所以时而不靠谱，时而不着调。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (311, '1', '我这人吧，永远不要挑战我的底线，否则我又得修改底线。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (312, '1', '我这辈子没求过谁，只求过阴影部分面积。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (313, '1', '我有一颗早起的心，可我的被子和床不同意。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (314, '1', '我有一个梦想，只是有一个梦想。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (315, '1', '我有个朋友停止了抱怨，开始努力奋斗，几年过去了还是这个鸟样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (316, '1', '我因为穷，所以国庆在家，躲过了一节。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (317, '1', '我以为我们能一起走到最后，谁知道，你走了两步就要打车。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (318, '1', '我以为明天会更好，后来我天天盼着明天。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (319, '1', '我已经到了法定结婚年龄，请问去民政局领证的时候，老婆是自己带还是等他们发？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (320, '1', '我已经不是那个花五十块钱，也要考虑很久的小孩了，现在五块钱都要深思熟虑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (321, '1', '我一般说话都会给人留面子，万一我怼你了，没错我就是故意的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (322, '1', '我也想做一个优雅的淑女，是生活把老娘逼成了泼妇。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (323, '1', '我也曾青春逼人，可惜现在青春没了，就剩这么个逼人了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (324, '1', '我要没点自我安慰的本事，还真活不到现在。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (325, '1', '我想重新认识你，从你叫什么名字开始。你叫什么来着？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (326, '1', '我想早恋，但是已经晚了…', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (327, '1', '我想要住进你心里，才发现是个小区，还有许多邻居。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (328, '1', '我躺在床上看天花板，想着我工作的天花板，只是别人的地板。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (329, '1', '我虽然不能来一场，说走就走的旅行，但我有一个说胖就胖的体质。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (330, '1', '我说哪句话让你伤心流泪了，请告诉我，我再说一遍。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (331, '1', '我是一条酸菜鱼，又酸又菜，还多余。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (332, '1', '我是深知欲速则不达，心急吃不了热豆腐的，你怎么能说我有拖延症？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (333, '1', '我试过销声匿迹，最终也无人问及。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (334, '1', '我生气的时候你一定要哄我，买吃的给我。等老子吃饱了打死你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (335, '1', '我生平最讨厌一个字，略！尤其是题不会做时。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (336, '1', '我上班就是为了赚钱，别和我谈理想，我的理想是不上班。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (337, '1', '我擅长做空A股，只要我一买，立刻跌。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (338, '1', '我亲眼看着你走上台，不知道你是将要献丑，还是出丑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (339, '1', '我能想到最浪漫的事，就是看你一人慢慢变老。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (340, '1', '我能想到最浪漫的事，就是和你一起吃吃吃，然后你付钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (341, '1', '我能想到，对自己最准确的形容词只有：肥美。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (342, '1', '我们是好朋友，你摔倒了我会把你扶起来，不过要等我笑完。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (343, '1', '我们非常努力，才能活得像个普通人', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (344, '1', '我们都史无前例的有默契，突然你不理我我也不理你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (345, '1', '我每天拼了命努力就是为了，向那些看不起我的人证明，他们是对的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (346, '1', '我没有去过你的城市，但我刷过你那的题。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (347, '1', '我连穷和丑都不怕，还怕单身？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (348, '1', '我连名牌都不认识几个，有时候，别人在炫富我都不知道。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (349, '1', '我可以划船没有桨，我可以扬帆没有方向，因为我这一生全靠浪。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (350, '1', '我觉得一定有很多人暗恋我，因为这么多年了，也没有人跟我表白！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (351, '1', '我觉得失恋不可怕，眼瞎才可怕。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (352, '1', '我交朋友，从不在乎他有没有钱，反正都没有我穷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (353, '1', '我捡了个神灯，许愿我死前能找到女朋友，结果我获得了永生！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (354, '1', '我好想你，第一句是假的，第二句也是假的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (355, '1', '我鼓足勇气去面对现实，却发现勇气，真的只是气而已。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (356, '1', '我发现我挺能哄女孩睡觉的，只要我一发信息，女孩就说我要睡觉了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (357, '1', '我对生活充满向往，生活对我虽远必诛。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (358, '1', '我的原则，只有三个字，看心情。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (359, '1', '我的意中人是个盖世英雄，总有一天他会，踩着七色彩云去娶别人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (360, '1', '我的眼里只有你，因为你的大脸，让我看不到别人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (361, '1', '我的兴趣爱好分动态和静态，动态就是翻身，静态就是睡觉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (362, '1', '我的未来就是个梦，更遗憾的是，这会儿还失眠。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (363, '1', '我的社交恐惧症，主要来自于，收入低。???', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (364, '1', '我的钱虽然不是大风刮来的，但像被大风刮走的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (365, '1', '我的脑袋不是空的。我是要大作为的人，只是混沌初开。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (366, '1', '我的目标是三十岁有套房子，现在实现一半，已经三十岁了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (367, '1', '我到底是活了16年，还是活了1天，重复了16年？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (368, '1', '我从你眼里看到了两样东西，一样是真诚，而另一样是眼屎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (369, '1', '我从来不会脑残地，在网上晒自己买的名牌，因为我买不起。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (370, '1', '我从曾经的一无所有，到现在的身无分文。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (371, '1', '我从不以强凌弱，我欺负他之前，真不晓得他比我弱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (372, '1', '我从不去想何时能成功，既然选择了远方，那就还远着呢。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (373, '1', '我丑，是为了降低画质提高性能，为什么我的人生还那么卡呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (374, '1', '我超级超级喜欢小动物，怎么说呢，就是顿顿都有吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (375, '1', '我尝试着做一个有趣的人，后来却跑偏了，成了一个逗逼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (376, '1', '我曾经得过精神分裂症，但现在我们已经康复了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (377, '1', '我不想读书，主要是因为家里牛啊，猪啊羊啊都没人喂。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (378, '1', '我不是诸葛亮，也没有草船，但为何你的贱一直往我这放？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (379, '1', '我不是那种，落井下石的人，我是直接把井封了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (380, '1', '我不是矮，我只是离天空比较远。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (381, '1', '我不怕变成自己厌恶的人，我怕过得还不如他们。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (382, '1', '我不骂人，那是因为我，动手能力比较强。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (383, '1', '我不会两面三刀，可我经常被两面插三刀。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (384, '1', '我本想享受生活，结果发现活下来都很困难。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (385, '1', '我把她从女孩变成了女人，她把我从男孩变成了，穷人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (386, '1', '问世间钱为何物，只叫人生死相许。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (387, '1', '问渠那得清如许，唯有毒汤活水来！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (388, '1', '问君能有几多愁，恰似一群太监上青楼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (389, '1', '唯一比孤独更可怕的，是被人知道你孤独。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (390, '1', '为什么总是天妒英才呢？因为没人管笨蛋活多久。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (391, '1', '为什么中国人结婚，都非要选个好日子呢？因为结完婚就没好日子过了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (392, '1', '为什么在学校，一上课就想睡觉？因为学校是梦开始的地方。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (393, '1', '为什么要吵架呢？就不能心平气和的坐下来，打对方几巴掌吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (394, '1', '为什么你能像智障一样活着，而我却不可以。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (395, '1', '为什么家长只看分数？废话！难道他们看得懂题目？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (396, '1', '为了防止我这个月又乱花钱，我提前把钱，都花完了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (397, '1', '为了变漂亮，你坚持了哪些好习惯？坚持开美颜。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (398, '1', '望穿秋水之寒，无论如何也比不了，忘穿秋裤之冷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (399, '1', '忘记以前的不开心，因为以后会更不开心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (400, '1', '往往那些不起眼的小餐馆，才能吃到真正的美味，而那些大酒店的我吃不起。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (401, '1', '往事不堪回首，是因为，你根本没有可以回首的往事。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (402, '1', '王子拿着留下的43码水晶鞋陷入沉思', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (403, '1', '玩手机时间长要让眼睛休息，把视线投向窗外，想一想为什么自己这么穷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (404, '1', '外貌不重要，爱情看的是感觉，可是人家对丑的没感觉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (405, '1', '脱了衣服我是禽兽，穿上衣服，我是衣冠禽兽。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (406, '1', '脱发怎么办？要健康饮食保持良好心态，这样就能接受这个事实了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (407, '1', '突然发现，起床第一件事是摸手机，睡前最后一件事是放下手机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (408, '1', '突破瓶颈之后，发现还有瓶盖。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (409, '1', '投对了简历找到一份好工作，投对了胎，可以不用找工作。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (410, '1', '偷一个人的主意是剽窃，偷很多人的主意是研究。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (411, '1', '同样是出卖自己，有的人成了大姐，有的人成了小姐。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (412, '1', '同样都是咸鱼，为什么别人可以翻身，而你却粘锅了？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (413, '1', '同甘共苦你不陪，荣华富贵你是谁？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (414, '1', '聽說七月鬼門快開了，你總算不是孤家寡人了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (415, '1', '听说自从你得了神经病，整个人都精神多了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (416, '1', '听说你过的没我好，那我就放心了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (417, '1', '听说你过的不好，我蹲在门口，笑了一整天。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (418, '1', '听说你的城市下雨了，不知道你带伞没有，如果带了这雨就白下了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (419, '1', '听君一席话，浪费十分钟。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (420, '1', '听成绩的时候要用右耳听，因为左耳靠近心脏，可能会猝死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (421, '1', '铁打的身子，磁铁打的床。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (422, '1', '铁杵能磨成针，但木杵只能磨成牙签。材料不对再努力也没用。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (423, '1', '条条大路通罗马，每条都有收费站。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (424, '1', '条条大路通罗马，可是有人就出生在罗马', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (425, '1', '条条大路通罗马，而有些人，就生在罗马。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (426, '1', '天涯何處無芳草，全都長在別人家。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (427, '1', '天生我才必有用，前提是，你得是天生的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (428, '1', '天没降什么大任于我，照样苦我心智，劳我筋骨。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (429, '1', '天空没有翅膀的痕迹，除非你飞的时候会掉毛', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (430, '1', '天将降大任于斯人也，必先苦其心志劳其筋骨，后来天改主意了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (431, '1', '特别能吃苦这五个字，我想了想，我只能做到前四个。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (432, '1', '逃避是解决不了问题的，不逃你也解决不了啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (433, '1', '倘若互不相欠，怎会再次相见。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (434, '1', '谈钱伤感情，谈感情伤钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (435, '1', '摊煎饼的大妈说，她月入三万，不差你一个鸡蛋。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (436, '1', '贪图小利，难成大事，要贪就贪大的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (437, '1', '他喜欢你素颜，必须是素颜好看。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (438, '1', '他们笑我长的丑，我笑他们讲的对。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (439, '1', '他们说网络很假，我笑了，好像现实很真一样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (440, '1', '所有的故事都会有结局，只有生活跟你没完。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (441, '1', '所谓婚姻，就是两个家庭的，资产重组。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (442, '1', '所谓复习就是，把不会的东西再确认一遍，你确实不会。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (444, '1', '岁月是把杀猪刀可他拿丑的人一点办法都没有', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (445, '1', '岁月是把杀猪刀，可是他拿丑的人，一点办法都没有。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (446, '1', '岁月让我知道，除了快递，我谁都不必等。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (447, '1', '随风奔跑自由是方向，无奈忘了腿短没力量。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (448, '1', '虽然我长得丑，但是买了漂亮衣服，我就可以丑的漂亮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (449, '1', '虽然你长的丑，但是你想得美啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (450, '1', '虽然你长得矮，但你发际线高啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (451, '1', '虽然你已无法再长高了，但是你可以继续长胖啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (452, '1', '虽然你学的慢，但是你，放弃的快呀。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (453, '1', '虽然你单身，但是你胖若两人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (454, '1', '虽然你搬砖的样子很累，但是，你充钱的样子真的很帅。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (455, '1', '虽然脑子和肠子长得很像，但你也不能老是用来装屎啊！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (456, '1', '俗话说人无远虑，必定很有钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (457, '1', '俗话说祸不单行，可见连祸都是有伴儿的，你再看看你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (458, '1', '送你喜欢的女生一支口红吧，至少她亲别人的时候，有你的参与感。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (459, '1', '思想给了我们太多的自由，而我们拖累了思想！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (460, '1', '说好我们一起到白头，你却偷偷焗了油。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (461, '1', '说错话不要紧，你还会继续说错的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (462, '1', '顺其自然只是无能为力的另一种说法', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (463, '1', '睡觉睡到手抽筋，数钱数到自然醒。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (464, '1', '谁说我不会乐器？我退堂鼓打的可好了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (465, '1', '谁说我不会乐器，我打退堂鼓可好了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (466, '1', '谁说你没有真爱，烦恼与你同在。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (467, '1', '谁说你没有毅力的，单身这件事，你不就坚持了好几十年吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (468, '1', '谁说你不爱运动？你不仅会踢皮球，而且踢的可好了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (469, '1', '谁说金钱买不到时间，网管再续两个小时。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (470, '1', '双十一过后，我从一个光棍，变成了一个负债累累的光棍。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (471, '1', '熟练地运用，关我屁事和关你屁事，可以节省人生80%的时间。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (472, '1', '书山有路勤为径，怪你没有富贵命。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (473, '1', '瘦的人能把衣服穿出故事，胖的人只能穿成事故。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (474, '1', '手机摔了这么多次都没事，想想还是我的身高救了它。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (475, '1', '手机的寿命是人类的1/20，请放下身边的杂事，好好陪陪它！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (476, '1', '是金子总会发光，但你只是块肥肉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (477, '1', '是好久不见，还是，视而不见。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (478, '1', '试着去了解那些你讨厌的人，你会发现，真是越看越讨厌。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (479, '1', '事情多不可怕，可怕的是你没能力解决。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (480, '1', '世上只有骗子是真心的，因为他是真心地在骗你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (481, '1', '世上无难事只怕有钱人，物以类聚人以穷分。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (482, '1', '世上无难事，只要肯放弃！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (483, '1', '世上什么事逼急了，都能做出来，除了数学题。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (484, '1', '世上没有钱解决不了的事，如果有，那就是你的钱不够。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (485, '1', '世上会有很多出人意料的事，比如，你以为我会举个例子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (486, '1', '世上99%的事情，都能用钱解决，剩下的1%则需要更多的钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (487, '1', '世人笑我太疯癫，我笑世人这么快就看出来了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (488, '1', '世界这么大，我想去看看，看看有没有塑料瓶。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (489, '1', '世界这么大 我想去看看。钱包那么小 你能走多远？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (490, '1', '世界上最宽广的是海洋，比海洋更宽广的是天空，比天空更宽广的是考试范围。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (491, '1', '世界上最动听的话，不是我爱你，而是你的肿瘤是良性的！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (492, '1', '世界上有两种人最傻B，一种是你这样的，另一种是像你这样的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (493, '1', '世界上唯一一件公平的事就是我们都会死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (494, '1', '世界上如果有钱办不到的事情，加钱一定可以办到。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (495, '1', '世界上脑残那么多，你却成了佼佼者。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (496, '1', '世界上没有无缘无故的爱，也没有无缘无故的恨，却TM偏偏有无缘无故的胖！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (497, '1', '世界上本没有路，走的人多了，老师就开始点名了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (498, '1', '世界那么大，能认识你，我觉得好不幸。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (499, '1', '世界离了你不会不转，只会越转越快，毕竟轻了很多。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (500, '1', '世界很公平，比你忙的人赚的比你多，比你闲的人你赚的比他少。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (501, '1', '世间很多事随着时间流逝，终究会变好的，比如你的胖终会变成好胖。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (502, '1', '时间是最好的老师，但遗憾的是，最后它把所有学生都弄死了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (503, '1', '时间就像胸，挤挤就有了，躺下就没了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (504, '1', '时间就是金钱，我在浪费时间？不～我只是在炫富！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (505, '1', '时间会帮你攒够失望，并告诉你不用谢。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (506, '1', '失眠睡不着，可能是因为，你手机还有电。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (507, '1', '失恋之后快打起精神，毕竟，还有下一个渣男在等着你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (508, '1', '失败也是成功的一部分，在哪里跌倒，就在哪里讹人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (509, '1', '失败是成功之母，可惜成功六亲不认。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (510, '1', '失败乃成功之母，可是我TM失败的次数太多，都不知道谁是亲妈。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (511, '1', '失败乃成功之母，可失败连男朋友都没有。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (512, '1', '失败乃成功之母，但往往失败都是，不孕不育。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (513, '1', '失败的尽头是绝望，努力的终点是过劳。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (514, '1', '失败不可怕，可怕的是，你还相信这句话。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (515, '1', '失败并不可怕，可怕的是你还相信这句话。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (516, '1', '生平最讨厌溜须拍马的人，和他们在一起，显得老子很不会做人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (517, '1', '生命中必然要放弃某些人，不是你不在乎，是他们不在乎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (518, '1', '生活中很多人喜欢小题大作，其实真的没有必要，要想想大题怎么办。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (519, '1', '生活磨光你的棱角，是为了让你，滚的更远。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (520, '1', '生活没有翻不过去的坎，只有翻不完的坎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (521, '1', '生活就像海绵里的水，只要你不愿意挤，总有一天会蒸发完的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (522, '1', '生活会让你苦上一阵子，等你适应以后，再让你苦上一辈子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (523, '1', '生活还是有意思的，毕竟每天都因为不同的原因想死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (524, '1', '生活费就像大姨妈，一个月来一次，几天就没了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (525, '1', '生活不止眼前的压力，还有背后的灾难。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (526, '1', '生活不止眼前的苟且，还有一辈子的苟且。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (527, '1', '生活不止眼前的苟且，还有前任的喜帖，所以拉黑很重要。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (528, '1', '生活不是这样就是那样，总之，不会是你想的那样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (529, '1', '生活不仅有眼前的苟且，还有远方的枸杞。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (530, '1', '生活不会放弃你，但也不会放过你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (531, '1', '生活，开始对我这种小鸡爪子，放泡椒了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (532, '1', '什么事情可以让你，放下尊严低声下气？抄作业。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (533, '1', '什么时候，能把我脑子里的钱，提现就好了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (534, '1', '什么都在涨价，就是人越来越贱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (535, '1', '身在福中不知福是什么？就是发福快发成猪了，还觉得自己身材蛮OK。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (536, '1', '少小离家老大回，骚话学了一大堆。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (537, '1', '少年加油吧！只要你努力工作，你的老板一定会成功的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (538, '1', '上帝向人间洒满智慧，唯独你打了把伞。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (539, '1', '上帝为什么给你关上一扇门，还不是因为你见不得人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (540, '1', '上帝为你关上一扇门的时候还会顺手帮你把窗户也关上。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (541, '1', '上帝为你关上一道门的同时，还会顺带夹你的脑子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (542, '1', '上帝为你关上了一扇门，然后就去洗洗睡了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (543, '1', '上帝为你关上了一扇门，还会给它加上防盗锁，大插销。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (544, '1', '上帝不会亏待痴情的人，他都是往死里整。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (545, '1', '傻人有傻福，傻B没有。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (546, '1', '三观没用，你得靠五官！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (547, '1', '三分天注定，七分靠打拼，还有90分看脸。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (548, '1', '三百六十行，行行出BUG。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (549, '1', '若你的朋友每天生活都这么幸福，也就不会拍成照片发到朋友圈了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (550, '1', '如果再见不用红着脸，是否还能借点钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (551, '1', '如果有一天我消失了，即使我的朋友恋人不会找我，银行也会疯狂找我。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (552, '1', '如果有天发现你一夜暴富了，给自己一巴掌，快醒来别上班迟到了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (553, '1', '如果有钱也是一种错，那我情愿，一错再错。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (554, '1', '如果一个人秒回了你，那只能说明，他刚好在玩手机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (555, '1', '如果我有什么，让你不喜欢的地方，麻烦你自己克服一下。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (556, '1', '如果我的人生是一部电影，那你就是一个弹出来的广告。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (557, '1', '如果时间可以倒流，那一定是，你在做梦。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (558, '1', '如果生活欺骗了你，不要着急 — 拿出美颜相机，去欺骗生活。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (559, '1', '如果人生是一部电影，那你就是，中间弹出来的广告。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (560, '1', '如果全世界都不要你了，你要记得还有我，我也不要你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (561, '1', '如果全世界都不要你了，记得要来找我，我认识好几个人贩子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (562, '1', '如果你真的想要做好一件事，全世界都会为你挡路。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (563, '1', '如果你愿意，一层一层一层地剥开我的心，你会发现我缺心眼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (564, '1', '如果你有什么事，一定要告诉我，反正我也解决不了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (565, '1', '如果你喜欢一个女孩，就好好努力多挣钱，到时候多随点份子钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (566, '1', '如果你特别迷恋一个人，那么你一定配不上他！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (567, '1', '如果你容不下我，说明不是你的心胸太狭窄，就是我的人格太伟大。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (568, '1', '如果你去抢银行，不论成功还是失败，未来十年内你都不用再上班。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (569, '1', '如果你面前有一大笔钱，和一个万人迷，那么这和你有什么关系呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (570, '1', '如果你觉得每天都忙成狗，那一定是你的错觉。狗一定没你忙。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (571, '1', '如果你觉得，围着你的都是苍蝇，那可能你自己是坨屎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (572, '1', '如果你花钱都不开心，那么是你花钱方式不对。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (573, '1', '如果你还在坚持，说明你还不够绝望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (574, '1', '如果你放弃了今天的自己，你就战胜了明天的你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (575, '1', '如果你跌倒了，那就，找个舒服的姿势趴着吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (576, '1', '如果你的前半生过得很坎坷，也不必太担心，下半生你就会适应的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (577, '1', '如果你的男朋友对你百依百顺，从不拈花惹草。可能是因为他钱不够。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (578, '1', '如果你吃了亏，千万不要喝水，不然你会变污的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (579, '1', '如果你不珍惜我，那么过了这个村，我在下一个村等你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (580, '1', '如果你变成了备胎，请忘记你也是千斤顶。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (581, '1', '如果婚姻是爱情的坟墓，一年一次的结婚周年庆祝，便是在扫墓 了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (582, '1', '如果过年你看到我脸色不好，别想太多，就是你忘给红包了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (583, '1', '如果多年以后你未嫁我未娶，那么咱俩，也真够完犊子的了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (584, '1', '如果吃鱼可以补脑，你这智商，至少要吃一条鲸鱼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (585, '1', '如果吃亏是福的话，那我可能早就福如东海了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (586, '1', '如果不能一夜暴富，两夜也可以，三晚我也不嫌多。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (587, '1', '如果不能美得惊人，那就丑得销魂吧！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (588, '1', '任何时候都要记得微笑，这会让你看起来，像个不能随便惹的神经病。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (589, '1', '认识陌生人其实很麻烦，许多谎话又得重新说起。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (590, '1', '忍无可忍，就重新再忍。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (591, '1', '人总有一死，不是穷死就是心死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (592, '1', '人终有一死，或轻于鸿毛，或重于鸿毛。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (593, '1', '人一辈子都在寻找成功，但更多时候，找到的都是成功他妈！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (594, '1', '人要是决定自暴自弃了，就会活得特别开心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (595, '1', '人要是行，干一行行一行一行行行行行，行行行干哪行都行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (596, '1', '人心不足蛇吞象，没有实力别硬上！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (597, '1', '人为什么叫人类，因为人活着就是累。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (598, '1', '人生最大的耻辱是什么，考试作弊了还不及格。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (599, '1', '人生有两大悲剧，一个是得不到想要的东西，另一个是得到不想要的东西。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (600, '1', '人生如梦我失眠，人生如戏我穿帮，人生如歌我跑调。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (601, '1', '人生没有过不去的坎，只有一坎接一坎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (602, '1', '人生没有过不去的坎，过不去，只是因为你腿短。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (603, '1', '人生嘛，就是起起落落落落落落。到底了自然就会蹦跶两下。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (604, '1', '人生苦短，我又他妈懒', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (605, '1', '人生就像一个茶几，上面摆满了杯具。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (606, '1', '人生就像打电话，不是你先挂就是我先挂。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (607, '1', '人生就是六个大字，怎么着都不行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (608, '1', '人生和骑自行车不同，就算走下坡路，也不会轻松。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (609, '1', '人生第一次说谎，大多数都是，从写作文开始。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (610, '1', '人生的痛苦，不是因为没钱而痛苦，而是因为别人有钱你痛苦。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (611, '1', '人生不如意之事十有八九，剩下的十之一二，超级不如意', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (612, '1', '人生不如意十有八九，从来没碰见过一二。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (613, '1', '人生不如意何止八九，可与人言者何至二三。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (614, '1', '人生不如意的事十有八九，剩下的一二更加不如意！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (615, '1', '人如果没有梦想，那跟无忧无虑有什么分别？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (616, '1', '人人都想上天堂，却没有人想死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (617, '1', '人们常说，不要让青春留白，所以我把它抹黑了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (618, '1', '人家谈恋爱，靠长相靠浪漫靠烧钱，而你靠对方眼瞎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (619, '1', '人家呢只是胖着玩玩，而你是丑的认真。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (620, '1', '人家不是无趣，而是，懒得对你有趣。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (621, '1', '人和猪的区别就是，猪一直是猪，而人有时却不是人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (622, '1', '人还是要有梦想的，即使是咸鱼，也要做最咸的那一条。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (623, '1', '人还是要有梦想的，即使是咸鱼， 也要做最咸的那一条。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (624, '1', '人都需要努力的，努力过后你就会发现，你还真的是很普通。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (625, '1', '人的一生，三分天注定七分靠打拼，剩下的九十分靠父母。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (626, '1', '人丑就要多健身，这样就能在别人说你丑时，你可以揍他。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (627, '1', '人丑就要多读书，这样以后，才能有钱整容。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (628, '1', '人丑就要多读书，书并不能使你变得好看，却能让你更容易接受现实。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (629, '1', '人丑就要多读书，反正，其他什么事也与你无关。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (630, '1', '人不能低下高贵的头，但捡钱时例外。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (631, '1', '让刻苦成为习惯，用汗水浇灌未来，然后脱水而死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (632, '1', '群发的祝福和个位数的红包，都是没有灵魂的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (633, '1', '去年定了一个目标存款三万，今年掐指一算，还差五万。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (634, '1', '去看精神科时医生说，你没啥抑郁症，你是真的惨。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (635, '1', '秋天是收获的季节。别人的收获是成功与快乐，你的收获是认识到并不是每个人都会成功与快乐。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (636, '1', '窮一點不要緊，要緊的是不只一點。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (637, '1', '穷只是暂时的，只要你努力，你会发现你慢慢就习惯了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (638, '1', '穷你就努力啊！不努力折腾，你怎么负债百万。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (639, '1', '穷不要紧，抬头挺胸让大家看看，你不仅穷还丑还矮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (640, '1', '穷不可怕，可怕的是，最穷的人是我。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (641, '1', '穷，不是一种状态，而是一种常态。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (642, '1', '请珍惜那些伤害过你的人，毕竟其他人都懒得害你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (643, '1', '请珍惜对你好的人，否则错过了就不知道何时，才能再遇到另一个瞎了眼的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (644, '1', '请相信我，我所说的每句话，都是废话！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (645, '1', '请问在三伏天，有什么消暑良方吗？薪尽自然凉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (646, '1', '请不要叫我宅女，请叫我居里夫人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (647, '1', '情商最低的一句话，你踢我干啥？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (648, '1', '情人节不出意外的话，一个人过，出意外的话在医院过。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (649, '1', '清明节，应该回你的学校扫扫墓，因为那里埋葬了你的青春。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (650, '1', '悄悄地我吃了，正如我悄悄地胖。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (651, '1', '强扭的瓜甜不甜不重要，只要能解渴就行了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (652, '1', '强扭的瓜不甜，但是解渴啊！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (653, '1', '钱虽然难赚，但是容易花啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (654, '1', '钱买不来快乐，那一定是，你的钱太少了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (655, '1', '钱买不来爱情，但是可以买走爱情。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (656, '1', '钱对你真的就那么重要吗？讲了3个多小时了，一分钱都不降。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (657, '1', '钱不是万能的，但有钱真的可以为所欲为。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (658, '1', '钱包里放老婆的照片，是为了提醒自己记住，钱包里的钱是怎么没的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (659, '1', '前世五百次的回眸，却换来今世的一句，流氓。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (660, '1', '千万别把事情拖到明天，后天大后天都是好日子啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (661, '1', '掐指一算，你俩要散。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (662, '1', '骑电动车请戴好头盔，否则，开奔驰的同学会认出你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (663, '1', '骑白马的不一定是王子，也可能会是是唐僧！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (664, '1', '其实人生，在某个节点后就结束了，大家只是在等彩蛋。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (665, '1', '其实你也有超能力，怎么减都不瘦的能力。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (666, '1', '其实你也不是一无是处，至少在夏天，你还能喂蚊子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (667, '1', '其实你讨厌的并不是广场舞，而是广场舞大妈。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (668, '1', '其实你不丑，只是，你美得不明显。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (669, '1', '其实命运，真不是喜欢和你开玩笑，它是很认真的想弄死你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (670, '1', '其实表白未必是件好事，因为那样显得手黑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (671, '1', '其实，电脑游戏从小就训练你，把Boss当作自己最大的敌人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (672, '1', '破罐子不能破摔，得使劲摔！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (673, '1', '平时骂你就算了，非要等我打你，才知道我文武双全。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (674, '1', '贫穷限制了我那么多，为什么没有限制我的体重？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (675, '1', '贫贱不能移的意思就是，穷就好好在家呆着，哪儿也别去。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (676, '1', '朋友说借二十块钱回头给你，借完钱之后我才知道，有些人一转身就是一辈子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (677, '1', '胖子是不会饿死的，饿死了也是死胖子 。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (678, '1', '怕鬼真的太幼稚了，我带你看看人心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (679, '1', '偶尔还是要出去走一走，才知道躺床上多么舒服。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (680, '1', '女为悦己者容，男为悦己者穷!', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (681, '1', '女生之间的友谊啊，就像塑料花，虽然假但永不凋零。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (682, '1', '女生何必勾心斗角互相攀比，反正几十年后，都要一起跳广场舞的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (683, '1', '女人用丝袜征服了男人，男人用丝袜征服了银行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (684, '1', '女票突然变瘦了，多半是漏气了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (685, '1', '努力了这么久，但凡有点儿天赋，也该有些成功的迹象了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (686, '1', '努力加油，每一个困难，都会克服我。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (687, '1', '努力过失败过，没关系，重新努力会失败得更好。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (688, '1', '宁愿不说话看起来像个傻子，也不要，开口证明自己的确如此。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (689, '1', '宁可美的千篇一律 ，也不要丑的各有千秋。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (690, '1', '念念不忘，可有回响？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (691, '1', '年轻时我以为钱就是一切，现在老了才知道，确实如此。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (692, '1', '年轻人嘛，现在没钱算什么，以后没钱的日子还多着呢。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (693, '1', '年轻人不要老想着走捷径，父母强才是硬道理。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (694, '1', '年龄不是问题，身高不是距离，没钱谁喜欢你？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (695, '1', '你坐过最挤的公交车是什么？只是路过，却被挤上了车。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (696, '1', '你最想从母校带走的是什么？最想从母校带走的，是我的学费。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (697, '1', '你走了真好。不然总担心你要留下来吃饭', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (698, '1', '你走了真好，不然我总担心，你会留下来吃饭。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (699, '1', '你知道投资和投机的区别吗？一个是普通话，一个是广东话。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (700, '1', '你只要不抬杠，钱真的是万能的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (701, '1', '你只需看着别人精彩，老天对你另有安排。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (702, '1', '你这么擅长安慰他人，一定度过了许多，自己安慰自己的日子吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (703, '1', '你这两天早点回家，最近偷猪的多，我怕你出事。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (704, '1', '你长得很有创意，活得很有勇气。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (705, '1', '你怎么长得跟个二维码似的，不扫一下，都不知道你是什么东西！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (706, '1', '你在我心里，就像天上的星星，多一颗少一颗都无所谓。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (707, '1', '你愿意做我的太阳吗？那么请与我，保持92955886公里。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (708, '1', '你有什么擅长的运动吗？「逃避现实」。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (709, '1', '你永远不会知道，你的哪个好友，会成为下一个微商。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (710, '1', '你以为自己什么也做不好？你错了，你还可以做好一个废物。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (711, '1', '你以为有钱人很快乐吗？他们的快乐，你根本想象不到。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (712, '1', '你以为向生活低头就好了？生活是想让你跪下。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (713, '1', '你以为他给你点赞，是喜欢你？只是手滑罢了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (714, '1', '你以为你是一只虫子，能化茧成蝶，其实你只是一只蛆。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (715, '1', '你以为你是灰姑娘吗？拜托别做梦了，她可是伯爵的女儿。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (716, '1', '你以为男朋友是取款机，结果是十台机器，有九台半是存款机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (717, '1', '你以为浪子回头金不换，其实浪子可能只是，上岸缓一缓。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (718, '1', '你以为今天是最糟的一天么，明天会让你改变这个看法的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (719, '1', '你一无是处，但有件事做得特别好，就是做白日梦。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (720, '1', '你一定要笑，不然不会知道，自己有多少鱼尾纹。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (721, '1', '你要站在别人角度上去思考，总有一天你会发现，你丢失了自己。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (722, '1', '你要相信明天，一定会更好的，更好的把你虐成狗。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (723, '1', '你要是喜欢一个女生，就好好学习找个好工作努力挣好多好多钱，等她结婚的时候你多出点份子钱', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (724, '1', '你要是和自拍长得一样，怎么会没有男朋友。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (725, '1', '你要是过得好，我怎么能睡得着。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (726, '1', '你要努力的去生活，因为你只有努力了，才知道自己真的不行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (727, '1', '你要么非常努力，要么非常聪明，才能勉强过上平庸的生活。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (728, '1', '你想有钱？想想就可以了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (729, '1', '你想瘦成一道闪电么，闪电平均宽度是五米。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (730, '1', '你现在所拥有的，都不曾是你的，因为未来你都会失去。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (731, '1', '你现在的生活，也许不是你想要的，但绝对是你自找的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (732, '1', '你喜欢我哪一点啊？我喜欢你离我远一点。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (733, '1', '你无法用钱买来幸福，因为你根本没钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (734, '1', '你无法叫醒一个，不回你消息的人，但是红包能。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (735, '1', '你踢球受过最重的伤，是女友到球场给对手喂水！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (736, '1', '你所有的忧伤，都来自于你的余额。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (737, '1', '你虽然没有出过国，但是你每天都在倒时差。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (738, '1', '你说自己很丑，我觉得你不仅丑，还净说实话。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (739, '1', '你说冰是睡着的水，我只记得屁是屎的叹息。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (740, '1', '你是最棒的！不，是最胖的！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (741, '1', '你是转角遇到爱，可你想过对方吗？他是转角遇到鬼呀。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (742, '1', '你是我的小苹果，哎呀讨厌！我是说我TM真想削你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (743, '1', '你是谁不重要，重要的是，你闯进我生活想干啥？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (744, '1', '你是个做事认真的人，认认真真地帮别人，试了所有的错。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (745, '1', '你若不离不弃，我特么必死无疑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (746, '1', '你若帮了一急需用钱的朋友，他一定会记得你，在他下次急需用钱的时候。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (747, '1', '你若安好，那还得了~ ', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (748, '1', '你认真的样子，就像天桥上贴膜的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (749, '1', '你人人称道的美丽，里面都有PS的痕迹。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (750, '1', '你全力做到的最好，还不如别人随便搞搞。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (751, '1', '你前世一定是塑料袋，除了会装还是会装。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (752, '1', '你努力找他说话的样子，像极了商场里的导购。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (753, '1', '你能接受恋爱年龄差多大？只要长得好看，上下五千年都行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (754, '1', '你们之所以喝鸡汤，是因为肉呢被别人吃光了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (755, '1', '你们的对象叫你们什么？我的对象叫我滚.', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (756, '1', '你妹是个好姑娘，替你妈分担了很多。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (757, '1', '你每天都很困，因为你被生活所困。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (758, '1', '你俩看起来真般配，月老的垃圾分类，做的还挺到位。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (759, '1', '你连自己都睡不好，还想去睡别人？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (760, '1', '你连世界都没观过，哪来的世界观？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (761, '1', '你老是这么抠门，门都被你，抠坏了好几扇。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (762, '1', '你可以像只猪一样懒，却无法像只猪一样，懒得心安理得。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (763, '1', '你就一甘蔗男，刚开始可甜了，到后面全成渣。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (764, '1', '你就像我的阳光，看着就刺眼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (765, '1', '你就像是蓝天上的太阳，让人无法直视。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (766, '1', '你就算失败了99次，也要再努力一次，凑个整数。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (767, '1', '你就是个土豆丝，又土又逗，又屌丝。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (768, '1', '你就是个黄焖鸡，又黄又闷又垃圾。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (769, '1', '你就两点不行，这也不行，那也不行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (770, '1', '你敬人一寸，他将得寸进尺。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (771, '1', '你觉得很孤独，没关系，你还有手机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (772, '1', '你家住海边吗？这么浪。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (773, '1', '你获得了很多金钱，但同时也失去了很多东西，比如烦恼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (774, '1', '你和学霸的区别就是，你所有的灵光一闪，都是他的基本题型。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (775, '1', '你害怕穿的不好看被嘲笑？别担心，穿的好看也一样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (776, '1', '你还是别把我放在心里了，我不喜欢人多的地方。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (777, '1', '你还不算惨，惨的人，都没手机用。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (778, '1', '你过的好不好别人不知道，别人只能看到矮胖穷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (779, '1', '你过得好我替你高兴，你过得不好，我替全世界高兴。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (780, '1', '你给小草一点爱，小草还你一片绿！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (781, '1', '你复杂的五官，掩饰不了，你朴素的智商。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (782, '1', '你多努力一点，获得的打击就多一点。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (783, '1', '你的意中人是个盖世英雄，他每天会骑着七彩祥云，去网吧吃鸡。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (784, '1', '你的眼界，不止局限于你的生活环境，还局限于你的视力范围。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (785, '1', '你的戏，可以像你的钱一样，少一点吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (786, '1', '你的晚安，只是想让我闭嘴。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (787, '1', '你的人生跟你的发际线一样，后退的特别快。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (788, '1', '你的美别人看不到，你的丑一目了然。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (789, '1', '你的脸，犹如你的人生，一样坎坷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (790, '1', '你的脸，一分天注定，九分看滤镜。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (791, '1', '你的计划，就像零食，吃到肚子里之后就是个屁。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (792, '1', '你的臭脚被毒蛇咬了，抢救了6个小时，毒蛇终于救了过来。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (793, '1', '你的爸爸必须十分努力，才能让你看起来毫不费力。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (794, '1', '你得好好努力，才能配得上，被人利用。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (795, '1', '你倒下了，能顶替你的人千千万', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (796, '1', '你打起精神，3分钟就能做完的事情，打起精神就要花上3小时。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (797, '1', '你从来就没成功过，还怕什么失败？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (798, '1', '你从来不孤独，因为，孤独都不想跟你交朋友。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (799, '1', '你曾是我的太阳，是我的整个世界，现在想想也就是个球。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (800, '1', '你不是走在牛B的道路上，而是仍在，装逼的道路上溜达。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (801, '1', '你不是一无所有，你还有病！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (802, '1', '你不是选择困难症，你只是穷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (803, '1', '你不能总看那些你没有的，多看看你拥有的。算了你把眼睛闭上吧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (804, '1', '你不能因为你胖，就忽略了你的丑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (805, '1', '你不奋斗一下？怎么知道自己有多无能。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (806, '1', '你不懂得安排自己的人生，会有很多人帮你安排，他们需要你做的事。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (807, '1', '你并没那么缺少安全感，因为没钱是最安全的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (808, '1', '你并非什么事情都不做准备，起码你已经，准备好了要失败的嘛。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (809, '1', '你并不是一无所有，你还有病。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (810, '1', '你并不是无能，你只是没有选择的权力。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (811, '1', '你别看我平时对你，一副漠不关心的样子，其实背地里说了你很多坏话。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (812, '1', '你必须敢爱敢恨，才会发现你的爱恨，别人真的不在乎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (813, '1', '你抱什么不好，非要抱病在床！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (814, '1', '你把所有不一定，都变成了一定不。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (815, '1', '你把钱借给了你的朋友，那么他一定会记得你，在他下一次缺钱时。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (816, '1', '你爱不爱你的工作，工作都会在那等你，不离不弃。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (817, '1', '能用钱解决的都不是问题，但如何有钱，才是你最大的问题。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (818, '1', '能从上到下摸遍你全身的，也就只有，车站安检员了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (819, '1', '能不生气就不要生气，能不骂人就不要骂人，能动手就直接动手。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (820, '1', '能不能对我真心一点？当然可以！我是真心不喜欢你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (821, '1', '闹钟的作用对我来说，就是让我，换个姿势睡觉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (822, '1', '腦子有病得治，像你多好，沒有腦子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (823, '1', '脑子是个很棒的东西，希望你有。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (824, '1', '难受的时候摸摸自己的胸，告诉自己是汉子，要坚强。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (825, '1', '男人单身叫单身狗，女的单身叫狗不理。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (826, '1', '男女之间一定有纯友谊，每一个我认识的女生，都说最多只能跟我当朋友。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (827, '1', '那些人人羡慕的社会精英，其实过得不如你想象那样好。但肯定比你强得多的多。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (828, '1', '哪有什么直男，只要你够好看，都能变成弯的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (829, '1', '哪有什么优柔寡断，还不是因为怂。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (830, '1', '哪有什么来日方长，挥手便是人走茶凉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (831, '1', '哪有什么感同身受的心，全是站着说话不腰疼的嘴。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (832, '1', '目前最靠谱的发财方法，就是，你家拆迁了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (833, '1', '命只有一条，但要命的事，可不止一件。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (834, '1', '明天就要见对方家长了，好忐忑啊，毕竟是我先打的他们家小孩。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (835, '1', '明日复明日 明日何其多！既然这么多，不妨再拖拖。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (836, '1', '明明可以靠脸吃饭，你却靠才华，这就是你跟明明的差距。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (837, '1', '面试的时候，他们叫你去聊聊，真的只是去聊聊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (838, '1', '面对困难，再坚持一会儿，就会习惯的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (839, '1', '梦想还是要有的，万一下辈子实现了呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (840, '1', '梦想还是要有的，万一见鬼了呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (841, '1', '梦想还是要有的，不然哪天喝多了，你跟人聊啥？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (842, '1', '猛的一看你不怎么样，仔细一看，还不如猛的一看。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (843, '1', '妹妹你坐船头，哥哥我在岸上走。看这句的99%都是唱出来的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (844, '1', '美貌会消逝，但蠢是永恒的~', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (845, '1', '每一个抖腿的人，心里都有一台缝纫机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (846, '1', '每天叫醒我的不是理想，是楼下广场舞的音乐。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (847, '1', '每天对着镜子说一句你很棒，不久后，那镜子就会成为很棒的镜子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (848, '1', '每天都在勤勤恳恳地，思考一个问题，如何才能不劳而获？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (849, '1', '每天都要有新的期待，这样才能有新的失望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (850, '1', '每个女人都在寻找一个爷们，最后发现，最爷们的原来是自己。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (851, '1', '每当我找到成功的钥匙，就发现有人把锁芯给换了…', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (852, '1', '每当我勇敢地走出一步，上帝就会及时慷慨地为我，铺好下一步下坡路。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (853, '1', '每次想省钱的时候，就是你智商到达顶峰之时！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (854, '1', '每次临时抱佛脚的时候，佛总是给我一脚。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (855, '1', '每次看穷游日志的感受都是，那么穷就别TM出去浪了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (856, '1', '每次看你穿丝袜的时候，我都有一种无法言喻的感觉，那就是萝卜还包保鲜膜咧。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (857, '1', '每次花钱都说钱包在滴血，可殊不知你的钱包，已经失血过多而死了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (858, '1', '没有什么永垂不朽，但你可以。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (859, '1', '没有什么可以将你打败，因为你从未成功过。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (860, '1', '没有人瞧不起你，因为根本就没有人瞧你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (861, '1', '没有人能够让你放弃梦想，你自己试试，就会放弃了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (862, '1', '没有人关心你飞得多高，倒是有一群人，等着看你摔得多惨。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (863, '1', '没有钱的时候，听到别人说恭祝长命百岁，都觉得是一种诅咒。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (864, '1', '没有你想不到，只有你做不到……', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (865, '1', '没有看不到的消息，只有不想回的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (866, '1', '没有解决不了的问题，但是有解决不完的问题。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (867, '1', '没有，过不去的坎，只有过不完的坎。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (868, '1', '没人牵手，我就揣兜。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (869, '1', '没人嘲笑你的梦想，他们只是，嘲笑你的实力。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (870, '1', '没钱用的时候跟我说，让我知道不止我一个人，没钱用。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (871, '1', '没钱了来找我，让我告诉你没钱的日子，怎么过。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (872, '1', '没钱才上班还是上班才没钱，我不明白哪个环节出了问题，难道有中间商赚差价？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (873, '1', '没对象怕什么，我有对象，我下棋也没赢过啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (874, '1', '没吃饱只有一种烦恼，吃饱了有无数的烦恼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (875, '1', '买房的钱还没攒完，就要开始攒买坟的钱了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (876, '1', '马云成功跟长相没关系，姜尚成功跟年龄没关系，而成功跟你没关系。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (877, '1', '马不停的是蹄，你不停的是嘴。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (878, '1', '路遥知马力不足，日久见人心叵测。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (879, '1', '路漫漫其修远兮，吾将上下而求人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (880, '1', '领导说努力工作会更快成熟，所以，我现在看上去比他们都老。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (881, '1', '领导开会的时候，我们应该保持肃静，打扰别人睡觉是很不礼貌的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (882, '1', '两个人吵架，打他是解决不了问题的，但是解气啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (883, '1', '恋爱时会觉得像吸毒一样，分手了又会像戒毒一样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (884, '1', '离远一看长发飘飘，走近一看虎背熊腰，转身一看卧槽黑山老妖。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (885, '1', '离家不需要太大的勇气，回家才需要。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (886, '1', '老一辈的人常告诉我们，年轻的时候多吃点苦，这样老了才能习惯啊！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (887, '1', '老天是公平的，他给了你张丑脸，肯定还会给你个穷家。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (888, '1', '老师不用给我换座位，反正我坐哪，都聊得开。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (889, '1', '老婆饼里没有老婆，棉花糖里没有棉花，所以钱包里也没有钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (890, '1', '老板用你的时候你就是人才，不用你的时候就变成裁人！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (891, '1', '老板说只要我们努力工作，明年他就可以换玛莎拉蒂了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (892, '1', '懒又有目标，才是真的惨。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (893, '1', '懒是一个很好的托辞，说的好像你勤奋了就能干成大事一样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (894, '1', '垃圾还有大爷大妈捡走，你呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (895, '1', '困难也许会迟到，但绝不缺席。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (896, '1', '困难像弹簧，你弱它就强，你强它更强。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (897, '1', '快去努力吧，以证明自己，智商低。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (898, '1', '可以做牛，可以做马，但是千万别做乙方。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (899, '1', '可以不劳而获的，只有年纪和脂肪。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (900, '1', '可怕的不是，别人在今天忽悠你，而是忘了你这个人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (901, '1', '靠父母你是公主，靠男人你是王妃，靠自己你是乞丐。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (902, '1', '考试最崩溃的是看到一道题，模糊的记得老师讲过，但清晰的记得我没听。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (903, '1', '考试真是so easy，哪里不会考哪里！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (904, '1', '看著面善的，不一定是好人，還有可能是詐騙集團。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (905, '1', '看着溅我一身水远去的大奔，劳资心想等我有钱了，一定买一套雨衣。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (906, '1', '看时间不是为了起床，而是看还能睡多久。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (907, '1', '看见一个算命大师，我刚坐下他就问我，你算什么东西？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (908, '1', '看见别人走在成功的路上，你问问自己难道不想成为，他成功路上的绊脚石吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (909, '1', '看背影迷倒千军万马，转过头吓退百万雄师。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (910, '1', '开车我最讨厌两种人，一种是喜欢加塞的人，另一种是不让我加塞的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (911, '1', '绝望不在某时某刻，而在每时每刻。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (912, '1', '距离产生的不是美，而是第三者。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (913, '1', '据说到2020年，要消灭贫困人口，我还不想死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (914, '1', '据分析，造成婚外恋的根本原因，是结婚。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (915, '1', '就算是咸鱼，你也不是最咸的那条。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (916, '1', '就算是Believe，中间也藏着一个lie。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (917, '1', '就算你充电两小时，也不会有人和你通话五分钟。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (918, '1', '就算大雨颠覆全城，公司照样算你迟到。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (919, '1', '九年义务教育应该开腹语课，毕竟长大后会有太多话，难以启齿。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (920, '1', '静若瘫痪，动若癫痫。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (921, '1', '精神濒临崩溃的症状之一，就是相信自己的工作非常重要。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (922, '1', '经历过一番苦难之后，别人是苦尽甘来，而你是苦竟刚来。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (923, '1', '经过十年不断的努力和奋斗，我终于从懵懂无知的少年，变成了懵懂无知的青年。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (924, '1', '经过九年的打拼，我终于凑齐了，当年卖掉的那套房子的首付。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (925, '1', '经过多年的打拼，虽然没有什么收获，但你有债呀！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (926, '1', '经过大家的耐心劝导，我终于接受了，自己是傻逼这个事实。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (927, '1', '进入长辈朋友圈，了解最新谣言。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (928, '1', '尽量撮合身边的同学，这样可以，少出一笔份子钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (929, '1', '今晚吃鱼吧，我看你挺会挑刺的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (930, '1', '今天天气很好，在房间里宅久了，准备去客厅散散心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (931, '1', '今天所有的一切，不过是过眼云烟。从明天开始你会一无是处。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (932, '1', '今天是除夕夜，来来来，给你夹块你最爱吃的天鹅肉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (933, '1', '今年是过去十年最差的一年，好消息是，今年是之后十年最好的一年。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (934, '1', '浆糊不在办公桌上，在你脑子里。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (935, '1', '将薪比薪的想了想，算了，不想活了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (936, '1', '见到长辈时，不是我们不想叫他，而是压根就不知道叫他什么。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (937, '1', '減肥是一件大事，先讓我吃飽了，再來好好計畫計畫。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (938, '1', '减肥这件事情吧，减的快反弹的快，减的慢放弃的快。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (939, '1', '减肥就是要向妈妈证明，不光胖找不到对象，瘦也找不到！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (940, '1', '减肥，你想要坚持，但坚持不想要你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (941, '1', '间歇性洗心革面，持续性混吃等死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (942, '1', '间歇性踌躇满志，持续性混吃等死。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (943, '1', '假如生活欺骗了你，你就打开美颜相机，欺骗所有的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (944, '1', '假如生活欺骗了你，不要灰心，因为明天也一样', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (945, '1', '假如生活欺骗了你，不要悲伤不要心急，生活还将继续欺骗你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (946, '1', '假如生活出卖了你，希望是论斤卖，毕竟你比较肥。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (947, '1', '假期定了个Plan，半个暑假结束了只完成了P，因为lan。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (948, '1', '加我回来吧，我给你发我的婚礼请柬。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (949, '1', '既已背影倾天下，何必转身乱芳华。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (950, '1', '既没有让人一见钟情的颜，还缺少让人日久生情的钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (951, '1', '机会是留给有准备的人，没机会的人，就别瞎准备了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (952, '1', '机会，永远留给，有胸有颜的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (953, '1', '活了这么多年发现，唯一坚持下去的，就是每天给手机充电。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (954, '1', '活了这么多年，一直搞不明白一件事，拉钩为什么要上吊？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (955, '1', '混到现在，拿得起放得下的，只有筷子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (956, '1', '会有天使替我爱你，那我就去爱别人了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (957, '1', '毁灭友情的方式有许多，最彻底的一种是，借钱不还。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (958, '1', '回首过去，我居然没有，走过一次直路。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (959, '1', '灰姑娘的鞋若是合脚当初就不会掉，王子若是真的爱灰姑娘就不会连和自己跳了一晚上的舞的女孩都不认识。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (960, '1', '欢迎来到2019，恭喜你进入了新的，扎心的一年。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (961, '1', '化再好的妆，也盖不住你，卸妆后的丑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (962, '1', '胡思乱想能瘦身的话，我现在可能已经，只剩下灵魂了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (963, '1', '很久不开QQ，登录后才发现，原来只有腾讯新闻在乎你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (964, '1', '很多时候你不逼自己一把，你都不知道，你还有能把事情搞砸的本事！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (965, '1', '很多人觉得自己活得太累，实际上，他们可能只是睡得太晚。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (966, '1', '很多次我都觉得坚持不住了，然后我就放弃了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (967, '1', '黑夜给你黑色的眼睛，你却用它来翻白眼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (968, '1', '黑夜从来不会亏待晚睡的人，它会赐予你黑眼圈，和即将猝死的身体。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (969, '1', '和对象吵架，先不要追究吵架原因，要弄明白他胆子怎么肥了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (970, '1', '何以解忧，唯有暴富。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (971, '1', '好运一定会降临，只是会降临在别人头上。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (972, '1', '好想把房子卖了，去环游世界，可惜房东不同意。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (973, '1', '好人成佛，需要九九八十一难，坏人只需放下屠刀。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (974, '1', '好看的锁骨千篇一律，有趣的肚腩弹来弹去。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (975, '1', '好看的皮囊与你无关，有趣的灵魂你又没有。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (976, '1', '好看的皮囊现实劈腿，有趣的灵魂精神出轨?。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (977, '1', '好看的皮囊三千一晚，有趣的灵魂要车要房。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (978, '1', '好看的皮囊千篇一律，有趣的灵魂两百多斤。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (979, '1', '好看的皮囊你养不起，有趣的灵魂看不上你', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (980, '1', '好好过日子吧，每天都会有新打击。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (981, '1', '好不容易习惯了自己的长相，理了个发，又换了一种丑法。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (982, '1', '海底捞的服务是真心好，上次我吃饭没带钱，还是服务员帮我报的警。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (983, '1', '还想过五四青年节，六一儿童节？属于你的只剩下三八节了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (984, '1', '还没有对象？要不要给你介绍，一款不错的狗粮。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (985, '1', '还没来得及去沾花惹草，就被人拔光了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (986, '1', '过年哪个亲戚问我成绩，我就问他年终奖金。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (987, '1', '过年不吃胖，怎么对得起，死去的鸡鸭鱼猪？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (988, '1', '过马路不要带耳机，万一要是被车撞上，耳机不就坏了么？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (989, '1', '国庆去哪看风景最好？答案是，朋友圈。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (990, '1', '国庆你堵在哪呢?', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (991, '1', '贵不是iPhone的缺陷，穷是你的缺陷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (992, '1', '恭喜你又熬过一天，还中奖了，再来一天。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (993, '1', '工作爱情生活不顺？多照照镜子，很多事情你就明白了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (994, '1', '跟最好的朋友好到什么程度？他进传销，发展的第一个下线就是我。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (995, '1', '跟我比懒，你输定了，因为我都懒得跟你比。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (996, '1', '跟你谈钱的老板才是好人，跟你谈理想的，都TM不想给你钱！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (997, '1', '跟丑这个缺点比，穷根本不值得一提。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (998, '1', '根本没有什么高冷的人，人家暖的不是你而已！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (999, '1', '给你的梦想插上翅膀，虽然不一定飞得很远，但肯定摔得很重。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1000, '1', '给你的梦想插上翅膀，你也飞不到哪里去。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1001, '1', '高考失败不要紧，以后还有更多失败等着你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1002, '1', '感谢前行路上击倒我的人，因为，躺着真的好舒服。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1003, '1', '感情是可以磨合的，前提是，看脸。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1004, '1', '感觉这辈子，最深情绵长的注视，都给了手机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1005, '1', '该失望的事从没辜负过我，每次都认认真真的让我失望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1006, '1', '富人的丁克叫丁克，穷人的丁克叫断子绝孙。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1007, '1', '富豪们都在担心税太多，而你只会觉得睡不够！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1008, '1', '付出就会有回报，比如一倍的奢望，换两倍的失望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1009, '1', '风水轮流转确实不假，但你在轴心上，这就很尴尬了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1010, '1', '放心吧，只要你持续走下坡路，就永远不会处在人生最低谷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1011, '1', '放心吧 有钱人运气都不会太差的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1012, '1', '放下手机出去走走，最后你会发现，还是手机有意思。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1013, '1', '放弃这个字，说起来简单，做起来就更简单了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1014, '1', '放假买个地球仪吧，世界那么大你不但可以看看，还可以转转。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1015, '1', '凡是不赚钱的，都说自己在创业。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1016, '1', '发丝千万条 睡眠第一条，熬夜不休息 脱发两行泪。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1017, '1', '二十年前吃小浣熊，集不齐卡的傻孩子们，依然集不齐五福。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1018, '1', '俄罗斯方块教会我们：如果你合群，就会消失。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1019, '1', '俄罗斯方块教会了我们，如果你合群，就会消失。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1020, '1', '多照照镜子，很多事情你就明白原因了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1021, '1', '蹲下来摸摸自己的影子，对不起，跟着我让你受委屈了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1022, '1', '对于穷人，生活不累的话，那就不叫生活！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1023, '1', '对于丑的人来说，细看都是一种残忍。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1024, '1', '对象抢不过别人就算了，抢购也抢不过别人，这个光棍节你可咋办。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1025, '1', '对女人强吻表白一般会有两种结果，一种是啪，一种是啪啪啪。这就是屌丝和高富帅的差距。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1026, '1', '对你竖大拇指的人，不一定是在夸你，也可能是用炮在瞄你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1027, '1', '对你别有用心的人，毕竟也是用心了。 ???', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1028, '1', '都说谈恋爱会影响学习，难道学习，就不影响谈恋爱吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1029, '1', '都说钱是王八蛋，可长得真好看。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1030, '1', '都说男人有钱就变坏，TMD我都当了，三十多年的好人了！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1031, '1', '都说累成狗，其实狗没你那么累。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1032, '1', '都说姐漂亮，其实都是妆出来的', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1033, '1', '冬天就是好，穷的时候，还有西北风喝。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1034, '1', '冬天床以外的地方都是远方，手够不到的地方都是他乡，上个厕所都是出差。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1035, '1', '等你以后老了走不动了，我每天用轮椅推你去广场上，让你看着我和别的老头跳舞。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1036, '1', '等到历史考试的时候，历史将会被我改写！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1037, '1', '到不了的都叫做远方，回不去的名字叫家乡。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1038, '1', '当幸福来敲门的时候，我怕我不在家，所以一直都很宅。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1039, '1', '当咸鱼拥有了梦想，它就会成为，一只拥有梦想的咸鱼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1040, '1', '当失去工作动力的时候，就看看银行卡余额吧。之后你就会发现：工作根本没卵用。c', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1041, '1', '当生活压得你喘不过气，一定要挺直腰杆，这样被压死时才不难看。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1042, '1', '当年我背井离乡，乡里人从此再也没有，喝上一口井水。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1043, '1', '当你知道自己要去哪里的时候，全世界都在为你添堵。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1044, '1', '当你瘦下来之后，你会发现原来你的丑，跟减肥并没有关系。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1045, '1', '当你觉得自己不行的时候，就走马路上走走，这样你就是一个行人了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1046, '1', '当你觉得又丑又穷的时候，不要悲伤，至少你的判断还是正确的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1047, '1', '当你怀疑人生的时候，其实这就是你的人生。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1048, '1', '当你变得足够优秀的时候，你才发现原来她只是，单纯的不喜欢你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1049, '1', '当初有多感天动地，以后就有多万劫不复。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1050, '1', '当别人和你说忙，是TA要留时间，给更重要的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1051, '1', '单身至今的原因是，熟人不好下手，生人不好开口。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1052, '1', '单身脱发又没钱，跑步进入中老年。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1053, '1', '单身没有关系，以后单身的日子，还长着呢。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1054, '1', '带翅膀的不一定是天使，有可能是雷震子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1055, '1', '大学生啊你要知道，学习不一定能收获，但剁手一定能收货。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1056, '1', '大老远看到我一直盯着你时，不要觉得我对你有意思，我真得看不清你是谁。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1057, '1', '大家喜欢和你一起，是为了，显示他们的好看。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1058, '1', '大家都以为我没有朋友，事实上，我还真没有朋友。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1059, '1', '大家都夸我贤惠，闲的什么都不会。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1060, '1', '大多数时候，消耗能量的都不是工作，而是工作中遇到的人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1061, '1', '打麻将三缺一，斗地主二缺一，我谈个恋爱咋还一缺一？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1062, '1', '打工钱少就出来创业吧，保证能让你，赔个精光。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1063, '1', '存款是负的房子是租的，有辆自行车，还是共享的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1064, '1', '从小就喜欢自立，比如靠自己本事单的身。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1065, '1', '从小就被教育不要乱花钱，长大后我才发现，根本没钱怎么乱花？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1066, '1', '从小到大，唯一不变的，就是一颗不想念书的心。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1067, '1', '从今天开始，接受来自三大姑八大姨，灵魂的拷问。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1068, '1', '蠢也没那么可怕，毕竟水母没有脑子，也活了6亿年。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1069, '1', '蠢萌的前提是萌，不是蠢。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1070, '1', '春节你要小心了，毕竟过年，都是要杀猪的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1071, '1', '春节假期要结束了，该收收心，准备过五一了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1072, '1', '春节假期，从跳过早午餐开始。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1073, '1', '创业嘛就要有个平常心，因为它总是起起落落落落落落的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1074, '1', '传统文化丢失严重啊，古代女子个个能呤诗作对，现代女子不行了 只会作对。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1075, '1', '穿白色衣服上班，并不代表你可以不背黑锅。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1076, '1', '除了是处，一无是处。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1077, '1', '出身好的努力是为了成功，而你是为了活下去。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1078, '1', '出卖自己的灵魂和原则并不丢人，丢人的是没能卖一个好价钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1079, '1', '出卖灵魂并不丢人，丢人的是，没能卖一个好价钱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1080, '1', '出来混，迟早是要胖的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1081, '1', '丑小鸭能变天鹅，不是因为它多努力，是因为它爸妈本来就是天鹅。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1082, '1', '吃完苦中苦，我终于成为了人下人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1083, '1', '吃土的时候，觉得乞丐都比我幸福。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1084, '1', '吃货一般都比较善良，因为每天都只想着吃，没有时间去算计别人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1085, '1', '吃货的思路是，好吃你就多吃点，不好吃多少也要吃点。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1086, '1', '吃的苦中苦，才知白辛苦。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1087, '1', '吃得苦中苦，才知道没有最苦，只有更苦。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1088, '1', '承诺就像放屁，当时惊天动地，过后苍白无力。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1089, '1', '成长就是将你哭声调成静音的过程。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1090, '1', '成年人的世界，除了长胖，其他什么都不容易。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1091, '1', '成名就像放的一个屁，响了一声还不够，还要臭段时间。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1092, '1', '成功是可以复制的，而对于你，此处禁止粘贴。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1093, '1', '成功就像鬼一样，只有别人遇到过。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1094, '1', '趁着年轻多出来走走，不然你不会知道，呆在家里有多爽。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1095, '1', '趁好看的时候多照照镜子，毕竟，这种错觉不是每天都有的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1096, '1', '车到山前必有雾，船到桥头自然沉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1097, '1', '曾梦想仗剑走天涯，因太胖取消原计划。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1098, '1', '曾经我也是靠脸吃饭的，后来差点饿死了…', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1099, '1', '曾经我想做个特别的人，现在我成功了，我现在特别难过又无助。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1100, '1', '曾经是梦想家，现在没了梦，只剩下想家。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1101, '1', '曾经给我泼凉水的人，没关系的，我烧开了还会还给你的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1102, '1', '曾经的海枯石烂，抵不过好聚好散。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1103, '1', '不知道你越过多少峰才成功，反正你逃不过早晚两个高峰。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1104, '1', '不知道，是别人的爱情来的太容易，还是自己的八字太硬。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1105, '1', '不用在意别人怎么看你，你在意了，别人也看不上你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1106, '1', '不要总是那么自恋，美女多看了你一眼，只是因为你丑得比较独特。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1107, '1', '不要总对人掏心掏肺，有的人不吃内脏。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1108, '1', '不要在意现在的低谷，未来还有很长的下坡路要走。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1109, '1', '不要再抑郁下去了孩子，你要像一个，神经病一样活泼开朗。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1110, '1', '不要再说自己是一条单身狗，其实，你可能比不上狗…', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1111, '1', '不要再说被骗色了，到你这个年纪来的都是客。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1112, '1', '不要以为自己坚持不来，你一定会坚持熬夜玩手机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1113, '1', '不要以为世界抛弃了你，世界根本没空搭理你', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1114, '1', '不要以为老天在折磨你，而事实上，老天根本就不在意你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1115, '1', '不要太在乎别人的目光，因为没人会注意你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1116, '1', '不要说别人脑子有病，脑子有病的前提是，必须有个脑子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1117, '1', '不要认为你被世界丢弃，只是世界没空搭理你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1118, '1', '不要轻易向命运低头，因为，一低头就会看到赘肉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1119, '1', '不要轻易看不起谁，就算是杀马特，发量都比你多。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1120, '1', '不要期待明天，因为明天也不会好过。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1121, '1', '不要年纪轻轻，就觉得你已经到了低谷，你还有很大的下降空间。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1122, '1', '不要埋怨现在的经历凄惨，跟未来比，还差的远呢。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1123, '1', '不要老覺得自己孤單，看看肚子上那圈肥肉，不是從來沒有離開過嘛？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1124, '1', '不要放弃你的梦，继续睡！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1125, '1', '不要等明天交不上差，再找借口，今天就要找好。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1126, '1', '不要担心，一切都是最烂的安排。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1127, '1', '不要把自己放的太高了，不然你会不下来的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1128, '1', '不要把银行卡密码，设成女朋友的生日，不然总要换多麻烦。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1129, '1', '不笑运气差，一笑脸就大！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1130, '1', '不想养狗不想养猫，只想养你，毕竟养猪能致富。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1131, '1', '不想谈恋爱是假的，没人要是真的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1132, '1', '不想结婚生子，是我作为穷人的自觉。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1133, '1', '不为无益之事，何以遣有涯之生？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1134, '1', '不说没人陪你勇闯天涯，你能找到人陪你喝雪花吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1135, '1', '不是因为看到了希望才坚持，而是因为坚持了，才知道没希望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1136, '1', '不是路不平，而是你不行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1137, '1', '不是大家拿你开玩笑，而是，你就是玩笑本身！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1138, '1', '不是吃燕窝的人皮肤好，是吃得起燕窝的人皮肤好。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1139, '1', '不是别人瞧不起你，只是别人瞧不见你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1140, '1', '不能老盯着手机屏幕，要不时地抬起头，看看老板的位置。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1141, '1', '不明白你们遇到好事，为什么要掐腿揉眼睛，真醒了怎么办？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1142, '1', '不就是钱嘛，说得谁不缺似的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1143, '1', '不经历风雨，怎么迎接暴风雨。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1144, '1', '不回你消息，不是因为我高冷，而是因为我手冷。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1145, '1', '不管是白帽子，还是黑帽子，会变绿的都不是好帽子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1146, '1', '不当家不知柴米贵，不拍照不知自己肥。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1147, '1', '不尝试问一次，你怎么知道，你不是爸妈避孕失败的结果？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1148, '1', '不逼自己一把，你都不知道，什么叫绝望。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1149, '1', '冰冻三尺非一日之寒，小腹三层非一日之馋。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1150, '1', '冰冻三尺非一日之寒，掏空钱包却一点不难。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1151, '1', '别总自称单身狗了，按年龄你是单身鳖，按智商你是单身傻狍子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1152, '1', '别总是骂别人猪狗，你过的还不如它们。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1153, '1', '别再说自己是单身狗了，你这个年纪狗都死了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1154, '1', '别以为世界没了你，没什么区别，没了你地球转得更快。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1155, '1', '别以为你一无所有，至少你还有丑！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1156, '1', '别一天到晚想着减肥，你的嘴同意你这样想了吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1157, '1', '别问我有啥，先说你要啥，再说你凭啥。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1158, '1', '别问我失败了怎么办，说得好像你成功过一样。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1159, '1', '别太自信，你可能信错了人。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1160, '1', '别太晚睡，熬夜很伤手机的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1161, '1', '别说自己是单身狗，狗还可以三妻四妾。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1162, '1', '别说什么一见钟情，不过就是见色起意。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1163, '1', '别说你一无所长，熬夜玩手机你可是一把好手。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1164, '1', '别说你一无所有，你还有一身债。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1165, '1', '别人一看你就说你是学生，不是因为你看着年轻，而是因为穿的土！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1166, '1', '别人下班泡妞，你下班泡面。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1167, '1', '别人问你有谈恋爱吗？只要说现在没有，就能掩盖过去也没有的事实。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1168, '1', '别人是金子总会发光的，而你，总会花光的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1169, '1', '别人努力会成功，你努力会有饭吃。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1170, '1', '别人没回复，继续等，你会等到她的朋友圈。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1171, '1', '别人露腿那叫美，你露腿就想让人怼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1172, '1', '别人关心你飞得高不高，飞得累不累，而我只关心你翅膀好吃吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1173, '1', '别人复习看书，都是看着看着就看懂了，我是看着看着就看开了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1174, '1', '别人都有背景，而我只有背影。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1175, '1', '别人都用名牌包包，而你，只能用用表情包。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1176, '1', '别人都说我烂泥扶不上墙，可是我为什么要上墙，躺地上不舒服吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1177, '1', '别人都是为怎么挣钱而发愁，我却是为怎么花钱而发愁，二十块怎么能花到下月十号？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1178, '1', '别人都散发着恋爱的酸臭味，只有我，散发着单身狗独有的清香。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1179, '1', '别人的身体里都是才华，你的身体里都是珍珠奶茶。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1180, '1', '别人的人生有的是故事，而我，有的是事故。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1181, '1', '别人的钱财，乃我的身外之物。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1182, '1', '别人的起点，是你遥不可及的终点。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1183, '1', '别人的女朋友都会生气了，而你的女朋友还在充气。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1184, '1', '别人存你的号是为了跟你联系，我就不一样，我存你的号就是为了不接', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1185, '1', '别人比你有钱还比你努力，但你更厉害，靠自己的想象就拥有一切。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1186, '1', '别人扮猪吃老虎，你只能扮猪。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1187, '1', '别去打扰那些，每次很久都不回你消息的人，删除好友就行。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1188, '1', '别怕眼睛近视，因为在你的面前，除了失败什么也没有。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1189, '1', '别埋怨手机没怎么用就没电，你还不是一样，没干啥就累了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1190, '1', '别看我挣的少，但是我省的多，昨天法拉利又省下两百多万。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1191, '1', '别看我平时对你漠不关心，其实背后有说你好多坏话的。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1192, '1', '别看那些有钱人表面上风光，其实他们私底下更风光。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1193, '1', '别看别人表面上一帆风顺，实际上他们背地里，也是一帆风顺。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1194, '1', '别看别人表面上事事如意，其实他们背地里，也顺风顺水。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1195, '1', '别觉得身边的人都在针对你，仔细想想其实，整个世界的人都在针对你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1196, '1', '别减肥了，你丑不仅是因为胖。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1197, '1', '别灰心，漂亮姑娘和天上星星一样多，只是你看得见摸不着罢了。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1198, '1', '别慌去接受失败，要慢慢去感受。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1199, '1', '别和我说对不起，因为我既不能原谅你，也无法捅死你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1200, '1', '别动不动说把一切交给时间，时间才懒得收拾你的烂摊子。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1201, '1', '别低头绿帽会掉，别流泪老王会笑。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1202, '1', '别低头，双下巴会露。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1203, '1', '比一个人吃火锅更寂寞的是，一个人，没钱吃火锅。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1204, '1', '比你优秀的人还在努力，你努力有什么用呢？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1205, '1', '比尔盖茨休学创业，成为世界首富，可是人家休得是哈佛大学。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1206, '1', '本以为牵了小姐姐的手，可以得到她，没想到小姐姐是千手观音。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1207, '1', '饱汉不知饿汉饥，饿汉不知饱汉虚。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1208, '1', '半夜给你留灯的，只有自动售货机。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1209, '1', '白雪公主诠释了，七个小屌丝对她再好，也不及高富帅的一个吻。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1210, '1', '白天嘈杂得不愿意醒，夜晚安静得舍不得睡。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1211, '1', '把秋衣塞进秋裤，把秋裤塞进棉袜里，是对冬天最起码的尊重。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1212, '1', '把女孩子弄哭是很没种的事情，把男孩子弄哭是一件叼爆的事啊。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1213, '1', '熬夜对身体不好，建议通宵。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1214, '1', '暗恋就是你在心里，为他盖了一座城堡，他却连门都不想进。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1215, '1', '暗恋的人没有，想暗杀的倒有一堆。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1216, '1', '安慰别人的时候一套一套的，安慰自己的时候，只想找根绳子一套。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1217, '1', '爱真的需要勇气，来接受，一次次的没人爱。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1218, '1', '爱一个人一定要告诉她，那样你才会知道，她有多讨厌你。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1219, '1', '爱笑的女孩运气不会太差，但是运气差的女孩，还能笑得出来吗？', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1220, '1', '爱笑的姑娘，总是比别人，长更多的鱼尾纹。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1221, '1', '爱是一道光，绿到你发慌。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1222, '1', '爱情是把双刃剑，一边把你割得很疼，另一边也把你割得很疼。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1223, '1', '爱你不是两三天，而是，一天都没有爱过', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1224, '1', '爱迪生千百次寻觅灯丝，就是为让你，当上耐用的电灯泡。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1225, '1', '矮是什么感觉？明明想瞪人的，硬生生成了卖萌。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1226, '1', 'Follow your heart，翻译成中文就一个字，怂。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1227, '1', '56个民族，55个加分。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1228, '1', '38岁以前我穷，但是以后，我会习惯的！', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1229, '1', '2019年第一天，说出你的新年愿望，那就一定不会实现。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1230, '1', '2018年，88喽。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1231, '1', '18岁什么化妆品都不用，28岁什么化妆品都没用。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);
INSERT INTO `biz_content` VALUES (1232, '1', '你妹是个好姑娘，替你妈分担了很多。', NULL, NULL, '0', '0', '2', -1, '2019-12-03 17:49:09', '2019-12-03 17:49:09', -1, NULL, NULL);



--- 2019-12-04
INSERT INTO `MINIMALISM`.`biz_content`(`ID`, `TYPE`, `CONTENT_CN`, `CONTENT_EN`, `COMMIT_QQ`, `SHOW_QQ_STATE`, `SOURCE`, `CONFIRM_STATE`, `CONFIRM_USER`, `CONFIRM_TIME`, `CREATE_TIME`, `CREATE_BY`, `UPDATE_TIME`, `UPDATE_BY`) VALUES (1202074805071908864, '3', '🐳☀️，👴😴☠，🥚👶🍅🥦🐭👨🤴！！！', '', NULL, '0', '0', '2', -1, '2019-12-04 11:59:02', '2019-12-04 11:59:02', -1, '2019-12-04 11:59:02', -1);
INSERT INTO `MINIMALISM`.`biz_content`(`ID`, `TYPE`, `CONTENT_CN`, `CONTENT_EN`, `COMMIT_QQ`, `SHOW_QQ_STATE`, `SOURCE`, `CONFIRM_STATE`, `CONFIRM_USER`, `CONFIRM_TIME`, `CREATE_TIME`, `CREATE_BY`, `UPDATE_TIME`, `UPDATE_BY`) VALUES (1201762169394434048, '3', '开会死🐎脸，上班死🐎脸', '', NULL, '0', '0', '2', -1, '2019-12-03 15:16:44', '2019-12-03 15:16:44', -1, '2019-12-03 15:16:44', -1);


--- 2019-12-05
-- ----------------------------
-- Table structure for biz_confirm_log
-- ----------------------------
DROP TABLE IF EXISTS `biz_confirm_log`;
CREATE TABLE `biz_confirm_log`  (
  `ID` bigint(20) NOT NULL COMMENT 'ID',
  `CONTENT_ID` bigint(20) NOT NULL COMMENT '内容ID',
  `CONFIRM_USER` bigint(20) NOT NULL COMMENT '审核人',
  `CONFIRM_TIME` datetime(0) NOT NULL COMMENT '审核时间',
  `CONFIRM_STATE_ORIGIN` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核前状态',
  `CONFIRM_STATE_NEW` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核完成状态',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;


--- 2019-16-06
ALTER TABLE `MINIMALISM`.`sys_user`
MODIFY COLUMN `USERNAME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名' AFTER `ID`,
ADD COLUMN `PHONE` varchar(15) NULL COMMENT '手机号' AFTER `NICKNAME`;


UPDATE `MINIMALISM`.`sys_permission` SET `HREF` = 'pages/sys-user/systemUserList.html' WHERE `ID` = 4010;
