package tools.make.db;

import com.alibaba.druid.sql.SQLUtils;

/**
 * Package: com.founder.db
 * ClassName: ConnSqlTemplate
 * Author: he_hu@founder.com.cn
 * Description:
 * CreateDate: 2016-04-15
 * Version: 1.0
 */
public class Mysql_ConnSqlTemplate implements ConnSqlTemplate{

    public String getKeyColumnSql(String tableName){
        return SQLUtils.formatMySql(
//                "SELECT k.COLUMN_NAME\n" +
//                "\n" +
//                " FROM information_schema.table_constraints t\n" +
//                "\n" +
//                " JOIN information_schema.key_column_usage k\n" +
//                "\n" +
//                " USING (constraint_name,table_schema,table_name)\n" +
//                "\n" +
//                " WHERE t.constraint_type='PRIMARY KEY'\n" +
////                "\n" +
////                "  AND t.table_schema='test'\n" +
//                "\n" +
//                "  AND t.table_name='"+tableName+"'",
                "SELECT a.column_Name AS COLUMN_NAME  , a.data_type JDBC_TYPE\n" +
                        "FROM information_schema.COLUMNS  a  \n" +
                        "LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS p ON a.table_schema = p.table_schema AND a.table_name = p.TABLE_NAME AND a.COLUMN_NAME = p.COLUMN_NAME AND p.constraint_name='PRIMARY'  \n" +
                        "WHERE a.table_schema = (SELECT k.constraint_schema\n" +
                        "FROM information_schema.table_constraints t\n" +
                        "\tJOIN information_schema.key_column_usage k USING (constraint_name, table_schema, table_name)\n" +
                        "WHERE t.constraint_type = 'PRIMARY KEY'\n" +
                        "\tAND t.table_name = '"+tableName+"') AND a.table_name = '"+tableName+"'\n" +
                        "\tAND a.column_Name = (SELECT k.COLUMN_NAME\n" +
                        "\t\tFROM information_schema.table_constraints t\n" +
                        "\tJOIN information_schema.key_column_usage k\n" +
                        "\t\tUSING (constraint_name,table_schema,table_name)\n" +
                        "              WHERE t.constraint_type='PRIMARY KEY'\n" +
                        "               AND t.table_name='"+tableName+"')\n" +
                        "ORDER BY a.ordinal_position  ",
                SQLUtils.DEFAULT_FORMAT_OPTION);
    }

    public String queryColumesSql(String tableName){
        return SQLUtils.formatMySql(
                "select  COLUMN_NAME,DATA_TYPE,COLUMN_COMMENT AS COMMENTS from information_schema.COLUMNS\n" +
//                "\n" +
//                "where TABLE_SCHEMA='test'\n" +
                "\n" +
//                "and TABLE_NAME='"+tableName+"'",
                "where TABLE_NAME='"+tableName+"'",
                SQLUtils.DEFAULT_FORMAT_OPTION);
    }

    /**
     * select * from TABLES where TABLE_SCHEMA='my_db' and TABLE_NAME= 'auth_user';
     * @param tableName
     * @return
     */
    public String getTableComments(String tableName) {
        return SQLUtils.formatMySql("" +
                "select * from information_schema.TABLES where  TABLE_NAME='" + tableName + "'",
//                "select * from information_schema.TABLES where TABLE_SCHEMA='test' and TABLE_NAME='" + tableName + "'",
            SQLUtils.DEFAULT_FORMAT_OPTION);

    }

}
