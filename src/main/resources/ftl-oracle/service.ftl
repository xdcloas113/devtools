package ${parentPackageName}.service;

import com.founder.framework.annotation.MethodAnnotation;
import com.founder.framework.annotation.MethodAnnotation.logType;
import com.founder.framework.utils.EasyUIPage;
import com.founder.framework.base.entity.SessionBean;
import ${parentPackageName}.model.${entityName};

import java.util.List;
import java.util.Map;

public interface ${entityName}Service {

    /**
    * 新增业务对象
    */
    @MethodAnnotation(value = "新增", type = logType.insert)
    public void insert(${entityName} entity, SessionBean sessionBean);

    /**
    * 根据主键ID修改对象
    */
    @MethodAnnotation(value = "更新", type = logType.update)
    public void update(${entityName} entity, SessionBean sessionBean);

    /**
    * 通过主键ID注销对象，只是修改注销状态为（已注销）
    */
    public void delete(${entityName} entity, SessionBean sessionBean);

    /**
    * 通过主键ID查询单个业务实体对象
    */
    public ${entityName} queryById(String ${pk}) ;

    /**
    * 根据业务实体查询业务实体列表
    */
    public List<${entityName}> queryByEntity(${entityName} entity);
    
    /**
    * 根据业务实体查询数量
    */
    public Integer queryCountByEntity(${entityName} entity);

    /**
    * 查询分页对象
    */
    public EasyUIPage queryPageList(EasyUIPage page, Object object) ;

}
