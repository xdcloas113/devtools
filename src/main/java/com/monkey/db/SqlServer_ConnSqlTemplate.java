package com.monkey.db;

import com.alibaba.druid.sql.SQLUtils;



public class SqlServer_ConnSqlTemplate implements ConnSqlTemplate{

    public String getKeyColumnSql(String tableName){
        return SQLUtils.formatSQLServer(
                "select  b.name COLUMN_NAME\n" +
                        "\n" +
                        " from sysobjects a inner join syscolumns b\n" +
                        "\n" +
                        " on a.id=b.id and a.xtype='U'\n" +
                        "\n" +
                        " inner join systypes c\n" +
                        "on b.xtype=c.xusertype\n" +
                        " WHERE a.name='"+tableName+"'");
    }

    public String queryColumesSql(String tableName){
//        return SQLUtils.formatSQLServer(
//                "SELECT     COLUMN_NAME = a.name, DATA_TYPE = b.name,  COMMENTS = isnull(g.[value],'')\n" +
//                        "FROM    syscolumns a\n" +
//                        "left join    systypes  b  on    a.xusertype=b.xusertype\n" +
//                        "inner join  sysobjects d on  a.id=d.id  and d.xtype='U' and  d.name<>'dtproperties'\n" +
//                        "left join sys.extended_properties   g  on a.id=G.major_id and a.colid=g.minor_id  \n" +
//                        "where \n" +
//                        "    d.name='"+ tableName +"'\n" +
//                        "order by \n" +
//                        "    a.id,a.colorder");
        return SQLUtils.formatSQLServer(
                "select  b.name COLUMN_NAME, c.name DATA_TYPE ,g.value COMMENTS\n" +
                        "\n" +
                        " from sysobjects a inner join syscolumns b\n" +
                        "\n" +
                        " on a.id=b.id and a.xtype='U'\n" +
                        "inner join \n" +
                        "sys.extended_properties   g \n" +
                        "on \n" +
                        " a.id=g.major_id \n" +
                        " inner join systypes c\n" +
                        "on b.xtype=c.xusertype\n" +
                        " WHERE a.name='"+tableName+"'");
    }

    /**
     * select * from TABLES where TABLE_SCHEMA='my_db' and TABLE_NAME= 'auth_user';
     * @param tableName
     * @return
     */
    public String getTableComments(String tableName) {
        return SQLUtils.formatSQLServer(
                "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='" + tableName + "'") ;

    }

}
