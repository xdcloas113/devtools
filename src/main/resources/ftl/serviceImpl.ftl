package ${parentPackageName}.service.impl;

import com.yqy.midend.orgperm.common.StringFirst;

import ${parentPackageName}.service.${entityName}Service;
import ${parentPackageName}.dao.${entityName}Mapper;
import ${pojo}.${entityName};
import ${pojo}.${entityName}Criteria;
import com.yqy.midend.orgperm.state.FinalJson;
import com.yqy.midend.orgperm.util.json.ExtLimit;
import com.yqy.midend.orgperm.util.json.JsonUtil;
import lombok.extern.apachecommons.CommonsLog;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashSet;
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
        <#--Map<String, Object> map = (Map<String, Object>) BeanUtils.toMap(infoQuery);-->

        <#--int pageSize = (page - 1) * rows;-->
        //Subject currentUser = SecurityUtils.getSubject();
        //SysUser user = (SysUser) currentUser.getPrincipal();
        ${entityName}Criteria criteriaObj = new ${entityName}Criteria();
        ${entityName}Criteria.Criteria criteria= criteriaObj.createCriteria();
        map.forEach((k,v)->{
        try {
            Field pd =${entityName}.class.getDeclaredField(k);
            Class<?> type = pd.getType();
            Method beanMethod ;
            if(type == String.class){
                beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(k)+"Like",type);
                beanMethod.invoke(criteria,"%"+v+"%");
            }else{
                beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(k)+"EqualTo",type);
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
            criteriaObj.setOrderByClause(e.getSort()+"  "+e.getDir());
        }

        int total = (int) ${entityName?uncap_first}Mapper.countByExample(criteriaObj);
        List<${entityName}> lst = ${entityName?uncap_first}Mapper.getPage(criteriaObj);
        if(total > 0){
            jsonUtil.setData(lst);
            jsonUtil.getExtlimit().setCount(total);
            jsonUtil.getInfo().setStatus(FinalJson.STATUS_OK);
            jsonUtil.getInfo().setMessage("请求成功");
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
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(Integer.parseInt(id.trim()));
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
        return ${entityName?uncap_first}Mapper.selectByPrimaryKey(Integer.parseInt(id.trim()));
    </#if>
    }

    @Override
    public List<${entityName}> getMany() {
        return ${entityName?uncap_first}Mapper.selectByExample(new ${entityName}Criteria());
    }
}
