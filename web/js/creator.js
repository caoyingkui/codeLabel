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
    displayColumnOptionsInfo(tableColumns);
    displayLabelSourceOptionInfo(tableColumns);
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

function displayColumnOptionsInfo(tableColumns){
    var columns = tableColumns.columns;

    for(var i = 0 ; i < columns.length ; i ++){
        var columnName = columns[i].columnName;
        appendOptionToDispalyElements($("#dispaly_element_selector_div") , columnName)
    }
}

function displayLabelSourceOptionInfo(tableColumns){
    var columns = tableColumns.columns;
    $("#labelSourceSelector").empty();
    appendOptionToLabelSource($("#labelSourceSelector") , "default");
    appendOptionToLabelSource($("#labelSourceSelector") , "labelResult");

    for(var i = 0 ; i < columns.length ; i++){
        var columnName = columns[i].columnName;
        appendOptionToLabelSource($("#labelSourceSelector") , columnName);
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

function appendOptionToDispalyElements(div , option){
    var optionDiv =
        "<div class='col-md-4 col-sm-4'>" +
            "<p>" +
                "<input type='checkbox' class='columnOption' id='"+ option+"'/>" + option +
            "</p>" +
         "</div>" ;
    div.append(optionDiv);
}

function appendOptionToLabelSource(select , option){
    var _option = "<option value='" + option +"'>" + option + "</option>";
    select.append(_option);
}

function getDispalyElements(){

    var elements = $("div.displayElement>div>p").find('input');
    var result = "";
    for(var i = 1 ; i < elements.length ; i++){
        if(elements[i].checked ) {
            result = result + "," + elements[i].id;
        }
    }
    if(elements.length > 0)
        result = elements[0].id + result ;
    return result;
}


function constructLabelTask(){

    var sqlUrl = "jdbc:mysql://" + $("#database_url").val() + ":" + $("#database_port").val() + "/" + $("#database_database").val();
    var sqlUser = $("#database_user").val();
    var sqlPwd = $("#database_pwd").val();
    var tableName = $("#tableSelector option:selected").val();
    var displayElements = getDispalyElements();
    var labelColumn = $("#labelSourceSelector option:selected").val();

    var parameter = {
        "sqlUrl": sqlUrl ,
        "sqlUser" : sqlUser,
        "sqlPwd" : sqlPwd,
        "tableName":tableName,
        "displayElements" : displayElements,
        "labelColumn" : labelColumn
    }
    $.ajax({
        type:'Post',
        url: "ConstructLabelTask",
        data:parameter ,
        async: false,
        success:function(data){
            window.location.href = "label.jsp";
        }
    });

}