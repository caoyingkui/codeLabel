<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="SO.*" %>
<%
  String questionId = "questionId";
  String deletePost = "deletePost";
  String[] APIs;
  String[] salientAPIs;
  String[][] content;
  int index;
  int[] count;

  if (session.isNew() || session.getAttribute(PageParameter.currentAnnotator) == null){
      ServletContext sct= getServletConfig().getServletContext();
      String url = request.getParameter(PageParameter.database_url);
      String port = request.getParameter(PageParameter.database_port);
      String database = request.getParameter(PageParameter.database_database);
      String user = request.getParameter(PageParameter.database_user);
      String pwd = request.getParameter(PageParameter.database_pwd);

      url = "jdbc:mysql://" + url + ":" + port + "/" + database;

      ItemAnnotator annotator = new ItemAnnotator();//new ItemAnnotator(url ,user , pwd );
      //ItemAnnotator annotator = (ItemAnnotator)sct.getAttribute(PageParameter.iniAnnotator);
      session.setAttribute(PageParameter.currentAnnotator, annotator);
      content = annotator.getAllNodes();

      session.setAttribute(PageParameter.getAllItem ,content);
      session.setAttribute(PageParameter.pageIndex,0);
      index = 0;

      //改动 2 改为 5
      if(content[index][5] != null && content[index][5].compareTo("") != 0){
          APIs = content[index][5].split(",");
      }else {
          APIs = null;
      }
  } else {
      content = (String[][])session.getAttribute(PageParameter.getAllItem);

      String addApiName = request.getParameter(PageParameter.addTag);
      if(addApiName != null && addApiName.length() > 0) {
          ItemAnnotator cfr = (ItemAnnotator)session.getAttribute(PageParameter.currentAnnotator);
          index = (int)session.getAttribute(PageParameter.pageIndex);
          cfr.addTag(content[index][0] , addApiName);
          session.setAttribute(PageParameter.getAllItem, cfr.getAllNodes());
      }

      String deleteApiName = (String)request.getParameter(PageParameter.deleteTag);
      if(deleteApiName != null) {
        ItemAnnotator cfr = (ItemAnnotator)session.getAttribute(PageParameter.currentAnnotator);
        index = (int)session.getAttribute(PageParameter.pageIndex);
        cfr.deleteTag(content[index][0] , deleteApiName);

        session.setAttribute(PageParameter.getAllItem, cfr.getAllNodes());
      }

      String deleteSalientApiName = request.getParameter(PageParameter.deleteAnnotation);
      if(deleteSalientApiName != null) {
          ItemAnnotator cfr = (ItemAnnotator)session.getAttribute(PageParameter.currentAnnotator);
          index = (int)session.getAttribute(PageParameter.pageIndex);
          cfr.deleteAnnotation(content[index][0] , deleteSalientApiName);
          session.setAttribute(PageParameter.getAllItem, cfr.getAllNodes());
      }

      String addSalientApiName = (String)request.getParameter(PageParameter.addAnnotation);
      if(addSalientApiName != null) {
          ItemAnnotator cfr = (ItemAnnotator)session.getAttribute(PageParameter.currentAnnotator);
          index = (int)session.getAttribute(PageParameter.pageIndex);
          cfr.addAnnotation(content[index][0], addSalientApiName);

          session.setAttribute(PageParameter.getAllItem, cfr.getAllNodes());
      }

      content = (String[][])session.getAttribute(PageParameter.getAllItem);

		/*if(request.getParameter(pageIndex) != null) {
			int x = (int)session.getAttribute(pageIndex);
			x+= Integer.parseInt(request.getParameter(pageIndex));
			if(x<0) x = 0;
			if(x>content.length-1) x = content.length-1;
			session.setAttribute(pageIndex,x);
		}*/

      if(request.getParameter(PageParameter.jumpTo) != null) {
          int x = Integer.parseInt(request.getParameter(PageParameter.jumpTo));
          session.setAttribute(PageParameter.pageIndex, x);
      }
      if(request.getParameter(deletePost) != null){

          ItemAnnotator cfr = (ItemAnnotator)session.getAttribute(PageParameter.currentAnnotator);
          int deleteIndex = Integer.parseInt(request.getParameter(deletePost));
          cfr.deletePost(content[deleteIndex][0]);
          content = cfr.getAllNodes();
          session.setAttribute(PageParameter.getAllItem , content);
      }

    if(request.getParameter(PageParameter.searchItemIndex) != null) {
      int x = 0;
      try{
        x = Integer.parseInt(request.getParameter(PageParameter.searchItemIndex));
        if(x > content.length-1) x = content.length-1;
      } catch (Exception e){
        x = 0;
      }
      session.setAttribute(PageParameter.pageIndex, x);
    }

    index = (int)session.getAttribute(PageParameter.pageIndex);
    if(content == null){
      ItemAnnotator cfr = (ItemAnnotator)session.getAttribute(PageParameter.currentAnnotator);
      content = cfr.getAllNodes();
    }
    //改动 5 改成 2
    if(content[index][5] != null && content[index][5].compareTo("") != 0){
      APIs = content[index][5].split(",");
    }else {
      APIs = null;
    }
  }

%>
<%--
  public void deletePostItem(){
    ItemAnnotator cfr = (ItemAnnotator)session.getAttribute(PageParameter.currentAnnotator);
    index = (int)session.getAttribute(pageIndex);
    cfr.deletePost(content[index][0]);
    content = cfr.getAllNodes();
    session.setAttribute(allNodes , content);
  }
--%>

<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="label">
  <meta name="author" content="liwp">

  <title>问题分类标注系统</title>

  <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">

  <link href="css/dashboard.css" rel="stylesheet">

  <script src="js/ie-emulation-modes-warning.js"></script>

</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <script src="js/codemirror.js"></script>
  <link rel="stylesheet" href="css/codemirror.css">
  <script src="js/javascript.js"></script>
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="label.jsp">问题分类标注系统</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="label.jsp">dashboard</a></li>
        <li><a href="label.jsp">Settings</a></li>
        <li><a href="label.jsp">Profile</a></li>
        <li><a href="label.jsp">Help</a></li>
      </ul>
      <form class="navbar-form navbar-right" action="label.jsp" method="GET">
        <input type="text" name=<%="\""+ PageParameter.searchItemIndex +"\""%> class="form-control" placeholder="Search...">
      </form>
    </div>
  </div>
</nav>

<div class="container-fluid">
  <div class="row">
    <div class="col-sm-3 col-md-2 sidebar">
      <form method="GET">
        <ul class="nav nav-sidebar">
          <%
            if(APIs != null) {
              int labeled = APIs.length;
              String classifications = "<li><a>Labeled: " + labeled + "</a></li>";
              for (int i = 0; i < APIs.length; i++) {
                classifications += "<li><a style=\"width:80%;color:white;background:"
                        + PageParameter.color(i)
                        + ";display:inline-block\" "
                        + "href=\"label.jsp?"
                        + PageParameter.addAnnotation + "=" + APIs[i]
                        + "&"
                        + PageParameter.pageIndex + "=1\">"
                        + APIs[i]
                        + "</a>"
                        + "<a href= \"label.jsp?"
                        + PageParameter.deleteTag
                        + "="
                        + APIs[i]
                        + "\" style=\"display:inline-block\"><span class=\"glyphicon glyphicon-remove-sign\"></span>"
                        + "</a>"
                        + "</li>";
              }
              out.print(classifications);
            }
          %>
          <li style="padding-top:10px">&nbsp;&nbsp;&nbsp;&nbsp;+&nbsp;&nbsp;<input type="text" name=<%="\""+ PageParameter.addTag +"\""%>  placeholder="new"></li>
          <li style="padding-top:10px"><a type ="button"  href=<%="\"label.jsp?"+ deletePost + "=" + index +"\""%>>删除</a></li>

        </ul>

      </form>
    </div>
    <!-- 显示所有的内容!-->
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
      <h1 class="page-header">Schedule</h1>

      <div class="container-fluid">
        <%
          String displayOneStart= "<a type=\"button\" "
                  +	"class=\"pull-left btn placeholders btn-default\"";
          String colorDesignStart = "style=\"background:";
          String colorDesignEnd = ";color:white\"";
          String displayOneEnd= "</a>";
          String link = " href=\"label.jsp?"
                  +	PageParameter.jumpTo
                  +	"=";

          int pageSize = 100;


          String displayAll = "";
          int firstOne = (int)session.getAttribute(PageParameter.pageIndex);
          if(firstOne < 0 )
            firstOne = 0;
          firstOne = firstOne / pageSize * pageSize;
          int endOne = content.length;
          if(endOne > firstOne + pageSize) {
            endOne = firstOne + pageSize;
          }
          if(firstOne != 0){
            displayAll += displayOneStart;
            displayAll += link + (firstOne - 1) + "\">" + "<<<" + displayOneEnd;
          }
          for(int i=firstOne;i<endOne;i++) {
            displayAll += displayOneStart;
            if(i == index){
              displayAll += colorDesignStart;
              displayAll += PageParameter.color(19);
              displayAll += colorDesignEnd;
            }
            //说明post有标记salient元素
            //改动 2改成5
            else if(content[i][5] != null && content[i][5].length() > 0) {
              displayAll += colorDesignStart;
              displayAll += PageParameter.color(18);
              displayAll += colorDesignEnd;
            }
            displayAll += link + i + "\">" + i + displayOneEnd;

          }
          if(endOne != content.length){
            displayAll += displayOneStart;
            displayAll += link + endOne + "\">" + ">>>" + displayOneEnd;
          }
          out.print(displayAll);
        %>
      </div>

      <h2 class="sub-header">
        <form method = "GET" style="display:inline-block">
        </form>
      </h2>
      <div class="table-responsive">

        <div>
          <%
            out.print("<h1>Answer ");
            out.print((int)session.getAttribute(PageParameter.pageIndex));
            //改动
            out.print(":   "+content[(int)session.getAttribute(PageParameter.pageIndex)][0] + "<h1>");// "   " + content[(int)session.getAttribute(PageParameter.pageIndex)][3] + "<h1>");
          %>
        </div>
        <hr>
        <div>
            <!-- 改动  1 ga-->
          <%= content[(int)session.getAttribute(PageParameter.pageIndex)][1] %>
        </div>
        <hr>
          <div>
              <!-- 改动  1 ga-->
              <%= content[(int)session.getAttribute(PageParameter.pageIndex)][4] %>
          </div>
        <p></p>
        <p></p>
        <p></p>
        <p></p>
        <hr>
      </div>
    </div>
  </div>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/docs.min.js"></script>
<script src="js/ie10-viewport-bug-workaround.js"></script>