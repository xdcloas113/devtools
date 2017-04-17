package ${parentPackageName}.model;

import com.alibaba.fastjson.annotation.JSONField;
import com.founder.framework.annotation.DBInfoAnnotation;
import com.founder.framework.annotation.FieldDesc;
import com.founder.framework.base.entity.BaseEntity;
import com.founder.common.datedeserializer.SimpleDateDeserializer;
import com.founder.common.dateserializer.SimpleDateSerializer;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import javax.ws.rs.FormParam;

import java.io.Serializable;

public class ${entityName} extends BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;

<#list columus as colume>
    <#if !colume["COLUMN_NAME"]?lower_case?starts_with("xt_")>
    @FormParam("${colume["COLUMN_NAME"]?lower_case}")
    <#if colume["DATA_TYPE"]?lower_case?contains("date")>
    @JSONField(format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonSerialize(using = SimpleDateSerializer.class)
    @JsonDeserialize(using = SimpleDateDeserializer.class)
    </#if>
    private ${db2JavaMap[colume["DATA_TYPE"]]} ${colume["COLUMN_NAME"]?lower_case};//${colume["COMMENTS"]!''}
    
    </#if>
</#list>

<#list columus as colume>
    <#if !colume["COLUMN_NAME"]?lower_case?starts_with("xt_")>
    public ${db2JavaMap[colume["DATA_TYPE"]]} get${colume["COLUMN_NAME"]?lower_case?cap_first}(){
        return ${colume["COLUMN_NAME"]?lower_case};
    }

    public void set${colume["COLUMN_NAME"]?lower_case?cap_first}(${db2JavaMap[colume["DATA_TYPE"]]} ${colume["COLUMN_NAME"]?lower_case}) {
        this.${colume["COLUMN_NAME"]?lower_case} = ${colume["COLUMN_NAME"]?lower_case};
    }
    </#if>
</#list>

}
