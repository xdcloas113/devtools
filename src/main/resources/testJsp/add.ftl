<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${entityName}添加</title>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../head.jsp">
        <jsp:param value="${entityName}管理" name="pageTitle" />
    </jsp:include>
</head>
<body>

    <form id="add_form" method="post" action="/v1/${entityName?uncap_first}/add">
        <div class="easyui-panel" style="width:100%" title="${entityName}增添">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:5px;">
                <tr>
                    <td height="30" colspan="4" align="left">
                        <a href="javascript:window.history.back();" class="easyui-linkbutton">返回</a>&nbsp;&nbsp;
                        <a  class="easyui-linkbutton" onclick="addInfo()">保存</a>
                    </td>
                </tr>
            </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="csstable">

        <#list columus as colume>
            <#if colume["COLUMN_NAME"]?lower_case==("id")>
                <input id="${colume["COLUMN_NAME"]}" name="${colume["COLUMN_NAME"]}" type="hidden" >
            </#if>
        </#list>
        <#list columus as colume>
            <#if colume["COLUMN_NAME"]?lower_case!=("id")>
                <#if colume["DATA_TYPE"]?lower_case?contains("timestamp")>
                    <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                    <td width="80%">
                        <input id="${colume["COLUMN_NAME"]}" name="${colume["COLUMN_NAME"]}" type="text" class="yj-text" style="width:90px;" readonly="readonly"
                               onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd', maxDate: '%y-%M-%d' });"/>
                    </td>
                <#elseif colume["DATA_TYPE"]?lower_case?contains("tinyint")>
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="radio" name="${colume["COLUMN_NAME"]}"  class="" value="0" checked="checked"/>没有&nbsp;
                            <input type="radio" name="${colume["COLUMN_NAME"]}"  class="" value="1"/>已有
                        </td>
                    </tr>
                <#elseif colume["DATA_TYPE"]?lower_case?contains("int")>
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="text" name="${colume["COLUMN_NAME"]}" id="${colume["COLUMN_NAME"]}" class="easyui-numberbox " data-options="min:1,required:true" missingMessage="${colume["COMMENTS"]}不能为空"/>
                        </td>
                    </tr>
                <#elseif colume["DATA_TYPE"]?lower_case?contains("NUMBER")>
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="text" name="${colume["COLUMN_NAME"]}" id="${colume["COLUMN_NAME"]}" class="easyui-numberbox " data-options="min:1,required:true" missingMessage="${colume["COMMENTS"]}不能为空"/>
                        </td>
                    </tr>
                <#else >
                    <tr>
                        <td width="20%" height="35" align="left"><span class="requiredTip" >&nbsp</span>${colume["COMMENTS"]}:</td>
                        <td width="80%">
                            <input type="text" name="${colume["COLUMN_NAME"]}" id="${colume["COLUMN_NAME"]}" class="easyui-textbox"   data-options="required:true" missingMessage="${colume["COMMENTS"]}不能为空"/>
                        </td>
                    </tr>
                </#if>
            </#if>
        </#list>
        </table>
        </div>
    </form>




<script>

    //添加信息
    function addInfo(){
        $('#add_form').form('submit',{
            onSubmit:function(){
                var bool = $('#add_form').form('enableValidation').form('validate');
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