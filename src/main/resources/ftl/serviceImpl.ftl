package ${parentPackageName}.service.impl;

import ${parentPackageName}.service.${entityName}Service;
import ${parentPackageName}.dao.${entityName}Mapper;
import ${pojo}.${entityName};
import ${pojo}.${entityName}Criteria;

import com.alibaba.fastjson.JSON;
import com.excel.utils.json.ExtLimit;
import com.excel.utils.json.JsonUtil;
import com.excel.utils.status.FinalJson;
import com.excel.utils.json.Info;

import lombok.extern.apachecommons.CommonsLog;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
* @program: gifm-sub
* @description: 自动生成, 待用户编辑 //TODO:描述待补充
* @author: 兰芷不芳，荃蕙为茅
* @create: ${.now}
**/
@CommonsLog
@Service
//@Transactional
public class ${entityName}ServiceImpl implements ${entityName}Service {

    @Resource
    private ${entityName}Mapper ${entityName?uncap_first}Mapper;

    @Override
    public JsonUtil selectPage(int page, int rows, Map<String, Object> map,JsonUtil jsonUtil) {
        ${entityName}Criteria criteriaObj = new ${entityName}Criteria();
        ${entityName}Criteria.Criteria criteria= criteriaObj.createCriteria();
        map.forEach((k,v)->{
        try {
            Field pd =${entityName}.class.getDeclaredField(k);
            Class<?> type = pd.getType();
            Method beanMethod ;
            if(type == String.class){
                beanMethod = criteria.getClass().getMethod("and"+ k+"Like",type);
                beanMethod.invoke(criteria,"%"+v+"%");
            }else{
                beanMethod = criteria.getClass().getMethod("and"+ k+"EqualTo",type);
                beanMethod.invoke(criteria,v);
            }
        } catch (NoSuchFieldException e) {
        e.printStackTrace();
        } catch (NoSuchMethodException e) {
        e.printStackTrace();
        } catch (IllegalAccessException e) {
        e.printStackTrace();
        } catch (InvocationTargetException e) {
        e.printStackTrace();
        }
        });
        criteriaObj.setPageIndex(page);
        criteriaObj.setPageSize(rows);
        ExtLimit e = jsonUtil.getExtlimit();
        if(!e.getSort().equals("string")){
            criteriaObj.setOrderByClause(e.getDir()+"   "+e.getSort());
        }

        int total = (int) ${entityName?uncap_first}Mapper.countByExample(criteriaObj);
        List<${entityName}> lst = ${entityName?uncap_first}Mapper.getPage(criteriaObj);
        Info info = new Info();
        ExtLimit extLimit = new ExtLimit();
        if(total > 0){
            jsonUtil.setData(lst);
            extLimit.setCount(total);
            info.setStatus(FinalJson.STATUS_OK);
            info.setMessage("请求成功");
            jsonUtil.setExtlimit(extLimit);
            jsonUtil.setInfo(info);
        }else {
            jsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            jsonUtil.getInfo().setMessage("请求失败");
        }
        return jsonUtil;
    }

    @Override
    public int removeByID(String id) {

        <#if nameOfClass("${entityName}.id") == "String">
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(id);
        <#else>
        //int id = obj.getId(); //非字符串的,自增或其他方式
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(id);
        </#if>
    }

    @Override
    public int removeByIDs(Set<String> ids) {
        //TODO:
        return 0;
    }

    @Override
    public int save(${entityName} obj) {

        <#if nameOfClass("${entityName}.id") == "String">
        String id = UUID.randomUUID().toString();
        obj.setId(id);
        <#else>
        //int id = obj.getId(); //非字符串的,自增或其他方式
        </#if>
        ${entityName?uncap_first}Mapper.insert(obj);
        return 1;
    }

    @Override
    public int updateByID(${entityName} obj) {
        return ${entityName?uncap_first}Mapper.updateByPrimaryKeySelective(obj);
    }

    @Override
    public ${entityName} getById(String id) {
    <#if nameOfClass("${entityName}.id") == "String">
        return ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
    <#else>
        //int id = obj.getId(); //非字符串的//TODO:需要确认
        return ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
    </#if>
    }

    //暂时没写需要自己条件controlle
    @Override
    public JsonUtil getMany(JsonUtil jsonUtil) {
        JsonUtil jUBean = JSON.parseObject(JSON.toJSONString(jsonUtil),JsonUtil.class);
        Map<String,Object> beanmap = (Map) jUBean.getData();
        Info info = new Info();
        if(beanmap == null){
            info.setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            info.setMessage("请求失败");
            jsonUtil.setInfo(info);
            return jsonUtil;
        }
        List<${entityName}>  ${entityName?uncap_first} = ${entityName?uncap_first}Mapper.selectByExample(new ${entityName}Criteria());
        jsonUtil.setData (${entityName?uncap_first}!= null && !${entityName?uncap_first}.isEmpty() ? ${entityName?uncap_first} : "");
        info.setMessage(${entityName?uncap_first}!= null && !${entityName?uncap_first}.isEmpty() ? "请求成功" : "请求失败");
        info.setStatus(${entityName?uncap_first}!= null && !${entityName?uncap_first}.isEmpty() ? FinalJson.STATUS_OK : FinalJson.STATUS_NOTACCEPTABLE );
        return jsonUtil;
    }
}
