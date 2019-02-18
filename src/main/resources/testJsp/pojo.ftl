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

<div style='width:100%; height:100%;' class="easyui-layout" data-options="fit:true">

    <div id="centerPanel" data-options="region:'center'">
        <table id="${entityName?uncap_first}_list"></table>
        <div id="${entityName?uncap_first}_find" style="padding:2px 5px;">
        ${entityName?uncap_first}名称: <input name="${entityName?uncap_first}Name" id="${entityName?uncap_first}Name" style="width:120px" >
            <input type="button" value="查询" iconCls="icon-search" onclick="searchInfo()" />
        </div>
    </div>
</div>

<script>
    ${entityName?uncap_first}_list();


    function ${entityName?uncap_first}_list(){
        $('#${entityName?uncap_first}_list').datagrid({
            url:'/v1/${entityName?uncap_first}/page',
            method:"get",
            columns:[[
            <#list columus as colume>
                <#if colume["COLUMN_NAME"]?lower_case==("id")>
                    {field:'id',title:'${colume["COMMENTS"]}',hidden: 'true'},
                </#if>
            </#list>
            <#list columus as colume>
                <#if colume["COLUMN_NAME"]?lower_case!=("id")>
                    <#if colume["DATA_TYPE"]?lower_case?contains("date")>
                        {field:'${colume["COLUMN_NAME"]}',title:'${colume["COMMENTS"]}',width:100,formatter: formatDate},
                    <#elseif colume["DATA_TYPE"]?lower_case?contains("tinyint")>
                        {field:'${colume["COLUMN_NAME"]}',title:'${colume["COMMENTS"]}',width:100,formatter: isNot},
                    <#elseif colume["DATA_TYPE"]?lower_case?contains("int")>
                        {field:'${colume["COLUMN_NAME"]}',title:'${colume["COMMENTS"]}',width:100,sortable:true},
                    <#elseif colume["DATA_TYPE"]?lower_case?contains("NUMBER")>
                        {field:'${colume["COLUMN_NAME"]}',title:'${colume["COMMENTS"]}',width:100,sortable:true},
                    <#else >
                        {field:'${colume["COLUMN_NAME"]}',title:'${colume["COMMENTS"]}',width:100},
                    </#if>
                </#if>
            </#list>
            ]],
            queryParams: {},
            loadMsg:'数据载入中......',
            height:'auto',
            width:'auto',
            nowrap:true,
            striped:true,
            border:false,
            collapsible:false,//是否可折叠的
            fit:true,//自动大小
            remoteSort:true,
            idField:'id',
            singleSelect:true,//是否单选
            pagination:true,//分页控件
            pageSize:15,
            pageList:[15,30,60],
            rownumbers:false,//行号
            frozenColumns:[[//列锁定
                {field:'ck',checkbox:true}

            ]],
            emptyMsg: '<span>无记录</span>',
            fitColumns:true,
            onLoadSuccess:function(data){
                $("#${entityName?uncap_first}_list").datagrid('clearSelections');
                if (data.total == 0) {
                    //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
                    $(this).datagrid('appendRow', {
                ${columus[1]["COLUMN_NAME"]}
                : '<div style="text-align:center;color:red">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field:
                    '${columus[1]["COLUMN_NAME"]}' , colspan:
                    ${columus?size-1} })
                    //隐藏分页导航条，这个需要熟悉datagrid的html结构，直接用jquery操作DOM对象，easyui datagrid没有提供相关方法隐藏导航条
                    $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
                    $("#${entityName?uncap_first}_find").hide();
                }
                //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
                else {
                    $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
                    $("#${entityName?uncap_first}_find").show();
                }
            },
            toolbar:[{
                text:'添加',
                iconCls:'icon-add',
                handler:function(){
                    window.location.href="/v1/${entityName?uncap_first}/goAdd";
                }
            },'-',{
                text:'修改',
                iconCls:'icon-edit',
                handler:function(){
                    var rows = $('#${entityName?uncap_first}_list').datagrid('getSelections');
                    if (rows.length == 0) {
                        alertWarn("请选择要修改的信息");
                    }else if (rows.length > 1) {
                        alertWarn("只能选择一条信息进行修改");
                    }else{
                        var id = rows[0].id;
                        window.location.href="/v1/${entityName?uncap_first}/goEdit/"+id;
                    }
                }
            },'-',{
                text:'删除',
                iconCls:'icon-remove',
                handler:function(){
                    var rows = $('#${entityName?uncap_first}_list').datagrid('getSelections');
                    if(rows==null || rows.length<=0){
                        alertWarn("请选择要删除的信息");
                        return;
                    }
                    var id = rows[0].id;
                    $.ajax({
                        url:'/v1/${entityName?uncap_first}/'+id,
                        type:"delete",
                        data:{},
                        dataType:"json",
                        success:function(response) {
                            showMessages(response);
                        }

                    });
                }

            },'-',{
                text:'查看',
                iconCls:'icon-remove',
                handler:function(){
                    var rows = $('#${entityName?uncap_first}_list').datagrid('getSelections');
                    if(rows==null || rows.length<=0){
                        alertWarn("请选择要查看的信息");
                        return;
                    }
                    var id = rows[0].id;
                    window.location.href="/v1/${entityName?uncap_first}/goView/"+id;
                }

            }]
        });
        $("#depart_division_condi").prependTo('.datagrid-toolbar');
    }


</script>


</body>
</html>