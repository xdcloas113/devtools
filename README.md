# 运行环境
    开发环境:IDEA 2017.2.6
    JDK: 1.8
#功能说明
    1. 默认该包下的工具主要用于将数据库的表生成常用的javabean、sql和dao，但因数据库兼容问题，实现较复杂，故
    改造后用于生成service、serviceImpl 以及controller， 以简化工作量，更专注于业务生成.
	2. 使用Mybatis-Generator插件来生成常用的javabean、sql(xml)和dao(mapper)，实现请使用tools.java来生成
#一.修改/src/main/resources/resources.properties:	

## 1.配置数据库(目前支持默认MYSQL,SqlServer,Oracle)
    //mysql
    jdbc.driverClassName=com.mysql.jdbc.Driver
    jdbc.url=jdbc:mysql://localhost:3306/test?useSSL=false&?useUnicode=true&characterEncoding=utf8
    jdbc.username=root
    jdbc.password=root
 
 ## 2.配置文件路径
      //生成代码的写入路径
      target.java.project=d:/mybati/project/src/java/java
      //包路径
      target.package=com.scmofit.gifm.system
      
## 3.配置需要生成的数据库表集
     //修改src/test/java/com/autocode/db/ToolsTest,可配置多个数据库表
     String[] tablenames = { "slow_log","..."  };     
     //运行junit测试,执行testCreateProject()方法的测试
     
     
# 二. 生成常用的javabean、sql(xml)和dao(mapper)
    1. 打开Maven Projects, 打开Plugins, 打开mybatis-generator工具
    2. 选中mybatis-generator:generate, 又单击运行
    
# 三. 打开target.java.project所设定的目录,查看生成的代码
    