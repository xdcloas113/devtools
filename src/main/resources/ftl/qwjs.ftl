	${tableName}_type : '${tableName}',
    ${tableName}_title : '${comments}',
    ${tableName}_init : [],    //默认显示的查询条件
    ${tableName} : [
    <#list columus as colume>
    <#if colume["COLUMN_NAME"] == 'XT_LRSJ' || colume["COLUMN_NAME"] == 'XT_CJSJ' || colume["COLUMN_NAME"] == 'XT_ZHXGSJ' || colume["DATA_TYPE"]?lower_case?contains("date")>
    	{field:'${colume["COLUMN_NAME"]}',text:'${colume["COMMENTS"]!''}',input:'datebox',judge_dict: judge2}<#if colume_has_next>,</#if>
    <#else>    	    
    	{field:'${colume["COLUMN_NAME"]}',text:'${colume["COMMENTS"]!''}',input:'textbox',judge_dict: judge1}<#if colume_has_next>,</#if>   
    </#if>
    </#list>
    ],
    
    