package tools.make.db;

import tools.make.util.connection.ConnectionFactory;
import tools.make.util.connection.DbType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public enum DbUtil {

	INSTANCE;

	private Logger log = LoggerFactory.getLogger(DbUtil.class);

	private Connection con ;

	private ConnSqlTemplate connSqlTemplate ;

	DbUtil() {
		try {
			con = ConnectionFactory.INSTANCE.getDatabaseConnection();

			if (ConnectionFactory.INSTANCE.getDriverName().equals(DbType.Mysql)){
				connSqlTemplate = new Mysql_ConnSqlTemplate();
			}else if(ConnectionFactory.INSTANCE.getDriverName().equals(DbType.Oracle)){
				connSqlTemplate = new Oracle_ConnSqlTemplate();
			}else if (ConnectionFactory.INSTANCE.getDriverName().equals(DbType.SqlServer)) {
				connSqlTemplate = new SqlServer_ConnSqlTemplate();
			}else if(ConnectionFactory.INSTANCE.getDriverName().equals(DbType.Undefined)){
				connSqlTemplate = null;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Map<String, Object>> exeute(String sql){
		List<Map<String, Object>> list=new LinkedList();
		try {
			ResultSet rs = con.createStatement().executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();

			while(rs.next()){
				Map<String, Object> map=new HashMap();
				for (int i=1; i<=columnCount; i++){
					map.put(rsmd.getColumnLabel(i),rs.getObject(i));
				}
				list.add(map);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {

			return list;
		}
	}

	public String getOracleKeyColumn(String tableName){
		String sql = connSqlTemplate.getKeyColumnSql(tableName);
		log.debug("\n{}",sql);
		List<Map<String, Object>> list = exeute(sql);
		String pk ="";
		if (!list.isEmpty()) {
			 pk = list.get(0).get("COLUMN_NAME").toString();
			 Tools.columnType = list.get(0).get("JDBC_TYPE").toString();
		}
//		log.debug("\n{}",pk);
		return pk;
	}
	
	public String getOracleTableComments(String tableName){
		String sql = connSqlTemplate.getTableComments(tableName);
		log.debug("\n{}","comments sql: " + sql);
		List<Map<String, Object>> list = exeute(sql);
		String comments = null;
		String dataType = null;
		//todo 稀巴烂这里
		try{
			comments = list.get(0).get("TABLE_COMMENT").toString();
			dataType ="Mysql";
		}catch (Exception e){
			log.debug("不是Mysql");
		}
		try{
			comments = list.get(0).get("TABLE_NAME").toString();
			dataType = "SqlServer";
		}catch (Exception e){
			log.debug("不是SqlServer");
		}
		if (dataType.contains("Mysql")  ) {
			comments =list.get(0).get("TABLE_COMMENT").toString();
		}else if (dataType.contains( "SqlServer") ) {
			comments = list.get(0).get("TABLE_NAME").toString();
		}
//		log.debug("\n{}",pk);
		return comments;
	}
	
	public List<Map<String, Object>> queryColumes(String TableName){
		String sql= connSqlTemplate.queryColumesSql(TableName);

		log.debug("\n{}",sql);
		try{
			List<Map<String, Object>> list = exeute(sql);
			return list;

		}catch(Exception e){
			e.printStackTrace();
		}


		return null;
	}

	public void closeConn(){
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
