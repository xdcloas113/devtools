ALTER TABLE school MODIFY COLUMN name varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '姓名' ;
ALTER TABLE school MODIFY COLUMN `type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '类型' ;
ALTER TABLE school MODIFY COLUMN logo varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'logo' ;
ALTER TABLE school MODIFY COLUMN status tinyint(4) DEFAULT 2 NULL COMMENT '状态' ;
ALTER TABLE school MODIFY COLUMN admin_id int(11) NULL COMMENT '管理员ＩＤ' ;


