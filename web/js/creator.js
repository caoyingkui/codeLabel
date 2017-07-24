/**
 * Created by oliver on 2017/7/20.
 */
function getTables() {
    var parameters = {
        database_url: "127.0.0.1",//$("#database[url]").value,
        database_port:$("#database_port").val(),
        database_database:$("#database_database").val(),
        database_user:$("#database_user").val(),
        database_pwd:$("#database_pwd").val()
    }
    $("#database[url]").val( "test");
    var tables;
    $.ajax({
        type : 'Post',
        url : "DatabaseBrowser",
        data : parameters,
        async : false,
        success : function(data){
            tables = data;
        }
    });
    appendTableSelector(tables);
}

function appendTableSelector(tables){
    $("#tableSelector").empty();
    if(tables.tables.length > 0) {
        for(var i = 0 ; i < tables.tables.length; i++){
            var table = tables.tables[i].table;
            var option = "<option value =\"" + table + "\">" + table + "</option>";
            $("#tableSelector").append(option);
        }
    }
}

function getTableColumnInfo(){
    var tableName = $("#tableSelector").val();
    var parameters = {
        database_url: "127.0.0.1",//$("#database[url]").value,
        database_port:$("#database_port").val(),
        database_database:$("#database_database").val(),
        database_user:$("#database_user").val(),
        database_pwd:$("#database_pwd").val(),
        database_tableName:tableName
    }
    var tableColumns;
    $.ajax({
        type:'Post',
        url:"DatabaseBrowser",
        data:parameters,
        async:false,
        success:function(data) {
            tableColumns = data;
        }
    });

    displayColumnsInfo(tableColumns);
}

function displayColumnsInfo(tableColumns){
    var columns = tableColumns.columns;
    if(columns.length > 0){

        var table_dispalyer_div = $("#table_dispalyer_div");
        var tableDisplayer_table = appendTableToDiv(table_dispalyer_div , "tableDisplayer");
        var tableDisplayer_tableHead = appendHeadToTable($("#tableDisplayer") , "tableDisplayerHead");
        var tableDisplayer_tableBody = appendBodyToTable($("#tableDisplayer") , "tableDisplayerBody");

        for(var i = 0 ; i < columns.length ; i ++){
            var columnName = columns[i].columnName;
            var dataType = columns[i].dataType;
            appendCellToTableHead($("#tableDisplayerHead") , columnName);
            appendCellToTableBody($("#tableDisplayerBody") , dataType);
        }
    }
}



function appendTableToDiv(div , tableID){
    div.empty();
    div.append("<table id='" + tableID+ "' frame=box rules='all'></table>");
    /*return div.append("table")
        .attr("frame" , "box")
        .attr("rules" , "all");*/
}

function appendHeadToTable(table , headID){
    return table.append("<tr id='"+ headID +"' align='left'></tr>");
    /*return table.append("tr")
        .attr("align" , "left");*/
}

function appendBodyToTable(table , bodyID ){
    return table.append("<tr id='"+ bodyID +"'align='left'></tr>");
    /*return table.append("tr")
        .attr("align" , "left");*/
}

function appendCellToTableHead(tableHead , cell){
    var tableCell = "<th align=center width=80px>" + cell + "</th>";
    tableHead.append(tableCell);
}

function appendCellToTableBody(tableBody , cell){
    var tableCell = "<td>" + cell + "</td>";
    tableBody.append(tableCell);
}
