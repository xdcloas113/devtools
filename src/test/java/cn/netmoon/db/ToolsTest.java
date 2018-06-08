package cn.netmoon.db;

import com.netmoon.db.Tools;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
    public void testCreateService() throws Exception {
        String filePath = "c:/workflow";//生成的文件目录
        String parentPackageName = "com.test.oo";//包名:model,sqlmap及dao的上级包名
        Tools tool=new Tools(parentPackageName,filePath);
        String[] tablenames = {
        		"slow_log"
        };
        for(String tablename : tablenames){
            tool.create(tablename);
            //tool.doModel();
            //tool.doValid();
            //tool.doDao();
            tool.doService();
            tool.doServiceImpl();
            //tool.doSqlmap();
        }
    }
}
