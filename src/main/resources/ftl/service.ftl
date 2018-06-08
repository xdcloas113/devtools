package ${parentPackageName}.service;

import com.scmofit.gifm.common.EasyUIPage;
import ${parentPackageName}.model.${entityName};

import java.util.List;
import java.util.Map;

public interface ${entityName}Service {

    /**
    * 查询分页对象
    */
    EasyUIPage selectPage(int page, int rows, ${entityName} fundQuery);

    /**
    * 通过主键ID注销对象，只是修改注销状态为（已注销）
    */
    int removeByID(String id);

    /**
    * 通过主键ID注销对象(未实现)
    */
    int removeByIDs(Set<String> ids);

    /**
    * 新增业务对象
    */
    public int save(${entityName} obj);

    /**
    * 根据主键ID修改对象
    */
    public int updateByID(${entityName} obj);
    /**
    * 通过主键ID查询单个业务实体对象
    */
    public ${entityName} getById(String id);
    /**
    * 根据业务实体查询业务实体列表
    */
    public List<${entityName}> getMany() ;

}



