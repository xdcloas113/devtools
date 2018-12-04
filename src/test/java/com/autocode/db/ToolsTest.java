package com.autocode.db;

import com.monkey.db.Tools;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
        ResourceBundle bundle = ResourceBundle.getBundle("resources");
        String target_package = bundle.getString("target.package");
        String target_java_project = bundle.getString("target.java.project");

        String filePath = target_java_project;//生成的文件目录
        String parentPackageName = target_package;//包名:model,sqlmap及dao的上级包名
        Tools tool=new Tools(parentPackageName,filePath);
        String[] tablenames = {
                "sys_notice",
//                "bk_file","bk_page_item"
//                "bk_employee","bk_employee_org"
//                "cr_device_data","cm_order","dev_base","sso_trace","sys_annex","sys_annex_type",
//                "cr_device","bk_tenant","bk_role",
//        		"bk_dict","bk_dict_mgmt","bk_menu","bk_operate","bk_org"
//                ,"bk_org_role","bk_perm_file","bk_perm_menu","bk_perm_oper","bk_perm_sysfunction"
//                ,"bk_perm_page","bk_privelege","bk_role_resource","bk_sub_system","bk_sys_settings"
//                ,"bk_user_device","bk_user_info","bk_user_org","bk_user_recom","bk_usr_role","cm_partner"
//                ,"dev_compressor","dev_lathe","dev_robot","sso_audit","sso_audit_log","sso_phone",
//                "sso_platform","sso_security","sso_user","sso_user_email"
        };
        for(String tablename : tablenames){
            tool.create(tablename);
//            tool.doModel();
            //tool.doValid();
//            tool.doDao();
//            tool.doService();
//            tool.doServiceImpl();
            tool.doSqlmap();
//            tool.doController();
        }
    }



    @Test
    public void testCreateWebapp() throws Exception {
        ResourceBundle bundle = ResourceBundle.getBundle("resources");
        String target_package = bundle.getString("target.package");
        String target_java_project = bundle.getString("target.java.project");

        String filePath = target_java_project;//生成的文件目录
        String parentPackageName = target_package;//包名:model,sqlmap及dao的上级包名
        Tools tool=new Tools(parentPackageName,filePath);
        String[] tablenames = {
                "sys_notice",
//                "bk_file","bk_page_item"
//                "cr_device","bk_tenant","bk_role",
//        		"bk_dict","bk_dict_mgmt","bk_file","bk_menu","bk_operate","bk_org"
//                ,"bk_org_role","bk_page_item","bk_perm_file","bk_perm_menu","bk_perm_oper"
//                ,"bk_perm_page","bk_privelege","bk_role_resource","bk_sub_system","bk_sys_settings"
//                ,"bk_user_device","bk_user_info","bk_user_org","bk_user_recom","bk_usr_role","cm_partner"
//                ,"dev_compressor","dev_lathe","dev_robot","sso_audit","sso_audit_log","sso_phone",
//                "sso_platform","sso_security","sso_user","sso_user_email"
        };
        for(String tablename : tablenames){
            tool.create(tablename);
//            tool.doController();
//            tool.doAdd();
//            tool.doEdit();
//            tool.doView();
            tool.dopojo();
        }
    }




}
