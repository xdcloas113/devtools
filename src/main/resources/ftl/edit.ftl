<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${entityName}更改</title>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../head.jsp">
        <jsp:param value="${entityName}管理" name="pageTitle" />
    </jsp:include>
</head>
<body>
    <form id="edit_form" method="put" action="/v1/${entityName?uncap_first}/
<#list columus as colume>
    <#if colume["COLUMN_NAME"]?lower_case==("id")>
    ${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}
    </#if>
</#list>"
    >
        <div class="easyui-panel" style="width:100%" title="${entityName}修改">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:5px;">
                <tr>
                    <td height="30" colspan="4" align="left">
                        <a href="javascript:window.history.back();" class="easyui-linkbutton">返回</a>&nbsp;&nbsp;
                        <a  class="easyui-linkbutton" onclick="editInfo()">保存</a>
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
                <#if colume["DATA_TYPE"]?lower_case?contains("timestamp")>
                    <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                    <td width="80%">
                        <input id="${colume["COLUMN_NAME"]}" name="${colume["COLUMN_NAME"]}" type="text" class="yj-text" style="width:90px;" readonly="readonly" value="${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}"
                               onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd', maxDate: '%y-%M-%d' });"/>
                    </td>
                <#elseif colume["DATA_TYPE"]?lower_case?contains("tinyint")>
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="radio" name="${colume["COLUMN_NAME"]}"  class="" value="0" ${'$'}{0 eq ${entityName?uncap_first}.${colume['COLUMN_NAME']}?"checked":""}/>没有&nbsp;
                            <input type="radio" name="${colume["COLUMN_NAME"]}"  class="" value="1" ${'$'}{1 eq ${entityName?uncap_first}.${colume['COLUMN_NAME']}?"checked":""}/>已有
                        </td>
                    </tr>
                <#elseif colume["DATA_TYPE"]?lower_case?contains("int")>
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="text" name="${colume["COLUMN_NAME"]}" id="${colume["COLUMN_NAME"]}" class="easyui-numberbox " value="${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}" data-options="min:1,required:true" missingMessage="${colume["COMMENTS"]}不能为空"/>
                        </td>
                    </tr>
                <#elseif colume["DATA_TYPE"]?lower_case?contains("NUMBER")>
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="text" name="${colume["COLUMN_NAME"]}" id="${colume["COLUMN_NAME"]}" class="easyui-numberbox " value="${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}" data-options="min:1,required:true" missingMessage="${colume["COMMENTS"]}不能为空"/>
                        </td>
                    </tr>
                <#else >
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="text" name="${colume["COLUMN_NAME"]}" id="${colume["COLUMN_NAME"]}" class="easyui-textbox" value="${'$'}{${entityName?uncap_first}.${colume['COLUMN_NAME']}}"  data-options="required:true" missingMessage="${colume["COMMENTS"]}不能为空"/>
                        </td>
                    </tr>
                </#if>
            </#if>
        </#list>
        </table>
        </div>
    </form>




<script>

    //修改信息
    function editInfo(){
        $('#edit_form').form('submit',{
            onSubmit:function(){
                var bool = $('#edit_form').form('enableValidation').form('validate');
                return bool;
            },
            success: function (ret) {
                var data = $.parseJSON(ret);
                $.messager.alert('', data.msg, 'info', function () {
                    window.parent.reloadDataGrid();
                    window.parent.closeWindow();
                });
            }
        });
    }
</script>


</body>
</html>