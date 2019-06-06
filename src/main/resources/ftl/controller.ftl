package ${parentPackageName}.controller;

import com.alibaba.fastjson.JSON;
import ${pojo}.${entityName};
import ${parentPackageName}.service.${entityName}Service;

import lombok.extern.apachecommons.CommonsLog;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import ${parentPackageName}.utils.commonJson.Info;
import ${parentPackageName}.utils.commonJson.ExtLimit;
import ${parentPackageName}.utils.commonJson.ComJsonUtil;
import ${parentPackageName}.utils.commonJson.FinalJson;


/**
* @program: gifm-bak
* @description: 自动生成, 待用户编辑 //TODO:描述待补充
* @author: xdc
* @create: ${.now}
**/
@CommonsLog
@RestController
@RequestMapping("/${entityName?uncap_first}")
public class ${entityName}Controller {

    @Resource
    private ${entityName}Service ${entityName?uncap_first}Service;


    /**
    * 获取分页数据
    *
    * @param comJsonUtil 前端请求json
    * @return ComJsonUtil
    */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    public ComJsonUtil getAllByPR(@RequestParam String comJsonUtil ,@RequestParam Map<String,Object> requestMap) throws Exception {
        ComJsonUtil jUBean = JSON.parseObject(JSON.toJSONString(comJsonUtil),ComJsonUtil.class);
        Map<String,Object> beanmap = (Map) jUBean.getData();
        ExtLimit extLimit = jUBean.getExtlimit();
        if(requestMap.containsKey("page")){
            extLimit.setPageindex(Integer.valueOf(requestMap.get("page").toString()));
        }
        if(requestMap.containsKey("rows")){
            extLimit.setPagesize(Integer.valueOf(requestMap.get("rows").toString()));
        }
        return ${entityName?uncap_first}Service.selectPage(beanmap,jUBean);
    }


    /**
    * 查找一条记录
    *
    * @param comJsonUtil 前端请求json
    * @return ComJsonUtil
    */
    @RequestMapping( method = RequestMethod.POST)
    public ComJsonUtil find${entityName}(@RequestBody ComJsonUtil comJsonUtil) {
        ComJsonUtil jUBean = JSON.parseObject(JSON.toJSONString(comJsonUtil),ComJsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        ${entityName} bean= ${entityName?uncap_first}Service.getById(Integer.parseInt( beanmap.get("id").toString() ));
        comJsonUtil.setData(bean != null ? bean : "根据主键未查询到数据");
        comJsonUtil.getInfo().setStatus(bean != null ?FinalJson.STATUS_OK : FinalJson.STATUS_NOTACCEPTABLE);
        comJsonUtil.getInfo().setMessage(bean != null ? "查询成功" : "查询失败" );
        return comJsonUtil;
    }



    /**
    * 新增一条记录
    *
    * @param comJsonUtil 前端请求json
    * @return ComJsonUtil
    */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ComJsonUtil save${entityName}(@RequestBody ComJsonUtil comJsonUtil) throws Exception {
        ComJsonUtil jUBean = JSON.parseObject(JSON.toJSONString(comJsonUtil),ComJsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        ${entityName} ${entityName?uncap_first} = new ${entityName}();
        BeanUtils.copyProperties(beanmap,${entityName?uncap_first});
        int res = ${entityName?uncap_first}Service.save(${entityName?uncap_first});
        comJsonUtil.setData(res==1 ? ${entityName?uncap_first} : "");
        comJsonUtil.getInfo().setStatus(res==1 ? FinalJson.STATUS_OK : FinalJson.STATUS_NOTACCEPTABLE);
        comJsonUtil.getInfo().setMessage(res==1 ?"新增成功" : "添加失败");
        return comJsonUtil;
    }



    /**
    * 修改一条记录
    *
    * @param comJsonUtil 前端请求json
    * @return ComJsonUtil
    */
    @RequestMapping(method = RequestMethod.PUT)
    public ComJsonUtil update${entityName}(@RequestBody ComJsonUtil comJsonUtil) throws Exception{
        ComJsonUtil jUBean = JSON.parseObject(JSON.toJSONString(comJsonUtil),ComJsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        ${entityName} ${entityName?uncap_first} = new ${entityName}();
        BeanUtils.copyProperties(beanmap,${entityName?uncap_first});
        int res = ${entityName?uncap_first}Service.updateByID(${entityName?uncap_first});
        Info info = new Info();
        info.setStatus(res > 0 ?  FinalJson.STATUS_OK : FinalJson.STATUS_NOTACCEPTABLE);
        info.setMessage(res > 0 ? "更新失败" : "更新失败");
        comJsonUtil.setInfo(info);
        return comJsonUtil;
    }

    /**
    * 删除一条记录
    *
    * @param comJsonUtil 前端请求json
    * @return ComJsonUtil
    */
    @RequestMapping( method = RequestMethod.DELETE)
    public ComJsonUtil delete${entityName}(@RequestBody ComJsonUtil comJsonUtil) {
        ComJsonUtil jUBean = JSON.parseObject(JSON.toJSONString(comJsonUtil),ComJsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        int res = ${entityName?uncap_first}Service.removeByID(Integer.parseInt(beanmap.get("id").toString()));
        Info info = new Info();
        info.setStatus(res > 0 ?  FinalJson.STATUS_OK : FinalJson.STATUS_NOTACCEPTABLE);
        info.setMessage(res > 0 ? "删除成功" : "删除失败");
        comJsonUtil.setInfo(info);
        return comJsonUtil;
    }

    /**
    * 批量删除记录
    *
    * @param comJsonUtil
    * @return ComJsonUtil
    */
    @RequestMapping(value = "/${entityName?uncap_first}s", method = RequestMethod.DELETE)
    public ComJsonUtil delete${entityName}s(@RequestBody ComJsonUtil comJsonUtil) {
        ComJsonUtil jUBean = JSON.parseObject(JSON.toJSONString(comJsonUtil),ComJsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        String ids = beanmap.get("ids").toString();
        String[] strings = StringUtils.split(ids, ",");
        Set <String> deleteIdList = new HashSet<>();
        for (int i = 0; i < strings.length; i++) {
            deleteIdList.add(strings[i]);
        }
        int res = ${entityName?uncap_first}Service.removeByIDs(deleteIdList);//TODO:该方法对应的sql暂时需要手工书写
        comJsonUtil.getInfo().setMessage( res > 0 ? "删除成功" : "删除失败");
        comJsonUtil.getInfo().setStatus( res > 0 ? FinalJson.STATUS_OK : FinalJson.STATUS_NOTACCEPTABLE);
        return comJsonUtil;
    }
}
