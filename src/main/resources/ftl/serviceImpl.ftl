package ${parentPackageName}.service.impl;

import ${parentPackageName}.dao.${entityName}Dao;
import com.founder.framework.annotation.MethodAnnotation;
import com.founder.framework.annotation.MethodAnnotation.logType;
import com.founder.framework.base.service.BaseService;
import com.founder.framework.utils.EasyUIPage;
import com.founder.framework.utils.UUID;
import ${parentPackageName}.model.${entityName};
import ${parentPackageName}.service.${entityName}Service;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.founder.framework.base.entity.SessionBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.founder.framework.utils.StringUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("${entityName?uncap_first}Service")
@Transactional
public class ${entityName}ServiceImpl extends BaseService implements ${entityName}Service{

    private Logger log = LoggerFactory.getLogger(this.getClass());

    @Resource(name = "${entityName?uncap_first}Dao")
    private ${entityName}Dao ${entityName?uncap_first}Dao;

    /**
    * 新增业务对象
    */
    @MethodAnnotation(value = "新增", type = logType.insert)
    public void insert(${entityName} entity,SessionBean sessionBean){
        entity.set${pk?lower_case?cap_first}(UUID.create());
        super.setSaveProperties(entity,sessionBean);
        log.info(entity.toString());
        ${entityName?uncap_first}Dao.insert(entity);
    }

    /**
    * 根据主键ID修改对象
    */
    @MethodAnnotation(value = "更新", type = logType.update)
    public void update(${entityName} entity, SessionBean sessionBean){
        super.setUpdateProperties(entity,sessionBean);
        log.info(entity.toString());
        ${entityName?uncap_first}Dao.update(entity);
    }

    /**
    * 通过主键ID注销对象，只是修改注销状态为（已注销）
    */
    public void delete(${entityName} entity, SessionBean sessionBean){
        super.setUpdateProperties(entity,sessionBean);
        log.info(entity.toString());
        ${entityName?uncap_first}Dao.delete(entity);
    }

    /**
    * 通过主键ID查询单个业务实体对象
    */
    public ${entityName} queryById(String ${pk}){
        return ${entityName?uncap_first}Dao.queryById(${pk});
    }

    /**
    * 根据业务实体查询业务实体列表
    */
    public List<${entityName}> queryByEntity(${entityName} entity){
        return ${entityName?uncap_first}Dao.queryByEntity(entity);
    }
    
    /**
    * 根据业务实体查询数量
    */
    public Integer queryCountByEntity(${entityName} entity){
		return (Integer)${entityName?uncap_first}Dao.queryCountByEntity(entity);
	}

    /**
    * 查询分页对象
    */
    public EasyUIPage queryPageList(EasyUIPage page, Object object){
        Map<String,Object> map=new HashMap<>();

        //添加查询条件，按什么排序，分页中信息数量
        map.put("begin", page.getBegin());
        map.put("end", page.getEnd());
        String sort = page.getSort();
        String order = page.getOrder();
        if (StringUtils.isBlank(sort)) { // 默认排序
        sort = "XT_CJSJ";
        order = "DESC";
        }
        map.put("sort", sort);
        map.put("order", order);

        map.put("entity", object);	//添加实有人口总表对象
        return ${entityName?uncap_first}Dao.queryPageList(map,page);
    }

}
