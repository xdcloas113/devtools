package ${parentPackageName}.service;

import ${pojo}.${entityName};
import ${parentPackageName}.utils.commonJson.ComJsonUtil;

import java.util.List;
import java.util.Map;
import java.util.Set;


/**
* @program: gifm-bak
* @description: 自动生成, 待用户编辑 //TODO:描述待补充
* @author: xdc
* @create: ${.now}
**/
public interface ${entityName}Service {

    /**
    * 查询分页对象
    */
    ComJsonUtil selectPage(Map<String, Object> queryMap,ComJsonUtil comJsonUtil);

    /**
    * 通过主键ID注销对象，只是修改注销状态为（已注销）
    */
    int removeByID(Integer id);

    /**
    * 通过主键ID注销对象(未实现)
    */
    int removeByIDs(Set<String> ids);

    /**
    * 保存
    */
    public int save(${entityName} obj);

    /**
    * 根据主键ID修改对象
    */
    public int updateByID(${entityName} obj);

    /**
    * 通过主键ID查询单个业务实体对象
    */
    public ${entityName} getById(Integer id);

    /**
    * 根据业务实体查询业务实体列表
    */
    public List<${entityName}> getMany() ;

    /**
    * 根据限制条件查询实体列表,多用于复杂逻辑的基础实体
    */
    ComJsonUtil selectAll(ComJsonUtil jsonUtil);

}



