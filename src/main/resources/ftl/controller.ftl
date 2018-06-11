package ${parentPackageName}.controller;

import com.scmofit.gifm.common.EasyUIPage;
import com.scmofit.gifm.common.ServerResponse;
import com.scmofit.gifm.common.HttpCode;
import ${parentPackageName}.entities.${entityName};
import ${parentPackageName}.service.${entityName}Service;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import lombok.extern.apachecommons.CommonsLog;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

/**
* @program: gifm-sub
* @description: 自动生成, 待用户编辑 //TODO:描述待补充
* @author: robot
* @create: ${.now}
**/
@CommonsLog
@RestController
@RequestMapping("/v1/${entityName?uncap_first}")
public class ${entityName}Controller {
    @Resource
    private ${entityName}Service ${entityName?uncap_first}Service;

    /**
    * 获取分页数据
    *
    * @param page 当前页
    * @param rows 每页返回数据条数
    * @param ${entityName?uncap_first} 实体数据
    * @return EasyUIPage
    */
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public EasyUIPage getAllByPR(int page, int rows,@ModelAttribute  ${entityName} ${entityName?uncap_first}) {
        EasyUIPage easyUIPage = ${entityName?uncap_first}Service.selectPage(page, rows, ${entityName?uncap_first});

        return easyUIPage;
    }
    /**
    * 查找一条记录
    *
    * @param id 业务数据ID
    * @return ServerResponse
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ServerResponse find${entityName}(@PathVariable("id") String id) {
        ${entityName} ${entityName?uncap_first} = ${entityName?uncap_first}Service.getById(id);
        ServerResponse serverResponse = new ServerResponse(HttpCode.success,"查找成功","查找成功");
        return serverResponse;
    }

    /**
    * 新增一条记录
    *
    * @param ${entityName?uncap_first} 实体数据
    * @return ServerResponse
    */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ServerResponse save${entityName}(@ModelAttribute ${entityName} ${entityName?uncap_first}) {
        int res = ${entityName?uncap_first}Service.save(${entityName?uncap_first});

        if (res != 1) {
            return new ServerResponse(HttpCode.error,"保存失败","保存失败");
        }
        return  new ServerResponse(HttpCode.success,"保存成功","保存成功");
    }
    /**
    * 修改一条记录
    *
    * @param ${entityName?uncap_first} 实体数据
    * @return ServerResponse
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ServerResponse update${entityName}(@ModelAttribute ${entityName} ${entityName?uncap_first}) {
        int res = ${entityName?uncap_first}Service.updateByID(${entityName?uncap_first});
        if (res != 1) {
           return new ServerResponse(HttpCode.error,"更新失败","更新失败");
        }
        return  new ServerResponse(HttpCode.success,"更新成功","更新成功");
    }
    /**
    * 删除一条记录
    *
    * @param id 业务数据ID
    * @return ServerResponse
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ServerResponse delete${entityName}(@PathVariable("id") String id) {
        int res = ${entityName?uncap_first}Service.removeByID(id):
        if (res != 1) {
            return new ServerResponse(HttpCode.error,"删除失败！","删除失败！");
        }
        return  new ServerResponse(HttpCode.success,"删除成功","删除成功");
    }
    /**
    * 披露删除记录
    *
    * @param ids 业务数据ID
    * @return ServerResponse
    */
    @RequestMapping(value = "/${entityName?uncap_first}s/{ids}", method = RequestMethod.DELETE)
    public ServerResponse delete${entityName}s(@PathVariable("ids") String ids) {
        String[] strings = StringUtils.split(ids, ",");
        Set <String> deleteIdList = new HashSet<>();
        for (int i = 0; i < strings.length; i++) {
            deleteIdList.add(strings[i]);
        }
        int res = ${entityName?uncap_first}Service.removeByIDs(deleteIdList)://TODO:该方法对应的sql暂时需要手工书写
        if (res != 1) {
            return new ServerResponse(HttpCode.error,"删除失败！","删除失败！");
        }
        return  new ServerResponse(HttpCode.success,"删除成功","删除成功");
    }
}
