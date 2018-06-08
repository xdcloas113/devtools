package ${parentPackageName}.service.impl;
import com.scmofit.gifm.common.BeanUtils;
import com.scmofit.gifm.common.EasyUIPage;
import ${parentPackageName}.service.${entityName}Service;
import ${parentPackageName}.system.model.dao.${entityName}Mapper;
import c${parentPackageName}.system.model.entities.${entityName};
import ${parentPackageName}.system.model.entities.${entityName}Criteria;
import org.springframework.stereotype.Service;
import lombok.extern.apachecommons.CommonsLog;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
* @program: gifm-sub
* @description:
* @author: KaiFaBu008
* @create: 2018-05-15 11:40
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
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(id);
    }

    @Override
    public int removeByIDs(Set<String> ids) {
        //TODO:
        return 0;
    }

    @Override
    public int save(${entityName} obj) {
        String id = obj.getId();
        if(obj.getDeleted() == null){
            obj.setDeleted((short) 0);
        }

        id = UUID.randomUUID().toString();
        obj.setId(id);
        ${entityName?uncap_first}Mapper.insert(obj);

        return 1;
    }

    @Override
    public int updateByID(${entityName} obj) {
        return ${entityName?uncap_first}Mapper.updateByPrimaryKeySelective(obj);
    }

    @Override
    public ${entityName} getById(String id) {
        return ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
    }

    @Override
    public List<${entityName}> getMany() {
        return ${entityName?uncap_first}Mapper.selectByExample(new ${entityName}Criteria());
    }
}
