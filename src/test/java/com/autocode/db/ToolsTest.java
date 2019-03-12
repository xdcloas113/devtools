package com.autocode.db;

import tools.make.db.Tools;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Arrays;
import java.util.ResourceBundle;

/**
 * Package: com.netmoon.db
 * ClassName: ToolsTest
 * Author: he_hu@netmoon.com.cn
 * Description:
 * CreateDate: 2016/4/15
 * Version: 1.0
 */
public class ToolsTest {
    private static Logger log = LoggerFactory.getLogger(ToolsTest.class);

    @Test
    public void testCreateProject() throws Exception {
        //读取配置properties 文件里面的东西
        ResourceBundle bundle = ResourceBundle.getBundle("resources");
        String target_package = bundle.getString("target.package");
        String target_java_project = bundle.getString("target.java.project");
        String pojo=bundle.getString("xml.pojoPackage");

        String filePath = target_java_project;//生成的文件目录
        String parentPackageName = target_package;//包名:model,sqlmap及dao的上级包名
        Tools tool=new Tools(parentPackageName,filePath,pojo);

        //需要生成的表名
        String[] tablenames = {
                "BDA_QY_T_O_ZXQYJSMD"
//                "BDA_QY_T_S_SBQY",
//                "BDA_QY_T_O_ZXQYCZMD"
//                "BDA_ZBJJ_T_F_ZBQYMD"
//                "BDA_ZBJJ_T_S_QYSJ",
//                "BDA_ZBJJ_T_S_LYSJ",
//                "sso_user",
        };
        Arrays.stream(tablenames).forEach(s -> {
            tool.create(s);
            tool.doController();
            tool.doService();
            tool.doServiceImpl();
            //读取ftp 实体 分页实体 ，dao  还xml 没写
//            tool.doModel();
//            tool.doValid();
//            tool.doDao();
//            tool.doSqlmap();
        });
//        for(String tablename : tablenames){
//            tool.create(tablename);
//            tool.doController();
//            tool.doService();
//            tool.doServiceImpl();
            //读取ftp 实体 分页实体 ，dao  还xml 没写
//            tool.doModel();
//            tool.doValid();
//            tool.doDao();
//            tool.doSqlmap();
        }
    }


//    @Test
//    public void testCreateWebapp() throws Exception {
//        ResourceBundle bundle = ResourceBundle.getBundle("resources");
//        String target_package = bundle.getString("target.package");
//        String target_java_project = bundle.getString("target.java.project");
//
//        String filePath = target_java_project;//生成的文件目录
//        String parentPackageName = target_package;//包名:model,sqlmap及dao的上级包名
//        Tools tool=new Tools(parentPackageName,filePath);
//        String[] tablenames = {
//                "sso_user",
////                "bk_file","bk_page_item"
////                "cr_device","bk_tenant","bk_role",
////        		"bk_dict","bk_dict_mgmt","bk_file","bk_menu","bk_operate","bk_org"
////                ,"bk_org_role","bk_page_item","bk_perm_file","bk_perm_menu","bk_perm_oper"
////                ,"bk_perm_page","bk_privelege","bk_role_resource","bk_sub_system","bk_sys_settings"
////                ,"bk_user_device","bk_user_info","bk_user_org","bk_user_recom","bk_usr_role","cm_partner"
////                ,"dev_compressor","dev_lathe","dev_robot","sso_audit","sso_audit_log","sso_phone",
////                "sso_platform","sso_security","sso_user","sso_user_email"
//        };
//        for(String tablename : tablenames){
//            tool.create(tablename);
////            tool.doController();
////            tool.doAdd();
////            tool.doEdit();
////            tool.doView();
//
//            tool.dopojo();
//        }
//    }


