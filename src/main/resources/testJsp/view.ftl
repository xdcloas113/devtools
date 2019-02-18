<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${entityName}查看</title>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../head.jsp">
        <jsp:param value="${entityName}管理" name="pageTitle" />
    </jsp:include>
</head>
<body>
<div class="easyui-panel" style="width:100%" title="${entityName}查看">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:5px;">
        <tr>
            <td height="30" colspan="4" align="left">
                <a href="javascript:window.history.back();" class="easyui-linkbutton">返回</a>&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="csstable">
    <#list columus as colume>
        <#if colume["COLUMN_NAME"]?lower_case==("id")>
            <input id="${colume["COLUMN_NAME"]}" name="${colume["COLUMN_NAME"]}" value="${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}" type="hidden" >
        </#if>
    </#list>
    <#list columus as colume>
        <#if colume["COLUMN_NAME"]?lower_case!=("id")>
            <#if colume["DATA_TYPE"]?lower_case?contains("date")>
                <td width="20%" height="35" align="left"><strong>${colume["COMMENTS"]}:</strong></td>
                <td width="80%">
                    <input id="${colume["COLUMN_NAME"]}" name="${colume["COLUMN_NAME"]}" type="text" class="yj-text" style="width:90px;" readonly="readonly" value="${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}"
                           onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd', maxDate: '%y-%M-%d' });"/>
                </td>
            <#elseif colume["DATA_TYPE"]?lower_case?contains("tinyint")>
                <tr>
                    <td width="20%" height="35" align="left"><strong>${colume["COMMENTS"]}:</strong></td>
                    <td width="80%">
                    ${'$'}{0 eq ${entityName?uncap_first}.${colume['COLUMN_NAME']}?"没有":""}
                    ${'$'}{0 eq ${entityName?uncap_first}.${colume['COLUMN_NAME']}?"已有":""}
                    </td>
                </tr>
            <#else >
                <tr>
                    <td width="20%" height="35" align="left"><strong>${colume["COMMENTS"]}:</strong></td>
                    <td width="80%">
                        ${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}
                    </td>
                </tr>
            </#if>
        </#if>
    </#list>
    </table>
</div>

</body>
</html>