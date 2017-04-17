package ${parentPackageName}.service;

import ${parentPackageName}.model.${entityName};
import ${parentPackageName}.validate.${entityName}Valid;
import cn.netmoon.common.web.Page;

import java.util.Map;
/**
  * Created by Administrator on 2017/4/12.
  */
public interface ${entityName}Service {

    /**
    * 新增业务对象
    * @param req
    * @param campusId
    * @return
    */
    public void create${entityName}(${entityName}Valid req, Integer campusId) ;

    /**
    * 根据主键ID修改对象
    */
    public void update${entityName}(${entityName}Valid req, Integer campusId) ;

    /**
    * 通过主键ID注销对象，只是修改注销状态为（已注销）
    */
    public void delete${entityName}(${entityName}Valid req) ;

    /**
    * 通过主键ID查询单个业务实体对象
    */
    //public ${entityName} queryById(String ${pk}) ;
    /**
    *根据业务实体查询业务实体列表
    */
    public Page query${entityName}Page(Page page, Map map);

}
