package ${parentPackageName}.dao;

import ${parentPackageName}.model.${entityName};
import cn.netmoon.common.dao.MySqlBaseDao;
import cn.netmoon.common.util.CollectionUtils;
import cn.netmoon.common.web.Page;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
/**
* @program: gifm-sub
* @description: 自动生成, 待用户编辑 //TODO:描述待补充
* @author: 兰芷不芳，荃蕙为茅
* @create: ${.now}
**/
@Repository
public class ${entityName}Dao  extends MySqlBaseDao<${entityName}>{

    /**
    * 通过主键ID查询单个业务实体对象
    * @param id
    * @return
    */
    public ${entityName} get${entityName}ByNo(String id) {
        return findOneByHql("from ${entityName} where id=?0, id");
    }

    /**
    * 分页查询业务对象列表
    * @param page
    * @param map
    * @return
    */
    public Page query${entityName}Page(Page page, Map map) {
        StringBuffer sql = new StringBuffer("select * from ${tableName} where 1=1");
        <#--map.remove("page");
        map.remove("num");-->
        <#list columus as colume>
        if (!StringUtils.isEmpty(map.get("${transformString(colume["COLUMN_NAME"])}"))) {
            sql.append(" and ${colume["COLUMN_NAME"]?lower_case}=:${transformString(colume["COLUMN_NAME"])}");
        }
        </#list>
        //删除参数中的多余参数
        CollectionUtils.retainAll(map,
        <#list columus as colume>
            "${transformString(colume["COLUMN_NAME"])}"<#if colume_index < columus?size-1>,</#if>
        </#list>);
        List list = findBySql(sql.toString(), page.getStart(), page.getNum(), map);
        int count = FOUND_ROWS();
        return page.setList(list, count);
    }
}
