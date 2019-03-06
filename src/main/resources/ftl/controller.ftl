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

import com.laoxu.utils.json.ExtLimit;
import com.laoxu.utils.json.JsonUtil;
import com.laoxu.utils.status.FinalJson;


/**
* @program: gifm-sub
* @description: 自动生成, 待用户编辑 //TODO:描述待补充
* @author: 兰芷不芳，荃蕙为茅
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
    * @param jsonUtil 前端请求json
    * @return JsonUtil
    */
    @RequestMapping(value="/page",method = RequestMethod.POST)
        public JsonUtil getAllByPR(@RequestBody JsonUtil jsonUtil) throws Exception {
        JsonUtil jUBean = JSON.parseObject(JSON.toJSONString(jsonUtil),JsonUtil.class);
        Map<String,Object> beanmap = (Map) jUBean.getData();
        if(beanmap == null){
            jsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            jsonUtil.getInfo().setMessage("请求失败");
            return jsonUtil;
        }
        ExtLimit extLimit = jUBean.getExtlimit();
        int page = extLimit.getPageindex();
        int rows = extLimit.getPagesize();
        JsonUtil backJU = ${entityName?uncap_first}Service.selectPage(page, rows, beanmap,jsonUtil);
        return backJU;
    }



    /**
    * 查找一条记录
    *
    * @param jsonUtil 前端请求json
    * @return JsonUtil
    */
    @RequestMapping( method = RequestMethod.POST)
    public JsonUtil find${entityName}(@RequestBody JsonUtil jsonUtil) {
        JsonUtil jUBean = JSON.parseObject(JSON.toJSONString(jsonUtil),JsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        ${entityName} ${entityName?uncap_first} = ${entityName?uncap_first}Service.getById(beanmap.get("id").toString());
        if(beanmap == null || ${entityName?uncap_first} == null){
            jsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            jsonUtil.getInfo().setMessage("请求失败");
            return jsonUtil;
        }
        jsonUtil.getInfo().setStatus(FinalJson.STATUS_OK);
        jsonUtil.getInfo().setMessage("请求成功");
        jsonUtil.setData(${entityName?uncap_first});
        return jsonUtil;
    }



    /**
    * 新增一条记录
    *
    * @param jsonUtil 前端请求json
    * @return JsonUtil
    */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public JsonUtil save${entityName}(@RequestBody JsonUtil jsonUtil) throws Exception {
        JsonUtil jUBean = JSON.parseObject(JSON.toJSONString(jsonUtil),JsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        ${entityName} ${entityName?uncap_first} = new ${entityName}();
        BeanUtils.copyProperties(beanmap,${entityName?uncap_first});
        int res = ${entityName?uncap_first}Service.save(${entityName?uncap_first});
        if (res != 1) {
            jsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            jsonUtil.getInfo().setMessage("新增失败");
            return jsonUtil;
        }
        jsonUtil.getInfo().setStatus(FinalJson.STATUS_OK);
        jsonUtil.getInfo().setMessage("新增成功");
        return jsonUtil;
    }



    /**
    * 修改一条记录
    *
    * @param jsonUtil 前端请求json
    * @return JsonUtil
    */
    @RequestMapping(method = RequestMethod.PUT)
    public JsonUtil update${entityName}(@RequestBody JsonUtil jsonUtil) throws Exception{
        JsonUtil jUBean = JSON.parseObject(JSON.toJSONString(jsonUtil),JsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        ${entityName} ${entityName?uncap_first} = new ${entityName}();
        BeanUtils.copyProperties(beanmap,${entityName?uncap_first});
        int res = ${entityName?uncap_first}Service.updateByID(${entityName?uncap_first});
        if (res != 1) {
            jsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            jsonUtil.getInfo().setMessage("更新失败");
            return jsonUtil;
        }
        jsonUtil.getInfo().setStatus(FinalJson.STATUS_OK);
        jsonUtil.getInfo().setMessage("更新成功");
        return jsonUtil;
    }


    /**
    * 删除一条记录
    *
    * @param jsonUtil 前端请求json
    * @return JsonUtil
    */
    @RequestMapping( method = RequestMethod.DELETE)
    public JsonUtil delete${entityName}(@RequestBody JsonUtil jsonUtil) {
        JsonUtil jUBean = JSON.parseObject(JSON.toJSONString(jsonUtil),JsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        int res = ${entityName?uncap_first}Service.removeByID(beanmap.get("id").toString());
        if (res != 1) {
            jsonUtil.getInfo().setStatus(FinalJson.STATUS_NOTACCEPTABLE);
            jsonUtil.getInfo().setMessage("删除失败");
            return jsonUtil;
        }
        jsonUtil.getInfo().setStatus(FinalJson.STATUS_OK);
        jsonUtil.getInfo().setMessage("删除成功");
        return jsonUtil;
    }

    /**
    * 批量删除记录
    *
    * @param jsonUtil
    * @return ServerResponse
    */
    @RequestMapping(value = "/${entityName?uncap_first}s", method = RequestMethod.DELETE)
    public JsonUtil delete${entityName}s(@RequestBody JsonUtil jsonUtil) {
        JsonUtil jUBean = JSON.parseObject(JSON.toJSONString(jsonUtil),JsonUtil.class);
        Map<String,Object> beanmap = (Map)jUBean.getData();
        String ids = beanmap.get("ids").toString();
        String[] strings = StringUtils.split(ids, ",");
        Set <String> deleteIdList = new HashSet<>();
        for (int i = 0; i < strings.length; i++) {
            deleteIdList.add(strings[i]);
        }
        int res = ${entityName?uncap_first}Service.removeByIDs(deleteIdList);//TODO:该方法对应的sql暂时需要手工书写
        jsonUtil.getInfo().setMessage( res > 0 ? "删除成功" : "删除失败");
        jsonUtil.getInfo().setStatus( res > 0 ? FinalJson.STATUS_OK : FinalJson.STATUS_NOTACCEPTABLE);
        return jsonUtil;
    }
}
