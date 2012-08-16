﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NDWRTest.aspx.cs" Inherits="Default4" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="ajaxUtils/jquery-1.4.1.js" type="text/javascript"></script>
    <%--<script type="text/javascript" src="JSONUtil.js"></script>--%>
    <script src="<%=BasePath %>ndwr/ndwrcore.js?version=12dsdfdfdsfdsfsd" type="text/javascript"></script>
    <script src="<%=BasePath %>ndwr/RemoteDemo.js?version=23" type="text/javascript"></script>
</head>
<body>
    <button onclick="load()" >提交</button>
    <button onclick="loadEntity()">实体提交</button>
    <button onclick="loadBacth()">批量提交</button>
    <button onclick="loadMix()">混合提交</button>
    <button onclick="loadCustomError()">自定义错误提交</button>
    <button onclick="loadDataList()">获取数据集</button>
    <button onclick="loadDownLoad()">下载文件</button>

    <div id="msg"></div>
<script type="text/javascript">
    ndwr.errorHandle = function (errors) {
        var msg = '';
        for (var i = 0; i < errors.length; i++) {
            msg += errors[i]['Name'] + ':' + errors[i]['Message'] + '\r\n';
        }
        write(msg);
        //alert(msg);
    }

    ndwr.dataFilter = function (data) {
        if (data == null) {
            write('返回数据为空');
        }
    }

    function write(msg) {
        $('#msg').html(
            $('#msg').html() + '<br/>' + msg
        );
    }

    function load() {

        
        RemoteDemo.PubMethod(1, function (data) {
            write(data);
        });
    }
    function loadEntity() {

        var entity = {};
        entity.Id = 1;
        entity.Name = "wangyue";
        RemoteDemo.PubMethodEntity(entity, function (data) {
            write(data);
        });
    }

    function loadBacth() {

        ndwr.BeginBatch();
        load();
        loadEntity();
        ndwr.EndBatch();
    }

    function loadMix() {

        ndwr.BeginBatch();
        load();
        loadEntity();
        ndwr.EndBatch();

        load();
        loadEntity();
    }

    function loadCustomError() {

        RemoteDemo.PubMethod(1, {
            callBack: function (data) { write(data); },
            errorHandler: function (errors) { write(errors[0].Message); }
        });
    }

    function loadDataList() {

        RemoteDemo.DataList(1, function (data) {
            if (data == null) {
                return;
            }
            var ret = '';
            for (var i = 0; i < data.length; i++) {
                ret += data[i]['Id'] + ' ' + data[i]['Name'] + ' ' + data[i]['Pswd'] + '<br/>';
            }

            write(ret);
        });
    }

    function loadDownLoad() {

        var entity = {};
        entity.Id = 1;
        entity.Name = "wangyue";
        RemoteDemo.DownLoadFile(entity, null);
    }
</script>
</body>
</html>