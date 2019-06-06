package ${parentPackageName}.service.impl;

import ${parentPackageName}.service.${entityName}Service;
import ${parentPackageName}.dao.${entityName}Mapper;
import ${pojo}.${entityName};
import ${pojo}.${entityName}Criteria;

import ${parentPackageName}.utils.StringFirst;
import ${parentPackageName}.utils.commonJson.ExtLimit;
import ${parentPackageName}.utils.commonJson.ComJsonUtil;
import ${parentPackageName}.utils.commonJson.FinalJson;
import ${parentPackageName}.utils.commonJson.Rules;


import lombok.extern.apachecommons.CommonsLog;
import org.springframework.stereotype.Service;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.collections.CollectionUtils;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

/**
* @program: gifm-bak
* @description: 自动生成, 待用户编辑 //TODO:描述待补充
* @author: xdc
* @create: ${.now}
**/
@CommonsLog
@Service
//@Transactional
public class ${entityName}ServiceImpl implements ${entityName}Service {

    @Resource
    private ${entityName}Mapper ${entityName?uncap_first}Mapper;

    /**
    * 获取分页数据
    */
    @Override
    public ComJsonUtil selectPage(Map<String, Object> map,ComJsonUtil comJsonUtil) {
        ${entityName}Criteria criteriaObj = new ${entityName}Criteria();
        ${entityName}Criteria.Criteria criteria= criteriaObj.createCriteria();

        if(CollectionUtils.isNotEmpty(comJsonUtil.getRules())){
            List<Rules> rules = comJsonUtil.getRules();
            rules.forEach(x ->{
                String fielName = x.getField();
                String op = x.getOp();
                op = StringFirst.firstCharUp(op);
                Object query = x.getData();
                Field field = null;
                    try {
                            field = ${entityName}.class.getDeclaredField(fielName);
                            Class<?> type = field.getType();
                            Method beanMethod = null;
                            List  InList = null;
                            if("In".equals(op) || "NotIn".equals(op)){
                                beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(fielName)+op,type);
                                String[] strings = StringUtils.split(query.toString(), ",");
                                    if(type ==Integer.class){
                                        InList =  new LinkedList<Integer>();
                                        for (int i = 0; i < strings.length; i++) {
                                            InList.add(Integer.valueOf(strings[i]));
                                        }
                                    }else if(type == Date.class){
                                        InList =  new LinkedList<Date>();
                                        for (int i = 0; i < strings.length; i++) {
                                            InList.add(new Date(strings[i]));
                                        }
                                    }else if(type == LocalDateTime.class){
                                        InList =  new LinkedList<LocalDateTime>();
                                        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                        for (int i = 0; i < strings.length; i++) {
                                            InList.add(LocalDateTime.parse(strings[i],df));
                                        }
                                    }else if(type == BigDecimal.class){
                                        InList =  new LinkedList<BigDecimal>();
                                        for (int i = 0; i < strings.length; i++) {
                                            InList.add(new BigDecimal(strings[i]));
                                        }
                                    }else{
                                        InList =  new LinkedList<String>();
                                        for (int i = 0; i < strings.length; i++) {
                                            InList.add(strings[i]);
                                        }
                                    }
                                    beanMethod.invoke(criteria,InList);
                            }else if("Between".equals(op) || "NotBetween".equals(op)){
                                beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(fielName)+op,type);
                                String[] strings = StringUtils.split(query.toString(), ",");
                                if(type ==Integer.class){
                                    beanMethod.invoke(criteria,Integer.valueOf(strings[0]),Integer.valueOf(strings[1]));
                                }else if(type == Date.class){
                                    beanMethod.invoke(criteria,new Date(strings[0]),new Date(strings[1]));
                                }else if(type == LocalDateTime.class){
                                    DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                    beanMethod.invoke(criteria,LocalDateTime.parse(strings[0],df),LocalDateTime.parse(strings[1],df));
                                }else if(type == BigDecimal.class){
                                    beanMethod.invoke(criteria,new BigDecimal(strings[0]),new BigDecimal(strings[1]));
                                }else{
                                    beanMethod.invoke(criteria,strings[0],strings[1]);
                                }
                            }else{
                                beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(fielName)+op,type);
                                if("Like".equals(op) || "NotLike".equals(op)){
                                    beanMethod.invoke(criteria,"%"+query+"%");
                                }else{
                                    beanMethod.invoke(criteria,query);
                                }
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
        }
        if(map != null){
            map.forEach((k,v)->{
                try {
                    Field pd = ${entityName}.class.getDeclaredField(k);
                    Class<?> type = pd.getType();
                    Method beanMethod ;
                    beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(k)+"EqualTo",type);
                    beanMethod.invoke(criteria,v);
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
        }
            ExtLimit e = comJsonUtil.getExtlimit();
            criteriaObj.setPageIndex(e.getPageindex());
            criteriaObj.setPageSize(e.getPagesize());
            if(e.getSort() != null){
            if(!e.getSort().equals("string")){
                criteriaObj.setOrderByClause(e.getSort()+"  "+e.getDir());
            }
        }
        int total = (int) ${entityName?uncap_first}Mapper.countByExample(criteriaObj);

        if(total > 0){
            List<${entityName}> lst = ${entityName?uncap_first}Mapper.getPage(criteriaObj);
            comJsonUtil.setData(lst);
            comJsonUtil.getExtlimit().setCount(total);
            comJsonUtil.getInfo().setStatus(FinalJson.STATUS_OK);
            comJsonUtil.getInfo().setMessage("请求成功");
        }else {
            comJsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            comJsonUtil.getInfo().setMessage("请求失败");
        }
        return comJsonUtil;
    }

    /**
    * 查询所有
    **/
    @Override
    public ComJsonUtil selectAll(ComJsonUtil ComJsonUtil) {
        ${entityName}Criteria criteriaObj = new ${entityName}Criteria();
        ${entityName}Criteria.Criteria criteria= criteriaObj.createCriteria();
        if(CollectionUtils.isNotEmpty(ComJsonUtil.getRules())){
        List<Rules> rules = ComJsonUtil.getRules();
            rules.forEach(x ->{
                String fielName = x.getField();
                String op = x.getOp();
                op = StringFirst.firstCharUp(op);
                Object query = x.getData();
                Field field = null;
                try {
                    field = ${entityName}.class.getDeclaredField(fielName);
                    Class<?> type = field.getType();
                    Method beanMethod = null;
                    List  InList = null;
                        if("In".equals(op) || "NotIn".equals(op)){
                            beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(fielName)+op,type);
                            String[] strings = StringUtils.split(query.toString(), ",");
                            if(type ==Integer.class){
                                InList =  new LinkedList<Integer>();
                                for (int i = 0; i < strings.length; i++) {
                                    InList.add(Integer.valueOf(strings[i]));
                                }
                            }else if(type == Date.class){
                                InList =  new LinkedList<Date>();
                                for (int i = 0; i < strings.length; i++) {
                                    InList.add(new Date(strings[i]));
                                }
                            }else if(type == LocalDateTime.class){
                                InList =  new LinkedList<LocalDateTime>();
                                DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                for (int i = 0; i < strings.length; i++) {
                                    InList.add(LocalDateTime.parse(strings[i],df));
                                }
                            }else if(type == BigDecimal.class){
                                InList =  new LinkedList<BigDecimal>();
                                for (int i = 0; i < strings.length; i++) {
                                    InList.add(new BigDecimal(strings[i]));
                                }
                            }else{
                                InList =  new LinkedList<String>();
                                for (int i = 0; i < strings.length; i++) {
                                    InList.add(strings[i]);
                                }
                            }
                            beanMethod.invoke(criteria,InList);
                        }else if("Between".equals(op) || "NotBetween".equals(op)){
                            beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(fielName)+op,type);
                            String[] strings = StringUtils.split(query.toString(), ",");
                            if(type ==Integer.class){
                                beanMethod.invoke(criteria,Integer.valueOf(strings[0]),Integer.valueOf(strings[1]));
                            }else if(type == Date.class){
                                beanMethod.invoke(criteria,new Date(strings[0]),new Date(strings[1]));
                            }else if(type == LocalDateTime.class){
                                DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                beanMethod.invoke(criteria,LocalDateTime.parse(strings[0],df),LocalDateTime.parse(strings[1],df));
                            }else if(type == BigDecimal.class){
                            beanMethod.invoke(criteria,new BigDecimal(strings[0]),new BigDecimal(strings[1]));
                            }else{
                                beanMethod.invoke(criteria,strings[0],strings[1]);
                            }
                        }else{
                            beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(fielName)+op,type);
                            if("Like".equals(op) || "NotLike".equals(op)){
                            beanMethod.invoke(criteria,"%"+query+"%");
                            }else{
                                beanMethod.invoke(criteria,query);
                            }
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
        }
        Map<String,Object> map = (Map)ComJsonUtil.getData();
        if(map != null){
            map.forEach((k,v)->{
                try {
                        Field pd =${entityName}.class.getDeclaredField(k);
                        Class<?> type = pd.getType();
                        Method beanMethod ;
                        beanMethod = criteria.getClass().getMethod("and"+ StringFirst.firstCharUp(k)+"EqualTo",type);
                        beanMethod.invoke(criteria,v);

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
        }
        ExtLimit e = ComJsonUtil.getExtlimit();
        if(e != null){
            if(e.getSort() != null){
                if(!e.getSort().equals("string")){
                    criteriaObj.setOrderByClause(e.getSort()+"  "+e.getDir());
                }
            }
        }
        int total = (int) ${entityName?uncap_first}Mapper.countByExample(criteriaObj);
        if(total > 0){
        List<${entityName}> lst = ${entityName?uncap_first}Mapper.selectByExample(criteriaObj);
            ComJsonUtil.setData(lst);
            ComJsonUtil.getExtlimit().setCount(total);
            ComJsonUtil.getInfo().setStatus(FinalJson.STATUS_OK);
            ComJsonUtil.getInfo().setMessage("请求成功");
        }else {
            ComJsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            ComJsonUtil.getInfo().setMessage("请求失败");
        }
        return ComJsonUtil;
    }

    /**
    * 根据主键删除
    **/
    @Override
    public int removeByID(Integer id) {
        <#if nameOfClass("${entityName}.id") == "String">
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(id);
        <#elseif nameOfClass("${entityName}.id") == "Long">
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(Long.parseLong(id+""));
        <#elseif nameOfClass("${entityName}.id") == "int">
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(id);
        </#if>
    }

    /**
    *  根据主键批量删除
    **/
    @Override
    public int removeByIDs(Set<String> ids) {
        ${entityName} ${entityName?uncap_first} = new ${entityName}();
        ${entityName}Criteria criteriaObj = new ${entityName}Criteria();
        ${entityName}Criteria.Criteria criteria= criteriaObj.createCriteria();
        criteria.andIdIn(new ArrayList(ids));
        return ${entityName?uncap_first}Mapper.deleteByExample(criteriaObj);
    }

    /**
    * 新增一条数据
    **/
    @Override
    public int save(${entityName} obj) {
        <#if nameOfClass("${entityName}.id") == "Long">
        String id = UUID.randomUUID().toString();
        obj.setId(id);
        <#else>
        //int id = obj.getId(); //非字符串的,自增或其他方式
        </#if>
         return  ${entityName?uncap_first}Mapper.insertSelective(obj);
    }

    /**
    * 修改数据
    **/
    @Override
    public int updateByID(${entityName} obj) {
        return ${entityName?uncap_first}Mapper.updateByPrimaryKeySelective(obj);
    }

    /**
    * 主键查询一条数据
    **/
    @Override
    public ${entityName} getById(Integer id) {
    <#if nameOfClass("${entityName}.id") == "String">
        return ${entityName?uncap_first}Mapper.selectByPrimaryKey(id+"");
    <#elseif nameOfClass("${entityName}.id") == "Long">
        return ${entityName?uncap_first}Mapper.selectByPrimaryKey(Long.parseLong(id+""));
    <#elseif nameOfClass("${entityName}.id") == "int">
        return ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
    </#if>
    }


    /**
    * 获取所有数据
    **/
    @Override
    public List<${entityName}> getMany() {
        return ${entityName?uncap_first}Mapper.selectByExample(new ${entityName}Criteria());
    }
}
