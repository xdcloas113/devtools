package com.autocode.db;

import com.monkey.db.Tools;

/**
 * Package: com.netmoon.db
 * ClassName: ToolsTest
 * Author: he_hu@netmoon.com.cn
 * Description:
 * CreateDate: 2016/4/15
 * Version: 1.0
 */
public class QwjsTest {

   // @Test
    public void testCreateService() throws Exception {
        String filePath = "D:/db2file";//生成的文件目录
        String parentPackageName = "";//包名:model,sqlmap及dao的上级包名
        Tools tool=new Tools(parentPackageName,filePath);
        String[] tablenames = {
        		"SYDW_FRFZRLLRB"
        };
        for(String tablename : tablenames){
        	tool.create(tablename);
            tool.doQwjs("sydw.txt");
        }
        tool.getWriter().flush();
        tool.getWriter().close();
    }
}
