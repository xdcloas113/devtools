package tools.make.restapi.tool;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ws.rs.Path;
import javax.ws.rs.Produces;

//import cn.netmoon.framework.annotation.FieldDesc;
import org.aspectj.util.FileUtil;
import org.springframework.core.LocalVariableTableParameterNameDiscoverer;

import com.alibaba.fastjson.JSONObject;



public class RestApiGeneratorTool {
    private String projectName = "sydw";
    private String ramlPath = "C:\\Users\\huangjifei\\git\\jwzh-api\\sydwapi-temp.raml" ;
    private String jsonPath = "d:/\"+projectName+\"/";
    private String baseUrl = "http://sydw.jwzh.com:9015/jwzh-sydw";
    private String title = projectName.toUpperCase() + "API";
    private String examplePath = "!include examples/"+projectName+"/";
    
    public RestApiGeneratorTool(String projectName, String ramlPath,
			String jsonPath, String baseUrl) {
		super();
		this.projectName = projectName;
		this.ramlPath = ramlPath;
		this.jsonPath = jsonPath;
		this.baseUrl = baseUrl;
	}
	/**
     * 
     * @Title: generate
     * @Description: (入口)
     * @param @param beanAry：要产生的VO及Bean数组
     * @param @param resAry ：rest service 数组
     * @return void    返回类型
     * @throws
     */
    public void generate(String[] beanAry,String[] resAry) {
        try{
            //write header
            writeRamlHeader();
            //generate entity bean desc
            generateBeanFieldAnnotation(beanAry);
            generatePersonalMethodDesc(resAry);


        }catch(Exception e){
            e.printStackTrace();
        }
    }
    //header
    private void writeRamlHeader() {
        StringBuilder sb = new StringBuilder();
        sb.append("#%RAML 0.8");
        sb.append("\n").append("title: " + title);
        sb.append("\n").append("version: 1.0.0");
        sb.append("\n").append("mediaType: application/json");
        sb.append("\n").append("baseUri: " + baseUrl);
        sb.append("\n").append("traits:");
        sb.append("\n\r");
        //System.out.println(sb.toString());
        writeFile(sb.toString(),ramlPath );
    }
    private void generateBeanFieldAnnotation(String[] clsAry){
        for( String cls :clsAry){
            try {
                generateBeanFieldAnnotation(Class.forName(cls).newInstance());

            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (InstantiationException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }
    private void generatePersonalMethodDesc(String[] resAry){
    	for(Object obj: resAry){
    		try {
				generatePersonalMethodDesc(Class.forName(obj.toString()).newInstance());
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
    	}
    }
    /**
     * @param obj
     */
    //methods
    private void generatePersonalMethodDesc(Object obj){
        StringBuilder sb = new StringBuilder();
        Annotation[] clsAnno = obj.getClass().getAnnotations();
        String clsPath = "";
        String clsDesc = "";
        String[] produces = null;
        for(Annotation an:clsAnno){
            if(an == null ){
                continue;
            }else{
                if(an.toString().contains("Path")){
                    clsPath = ((Path)an).value();
                }
                if(an.toString().contains("Produces")){
                    produces = ((Produces)an).value();
                }
                if(an.toString().contains("PersonalClassDesc")){
                    clsDesc = ((PersonalClassDesc)an).value();
                }
            }
        }
        sb.append("\n").append( clsPath + ":");
        sb.append("\n").append("  displayName: "  + clsDesc);
        sb.append("\n").append("  description: " + clsDesc);
        Method[] methods = obj.getClass().getDeclaredMethods();
        for (Method method : methods) {
            String methodPath = null;
            String personalMethodDesc = "";
            String httpType = null;
            Annotation[] ans = method.getDeclaredAnnotations();
            for(Annotation one : ans){
                if(one.toString().contains("PersonalMethodDesc")){
                    personalMethodDesc = ((PersonalMethodDesc)one).value();
                }
                if(one.toString().contains("Path")){
                    methodPath = ((Path)one).value();
                }
                if(one.toString().contains("POST")){
                    httpType = "post";
                }
                if(one.toString().contains("GET")){
                    httpType = "get";
                }
            }
            if(methodPath == null) continue;
            sb.append("\n").append( "  " + methodPath + ":");
            sb.append("\n").append("    displayName: " + personalMethodDesc );
            sb.append("\n").append("    description: " + personalMethodDesc );
            sb.append("\n").append("    " + httpType.toLowerCase() + ":");
            //参数
            try {
                getParameters(method, obj,sb);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            String responseType = method.getReturnType().getName();
            String finalResType = determineSystemType(responseType);

            sb.append("\n").append("      responses:");
            sb.append("\n").append("        200:");
            sb.append("\n").append("          description: ");
            sb.append("\n").append("          body:");
            sb.append("\n").append("            application/json: ");
            if(finalResType != null)
                sb.append("\n").append("              description: 返回数据类型为[").append(finalResType).append("]");
            else
                sb.append("\n").append("              description: 返回数据类型为[").append(responseType).append("]的json数据");
            sb.append("\n").append("              example: "+ examplePath +obj.getClass().getSimpleName()+ "/api_"+ method.getName() + ".json" );

            //generate return json file exapmle
            generateReturnJson(obj,method.getReturnType(),"api_"+ method.getName() + ".json");
        }
        sb.append("\n\r");
        //System.out.println(sb.toString());
        writeFile(sb.toString(),ramlPath );
    }
    //返回值得json 格式
    private void generateReturnJson(Object obj2, Class<?> returnType, String fielName) {
        Object obj = null;
        try {
            if(returnType.getName().contains("int")){
                obj = new Integer(0);
            }else
            if(returnType.getName().contains("List")){
                obj = new ArrayList();
            }else
            if(returnType.getName().contains("Map")){
                obj = new HashMap();
            }else if(returnType.getName().contains("boolean")||returnType.getName().contains("Boolean")){
                obj = new Boolean(false);
            }else if(returnType.getName().contains("void")){
                obj = "";
            }else{
                obj = Class.forName(returnType.getName()).newInstance();
            }

        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String reqjson = JSONObject.toJSONString(obj);
        File file = new File( jsonPath +obj2.getClass().getSimpleName() +"/"+fielName);
        FileUtil.writeAsString(file, reqjson);

    }
    //fields
    private static void getParameters(Method method,Object obj, StringBuilder sb) throws Exception{
        Class<?>[] cls = method.getParameterTypes();

        String variableName;
        if(method.getParameterTypes().length > 0)
            sb.append("\n").append("      queryParameters:" );
        else return;
        LocalVariableTableParameterNameDiscoverer variableDiscover = new LocalVariableTableParameterNameDiscoverer();
        String[] paramNames = variableDiscover.getParameterNames(method);
        for (int i=0;i<paramNames.length;i++){

            variableName = paramNames[i];
            sb.append("\n").append("        " + variableName +  ":");
            String type = cls[i].getName().toLowerCase();
            type = type.substring(type.lastIndexOf(".") + 1);
            String tempType = determineSystemType(type);

            sb.append("\n").append("          description: "  + cls[i].getName());
            sb.append("\n").append("          required: false"  );

            if(tempType != null ) {
                sb.append("\n").append("          type: " + tempType);
                if(tempType.equals("number")){
                    sb.append("\n").append("          example: \"0 \"");
                }else
                    sb.append("\n").append("          example: \"").append(tempType).append(" \"");
            }
            else{
                sb.append("\n").append("          example: \"type is {").append(type).append("}\"");
            }
        }
    }

    /**
      * @param type
     * @return
     */
    private static String determineSystemType(String type){
        type = type.toLowerCase();
        if(type.contains("long")) return  "number";
        if(type.contains("string")) return "string";
        if(type.contains("integer")) return  "number";
        if(type.contains("number")) return  "number";
        if(type.contains("short")) return  "number";
        if(type.contains("double")) return  "number";
        if(type.contains("long")) return  "number";
        if(type.contains("boolean")) return  "number";
        System.out.println("type = " + type);
        //非基本数据类型，则返回null
        return null;
    }
      
    //Field annontaiton
    private void generateBeanFieldAnnotation( Object obj){
        StringBuilder sb = new StringBuilder();
        sb.append("  - " + obj.getClass().getSimpleName() + ":");
        sb.append("\n").append("     queryParameters:");
        Field[] fields = obj.getClass().getDeclaredFields();
        for (Field field : fields) {
            //Field field = clazz.getDeclaredField("id");
            //FieldDesc myFieldAnnotation = field.getAnnotation(FieldDesc.class);
           // if(myFieldAnnotation == null) continue;
            sb.append("\n").append("       " + field.getName() + ":");
            //sb.append("\n").append("         description: " + myFieldAnnotation.value());
            String type = field.getType().getSimpleName().toLowerCase();
            type = type.substring(type.lastIndexOf(".") + 1);
            if(type.contains("long")) type = "number";
            if(type.contains("EasyUIPage".toLowerCase())
                    || ( type.contains("SysXtcsGlobal".toLowerCase())
            )){
                //sb.append("\n").append("         type: ");
                sb.append("\n").append("         example: \"" + field.getType().getSimpleName() + " \"");
            }else{
                sb.append("\n").append("         type: " + type);
                if(type.equals("number"))
                    sb.append("\n").append("         example: 0");
                else
                    sb.append("\n").append("         example: \" \"");
            }
        }
        sb.append("\n\r");
        //System.out.println(sb.toString());
        writeFile(sb.toString(),ramlPath );
    }
    private static void writeFile(String content, String filePath){
        File file = null;
        FileOutputStream fileWritter = null;
        try{
            file =new File(filePath);
            if(!file.exists()){
                file.createNewFile();
            }
            //true = append file
            fileWritter = new FileOutputStream(file,true);
            boolean bool = file.canWrite();
            fileWritter.write(content.getBytes());
            fileWritter.flush();
            fileWritter.close();
            System.out.println("Done: " +filePath);

        }catch(IOException e){
            e.printStackTrace();
        }finally{
        }
    }
    public static void main(String[] args) {
    	 String projectName = "sydw";
	     String ramlPath = "C:\\Users\\huangjifei\\git\\jwzh-api\\sydwapi-temp.raml" ;
	     String jsonPath = "d:/\"+projectName+\"/";
	     String baseUrl = "http://sydw.jwzh.com:9015/jwzh-sydw";
	     RestApiGeneratorTool generator = new RestApiGeneratorTool(projectName,ramlPath,jsonPath,baseUrl);
	     //beans
	     String[] beanAry ={
                 "com.founder.sydwgl.base.model.SswhSscqxxb",
                 "com.founder.sydwgl.base.model.SydwBzxxb",
                 "com.founder.sydwgl.base.model.SydwCyryxxb",
                 "com.founder.sydwgl.base.model.SydwDwdzb",
                 "com.founder.sydwgl.base.model.SydwDwjbxxb",
                 "com.founder.sydwgl.base.model.SydwGgylcsxxb",
                 "com.founder.sydwgl.base.model.SydwJwryxxb",
                 "com.founder.sydwgl.base.model.SydwJyxswfwxxb",
                 "com.founder.sydwgl.base.model.SydwLdxxb",
                 "com.founder.sydwgl.base.model.SydwNbdw",
                 "com.founder.sydwgl.base.model.SydwPcsxxb",
                 "com.founder.sydwgl.base.model.SydwQczl",
                 "com.founder.sydwgl.base.model.SydwRcjcxxb",
                 "com.founder.sydwgl.base.model.SydwSwsbdw",
                 "com.founder.sydwgl.base.model.SydwSzqyjyry",
                 "com.founder.sydwgl.base.model.SydwWbzlscs"
         };
         // services
         String[] resAry ={
                 "com.founder.sydwgl.ws.resource.CyryGlResource",
                 "com.founder.sydwgl.ws.resource.GlxxResource",
                 "com.founder.sydwgl.ws.resource.SydwComboboxResource",
                 "com.founder.sydwgl.ws.resource.SydwGlResource",
                 "com.founder.sydwgl.ws.resource.SzqyjyryResource"
         };
	     generator.generate(beanAry, resAry);
    }
}
