package ${parentPackageName}.dao;

import ${parentPackageName}.model.${entityName};
import cn.netmoon.common.dao.MySqlBaseDao;
import cn.netmoon.common.util.CollectionUtils;
import cn.netmoon.common.web.Page;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

@Repository
public class ${entityName}Dao  extends MySqlBaseDao<${entityName}>{

    /**
    * 新增业务对象
    */
    public void insert(${entityName} entity) {
        super.insert("${paramName}.save",entity);
    }

    /**
    * 根据主键ID修改对象
    */
    public void update(${entityName} entity) {
        super.update("${paramName}.update",entity);
    }

    /**
    * 通过主键ID注销对象，只是修改注销状态为（已注销）
    */
    public void delete(${entityName} entity) {
        super.delete("${paramName}.delete",entity);
    }

    /**
    * 通过主键ID查询单个业务实体对象
    */
    public ${entityName} queryById(String ${pk}) {
        return (${entityName})super.queryForObject("${paramName}.queryById",${pk});
    }

    /**
    * 根据业务实体查询业务实体列表
    */
    public List<${entityName}> queryByEntity(${entityName} entity) {
        return super.queryForList("${paramName}.queryByEntity",entity);
    }
    
    /**
    * 根据业务实体查询数量
    */
    public Integer queryCountByEntity(${entityName} entity){
		return (Integer)super.queryForObject("${paramName}.queryCountByEntity", entity);
	}

    /**
    * 查询分页对象
    */
    public EasyUIPage queryPageList(Map<String, Object> map, EasyUIPage page) {
        Integer count=(Integer)queryForObject("${paramName}.queryPageCount", map);
        page.setTotal(count==null?0:count);
        page.setRows(queryForList("${paramName}.queryPageList", map));
        return page;
    }
}
