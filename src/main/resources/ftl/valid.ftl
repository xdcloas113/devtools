package ${parentPackageName}.validate;

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
import org.hibernate.validator.constraints.Range;

/**
* Created by Administrator on ${.now}.
*/

public class ${entityName}Valid implements Serializable {
    private static final long serialVersionUID = 1L;

    @Range(min = 1, max = Integer.MAX_VALUE)
    @ApiParam(value = "总页数(查询用）")
    private Integer page;
    @Range(min = 1, max = Integer.MAX_VALUE)
    @ApiParam(value = "每页查询记录数(查询用）")
    private Integer num;
<#list columus as colume>
    <#if colume["COLUMN_NAME"]?lower_case==("id")>
    @ApiParam(value = "${colume["COMMENTS"]!''}")
    private ${db2JavaMap[colume["DATA_TYPE"]]} ${colume["COLUMN_NAME"]?lower_case};//${colume["COMMENTS"]!''}
    </#if>
</#list>
<#list columus as colume>
    <#if colume["COLUMN_NAME"]?lower_case!=("id")>
        <#if !colume["DATA_TYPE"]?lower_case?contains("date")>
    @ApiParam(value = "${colume["COMMENTS"]!''}")
        <#elseif colume["DATA_TYPE"]?lower_case?contains("date")>
    @NotNull
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiParam(value = "${colume["COMMENTS"]!''}(yyyy-MM-dd HH:mm:ss)")
        </#if>
    private ${db2JavaMap[colume["DATA_TYPE"]]} ${transformString(colume["COLUMN_NAME"])};//${colume["COMMENTS"]!''}

    </#if>
</#list>

<#list columus as colume>
    <#if !colume["COLUMN_NAME"]?lower_case?starts_with("xt_")>
    public ${db2JavaMap[colume["DATA_TYPE"]]} get${buildMethodSuffixString(colume["COLUMN_NAME"])}(){
        return ${transformString(colume["COLUMN_NAME"])};
    }

    public void set${buildMethodSuffixString(colume["COLUMN_NAME"])}(${db2JavaMap[colume["DATA_TYPE"]]} ${transformString(colume["COLUMN_NAME"])}) {
        this.${transformString(colume["COLUMN_NAME"])} = ${transformString(colume["COLUMN_NAME"])};
    }
    </#if>
</#list>
    //set page&num
    public Integer getPage(){
        return page;
    }
    public void setPage(Integer page) {
        this.page = page;
    }
    public Integer getNum(){
        return num;
    }
    public void setNum(Integer num) {
        this.num = num;
    }

}
