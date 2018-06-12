package ${parentPackageName}.service.impl;
import com.scmofit.gifm.common.BeanUtils;
import com.scmofit.gifm.common.EasyUIPage;
import ${parentPackageName}.service.${entityName}Service;
import ${parentPackageName}.dao.${entityName}Mapper;
import ${parentPackageName}.entities.${entityName};
import ${parentPackageName}.entities.${entityName}Criteria;
import org.springframework.stereotype.Service;
import lombok.extern.apachecommons.CommonsLog;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

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
    public EasyUIPage selectPage(int page, int rows, ${entityName} fundQuery) {
        Map<String, Object> map = (Map<String, Object>) BeanUtils.toMap(fundQuery);
        int pageSize = (page - 1) * rows;
        //Subject currentUser = SecurityUtils.getSubject();
        //SysUser user = (SysUser) currentUser.getPrincipal();
        ${entityName}Criteria criteriaObj = new ${entityName}Criteria();
        ${entityName}Criteria.Criteria criteria= criteriaObj.createCriteria();
        criteria.andBktIdIsNull();
        criteriaObj.setPageIndex(page);
        criteriaObj.setPageSize(rows);
        List<${entityName}> lst = ${entityName?uncap_first}Mapper.getPage(criteriaObj);
        EasyUIPage easyUIPage = new EasyUIPage();
        int total = (int) ${entityName?uncap_first}Mapper.countByExample(criteriaObj);
        easyUIPage.setTotal(total);
        if (total > 0) {
            easyUIPage.setRows(lst);
        }
        return easyUIPage;
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
