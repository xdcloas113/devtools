package ${parentPackageName}.model;

import io.swagger.annotations.ApiParam;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

/**
* Created by Administrator on ${.now}.
*/
@Entity
@DynamicUpdate
public class ${entityName} implements Serializable {
	private static final long serialVersionUID = 1L;
<#list columus as colume>
    <#if colume["COLUMN_NAME"]?lower_case==("id")>
    @Id
    @GenericGenerator(name = "identity", strategy = "identity")
    @GeneratedValue(generator = "identity")
    @ApiParam(value = "${colume["COMMENTS"]!''}")
    private ${db2JavaMap[colume["DATA_TYPE"]]} ${colume["COLUMN_NAME"]?lower_case};//${colume["COMMENTS"]!''}

    </#if>
</#list>
<#list columus as colume>
    <#if colume["COLUMN_NAME"]?lower_case!=("id")>
    @ApiParam(value = "${colume["COMMENTS"]!''}")
    <#if colume["DATA_TYPE"]?lower_case?contains("date")>
    @NotNull
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiParam(value = "${colume["COMMENTS"]!''}(yyyy-MM-dd HH:mm:ss)")
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
