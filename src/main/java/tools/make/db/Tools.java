package tools.make.db;

import tools.make.freemarker.GetClsNameTMM;
import tools.make.util.connection.ClassPathUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Tools {

    private static Logger log = LoggerFactory.getLogger(Tools.class);

    private String tableName = null;//数据库表名
    private String entityName = null;//生成的业务实体（java bean）名
    private String paramName = null;//生成的业务实体（java bean）参数名
    private String parentPackageName = null;//"com.founder";//包名:model,sqlmap及dao的上级包名
    private String filePath = null;//"E:/tiger/tiegrWs/jwzh-syfw/web_base/src/main/java";//生成的文件目录
//    public String filePath = "I:/MyGit/jwzh-syfw/web_base/src/main/java";//生成的文件目录
    private String pojo; //实体的位置 再Properties 里面读取的 xml.pojoPackage=a.pojo

    private String pk = null;
    private String comments = null;

    public static String columnType =null; //主键类型

    public static Map<String, String> db2JavaMap;//映射为public可配置

    private static Configuration configuration = null;
    private static Map<String, Template> allTemplates = null;
    Map<String,Object> ftlmap = new HashMap();

    static {

        db2JavaMap = new HashMap();
        db2JavaMap.put("VARCHAR2", "String");
        db2JavaMap.put("varchar", "String");
        db2JavaMap.put("int", "java.lang.Integer");
        db2JavaMap.put("DATE", "java.util.Date");
        db2JavaMap.put("TIMESTAMP", "java.util.Date");
        db2JavaMap.put("NUMBER", "int");
        db2JavaMap.put("BLOB", "byte[]");
        //mysql
        db2JavaMap.put("tinyint", "Boolean");
        db2JavaMap.put("datetime", "java.util.Date");
        //decimal(20,2)
        db2JavaMap.put("decimal", "java.math.BigDecimal");

        configuration = new Configuration(Configuration.VERSION_2_3_23);
        configuration.setDefaultEncoding("utf-8");
        try {
            System.out.println(ClassPathUtil.getClassesPath(Tools.class) + "/ftl/");
            configuration.setDirectoryForTemplateLoading(new File(
                ClassPathUtil.getClassesPath(Tools.class) + "/ftl/"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        allTemplates = new HashMap();
        try {
            allTemplates.put("model", configuration.getTemplate("model.ftl"));
            allTemplates.put("controller", configuration.getTemplate("controller.ftl"));
            allTemplates.put("service", configuration.getTemplate("service.ftl"));
            allTemplates.put("serviceImpl", configuration.getTemplate("serviceImpl.ftl"));
            allTemplates.put("dao", configuration.getTemplate("dao.ftl"));
            allTemplates.put("sqlmap", configuration.getTemplate("sqlmap.ftl"));
//            allTemplates.put("validate", configuration.getTemplate("valid.ftl"));
            allTemplates.put("qwjs", configuration.getTemplate("qwjs.ftl"));
//            allTemplates.put("add", configuration.getTemplate("add.ftl"));
//            allTemplates.put("edit", configuration.getTemplate("edit.ftl"));
//            allTemplates.put("view", configuration.getTemplate("view.ftl"));
//            allTemplates.put("pojo", configuration.getTemplate("pojo.ftl"));
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public Tools(String parentPackageName, String filePath) {
        this.filePath = filePath;
        this.parentPackageName = parentPackageName;
    }

    public Tools(String parentPackageName, String filePath,String pojo) {
        this.filePath = filePath;
        this.parentPackageName = parentPackageName;
        this.pojo = pojo;
    }

    public void create(String name) {
        tableName = name;
        String[] names = name.split("_");
        name = "";
        for(String n:names){
            n = toUpperCaseFirstOne(n.toLowerCase());
            name += n;
        }
        entityName = name;
        paramName = name;
        pk = DbUtil.INSTANCE.getOracleKeyColumn(tableName);
        comments = DbUtil.INSTANCE.getOracleTableComments(tableName);

        ftlmap.put("parentPackageName",parentPackageName);
        ftlmap.put("pojo",pojo);//实体位置
        ftlmap.put("entityName",entityName);//实体名称
        ftlmap.put("tableName",tableName);//表名
        ftlmap.put("columnType",columnType);//主键类型
        ftlmap.put("comments",comments);
        ftlmap.put("paramName",paramName);
        ftlmap.put("pk",pk);
        List<Map<String, Object>> columes = DbUtil.INSTANCE.queryColumes(tableName);
        ftlmap.put("columus",columes);
        ftlmap.put("db2JavaMap",db2JavaMap);
        ftlmap.put("transformString",new TransformStringTemplateMethodModel());
        ftlmap.put("buildMethodSuffixString",new BuildMethodSuffixName());
        ftlmap.put("nameOfClass", new GetClsNameTMM());
    }

    //首字母转小写
    private static String toLowerCaseFirstOne(String s) {
        if (Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
    }

    //首字母转大写
    private static String toUpperCaseFirstOne(String s) {
        if (Character.isUpperCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
    }

    private String createFile(Map<?, ?> dataMap, String packageName) {

        String path = this.filePath + "/" + parentPackageName.replace(".", "/") + "/" + packageName;

        String fileName;

        if(packageName.equals("sqlmap")){
            fileName = entityName  + ".xml";
        }else if(packageName.equals("model")){
            fileName = entityName + ".java";
        }else if(packageName.equals("validate")){
            fileName = entityName+"Valid" + ".java";
        }else if(packageName.equals("qwjs")){
            fileName = entityName + ".txt";
        }else if(packageName.equals("service")){
            fileName = entityName + toUpperCaseFirstOne(packageName) + ".java";
        }else if(packageName.equals("serviceImpl")){
            fileName = entityName + toUpperCaseFirstOne(packageName) + ".java";
            path = path.replace("serviceImpl","service/impl");
        }else if(packageName.equals("controller")){
            fileName = entityName + "Controller.java";
        }else if(packageName.equals("add")){
            fileName = entityName + "Add.jsp";
        }else if(packageName.equals("edit")){
            fileName = entityName + "Edit.jsp";
        }else if(packageName.equals("view")){
            fileName = entityName + "view.jsp";
        }else if(packageName.equals("pojo")){
            fileName = entityName + "pojo.jsp";
        }

        else{
            fileName = entityName + toUpperCaseFirstOne(packageName) + ".java";
        }

        path = path.replace("//", "/").trim();

        File dir = new File(path);
        log.info(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        File file = new File(path + "/" + fileName);

        Template t = allTemplates.get(packageName);
        try {
            Writer w = new OutputStreamWriter(new FileOutputStream(file), "utf-8");
            t.process(dataMap, w);
            w.flush();
            w.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }

        return path;
    }
    
    private String createFile(Map<?, ?> dataMap, String packageName,String fileName) {

        String path = this.filePath + "/" + parentPackageName.replace(".", "/") + "/" + packageName;

        path = path.replace("//", "/").trim();

        File dir = new File(path);
        log.info(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        File file = new File(path + "/" + fileName);

        Template t = allTemplates.get(packageName);
        try {
            t.process(dataMap, this.getWriter(file));        
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }

        return path;
    }
    
    private Writer qwjsWriter = null;
    private Writer getWriter(File file) throws Exception{
    	if(qwjsWriter==null)
    		qwjsWriter = new OutputStreamWriter(new FileOutputStream(file), "utf-8");   
    	return qwjsWriter;
    }
    public Writer getWriter() throws Exception{
    	return qwjsWriter;
    }

    public void doModel () {
        createFile(ftlmap,"model");
    }
    public void doValid () {
        createFile(ftlmap,"validate");
    }

    public void doService () {
        createFile(ftlmap,"service");
    }

    public void doServiceImpl () {
        createFile(ftlmap,"serviceImpl");
    }

    public void doDao () {
        createFile(ftlmap,"dao");
    }

    public void doSqlmap () {
        createFile(ftlmap,"sqlmap");
    }
    
    public void doQwjs(String fileName){
    	createFile(ftlmap,"qwjs",fileName);
    }

    public void doController () {
        createFile(ftlmap,"controller");
    }


    public void doAdd () {
        createJspFile(ftlmap,"add");
    }

    public void doEdit () {
        createJspFile(ftlmap,"edit");
    }

    public void doView () {
        createJspFile(ftlmap,"view");
    }
    public void dopojo () {
        createJspFile(ftlmap,"pojo");
    }


    private String createJspFile(Map<?, ?> dataMap, String packageName) {

        String path = this.filePath + "/" + parentPackageName.replace(".", "/") + "/" + entityName;

        String fileName;

        if(packageName.equals("add")){
            fileName =  "add.jsp";
        }else if(packageName.equals("edit")){
            fileName =  "edit.jsp";
        }else if(packageName.equals("view")){
            fileName =  "view.jsp";
        }else if(packageName.equals("pojo")){
            fileName =  "pojo.jsp";
        }else {
            fileName =  "err.jsp";
        }


        path = path.replace("//", "/").trim();

        File dir = new File(path);
        log.info(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        File file = new File(path + "/" + fileName);

        Template t = allTemplates.get(packageName);
        try {
            Writer w = new OutputStreamWriter(new FileOutputStream(file), "utf-8");
            t.process(dataMap, w);
            w.flush();
            w.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        }

        return path;
    }

}
