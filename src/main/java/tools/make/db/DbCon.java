package tools.make.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class DbCon {
	
	
	private String dbUrl;
	private String dbUser;
	private String dbPwd;
	private String tableName;
	
	public DbCon(String dbUrl,String dbUser,String dbPwd,String tableName){
		this.dbUrl=dbUrl;
		this.dbUser=dbUser;
		this.dbPwd=dbPwd;
		this.tableName=tableName;
	}
	
	//通过  数据库  类型 来获取 相应的驱动
	private Map getParameters() {
		HashMap<String, Object> Parms = new HashMap<String, Object>();
		
		String databaseType = this.dbUrl.split(":")[1];
		String driverName = "";	//储存驱动  全限定名称
		String queryAllCols = "";	//查询 表 所有列  对应的sql
		
		Parms.put("databaseType", databaseType);	//通过  数据库  类型
		
		if("oracle".equals(databaseType)){//ORCLE
			driverName = "oracle.jdbc.OracleDriver";
			
			queryAllCols = "select a.COLUMN_NAME ,a.DATA_TYPE,b.COMMENTS from user_tab_columns a left join user_col_comments b on( "
					+ "b.TABLE_NAME=a.TABLE_NAME and b.COLUMN_NAME=a.COLUMN_NAME) where a.TABLE_NAME='"+tableName+"'";
		}
		else if("mysql".equals(databaseType)){//Mysql
			driverName = "com.mysql.jdbc.Driver";
			queryAllCols = "select COLUMN_NAME from information_schema.columns where table_name='" + tableName+ "'";
		}
		else if ("sqlserver".equals(databaseType)) {
			driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
			queryAllCols = "select COLUMN_NAME from information_schema.columns where table_name=''"+ tableName+ "'";
		}
		
		Parms.put("driverName", driverName);
		Parms.put("queryAllCols", queryAllCols);
		
		return Parms;  
	}
	
	
	private Connection getCon(){
		try{
			Class.forName(getParameters().get("driverName").toString());
			Connection con = DriverManager.getConnection(dbUrl , dbUser , dbPwd ) ; 
			return con;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Map<String, Object>> query(){
		String sql=getParameters().get("queryAllCols").toString();
		try{
			Connection con=this.getCon();
			Statement stmt = con.createStatement() ;
			ResultSet rs = stmt.executeQuery(sql) ;   
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();   
			List<Map<String, Object>> list=new LinkedList<Map<String, Object>>();			
			while(rs.next()){   
				Map<String, Object> map=new HashMap<String, Object>();
				for (int i=1; i<=columnCount; i++){   					
					map.put(rsmd.getColumnName(i),rs.getObject(i));								       
			    }   		
				list.add(map);
				
		     }
			stmt.close();
			con.close();
			return list;

		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return null;
	}

}
