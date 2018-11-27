package com.autocode.db;

import com.monkey.db.DbUtil;
import junit.framework.TestCase;
import junit.framework.TestResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Package: com.netmoon.db
 * ClassName: DbConTest
 * Author: he_hu@netmoon.com.cn
 * Description:
 * CreateDate: 2016/4/14
 * Version: 1.0
 */
public class DbConTest extends TestCase {
    private static Logger log = LoggerFactory.getLogger(DbConTest.class);



    @Override
    public TestResult run() {
        return super.run();
    }

    //@Test
    public void testGetKeyColumn() throws Exception {
//        String pk = DbUtil.INSTANCE.getOracleKeyColumn("sys_user");
//        assertEquals("ZPID",pk);
//        System.out.println("11");
    }

    //@Test
    public void testQuery() throws Exception {
       // List<Map<String,Object>> list = DbUtil.INSTANCE.queryColumes("SYFW_FWZPB");
        //log.debug("");
    }
}
