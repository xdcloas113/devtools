package ${parentPackageName}.service.impl;

import ${parentPackageName}.dao.${entityName}Dao;
import ${parentPackageName}.model.${entityName};
import ${parentPackageName}.service.${entityName}Service;
import ${parentPackageName}.validate.${entityName}Valid;
import cn.netmoon.common.cache.Cache;
import cn.netmoon.common.util.BeanUtils;
import cn.netmoon.common.web.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.PostConstruct;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/12.
 */
@Service
public class ${entityName}ServiceImpl implements ${entityName}Service{

    @Autowired
    private ${entityName}Dao ${entityName?uncap_first}Dao;
    @Autowired
    private Cache cache;

    @Autowired
    private ApplicationContext ac;
    private ${entityName}Service proxy;

    @PostConstruct
    public void getProxy() {
        proxy = ac.getBean(this.getClass());
    }

    /**
    * 新增业务对象
    * @param req
    * @param campusId
    * @return
    */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void create${entityName}(${entityName}Valid req, Integer campusId) {

        ${entityName} ${entityName?uncap_first} = new ${entityName}();
        BeanUtils.copyProperties(req, ${entityName?uncap_first});
        if(StringUtils.isEmpty(req.getDeleted()))
            ${entityName?uncap_first}.setDeleted(false);
        ${entityName?uncap_first}Dao.save(${entityName?uncap_first});
    }

    /**
     * 根据主键ID修改对象
     * @param req
     * @param campusId
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void update${entityName}(${entityName}Valid req, Integer campusId) {
        ${entityName} ${entityName?uncap_first} = new ${entityName}();//${entityName?uncap_first}Dao.get${entityName}ByNo(req.getId());
        BeanUtils.copyProperties(req, ${entityName?uncap_first});
        ${entityName?uncap_first}Dao.merge(${entityName?uncap_first});
    }
    /**
     * 通过主键ID注销对象，只是修改注销状态为（已注销）
     * @param req
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void delete${entityName}(${entityName}Valid req) {
        ${entityName} ${entityName?uncap_first} = ${entityName?uncap_first}Dao.get(req.getId());
        ${entityName?uncap_first}.setDeleted(true);
        ${entityName?uncap_first}Dao.update(${entityName?uncap_first});
    }
    /**
     * edit exam
     */
    @Transactional(readOnly = true)
    public Page query${entityName}Page(Page page, Map map) {
        return ${entityName?uncap_first}Dao.query${entityName}Page(page,map);
    }
}
