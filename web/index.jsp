
<!DOCTYPE html>
<html class="no-js">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <title>标注系统创建界面</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/labelCreatorPage.css">
        

        <!-- Js -->
        <script src="js/vendor/modernizr-2.6.2.min.js"></script>
        <script src="js/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>
        <script src="js/wow.min.js"></script>
        <script src="js/validation.js"></script>
        <script src="js/creator.js"></script>
        <script>
         new WOW(
            ).init();
        </script>

        

    </head>
    <body>

    <header>
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-xs-6 col-sm-3">
                    <a href="#" class="logo">
                        <img src="images/logo.png" alt="">
                    </a>
                </div>
                <div class="col-md-6 col-xs-6 col-sm-6">
                    <div class="menu">
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="container-fluid">
                                <!-- Brand and toggle get grouped for better mobile display -->
                                <div class="navbar-header">
                                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    </button>
                                </div>

                                <!-- Collect the nav links, forms, and other content for toggling -->
                                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                                    <ul class="nav navbar-nav">
                                        <li><a href="#banner">Home</a></li>
                                        <li><a href="#service">Service</a></li>
                                        <li><a href="#feature">Feature</a></li>
                                        <li><a href="#utility">Utility</a></li>
                                        <li><a href="#subscribe">Subscribe</a></li>
                                    </ul>
                                  
                                </div><!-- /.navbar-collapse -->
                            </div><!-- /.container-fluid -->
                        </nav>
                    </div>
                </div>
                <div class="col-md-3 col-xs-12 col-sm-3">
                    <ul class="social-info">
                        <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                        <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                        <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>

    <section id="banner" class="wow fadeInUp">
        <div class="container col-md-11 col-sm-11" style="margin-left:20px;margin-right:20px">

            <div id="databaseSelectSection"class="col-md-4 col-sm-4" >
                <h1>
                    创建标注
                </h1>
                <div class="col-md-6 col-sm-6">
                    <div class="col-md-12 col-sm-12">
                        <dl class="form">
                            <dd>
                                <lable class="form-label text-gray f5" for="database_url">Database URL</lable>
                                <input type="text" name="database_url" id="database_url" class="form-control form-control-lg input-block" value="127.0.0.1" placeholder="127.0.0.1"></input>
                            </dd>
                        </dl>
                        <dl class="form">
                            <dd>
                                <label class="form-label text-gray f5" for="database_port">Port</label>
                                <input type="text" name="database_port" id="database_port" class="form-control form-control-lg input-block" value="3306" placeholder="3306"></input>
                            </dd>
                        </dl>
                        <dl class="form">
                            <dd>
                                <label class="form-lable text-gray f5" for="database_database">Database</label>
                                <input type="text" name="database_database]" id="database_database" class="form-control form-control-lg input-block" value="stackoverflow" placeholder="database"></input>
                            </dd>
                        </dl>
                        <dl class="form">
                            <dd>
                                <lable class="form-label text-gray f5" for="database_user">User</lable>
                                <input type="text" name="database_user" id="database_user" class="form-control form-control-lg input-block" value="root" placeholder="user name"></input>
                            </dd>
                        </dl>
                        <dl class="form">
                            <dd>
                                <lable class="form-label text-gray f5" for="database_pwd">Password</lable>
                                <input type="password" name="database_pwd" id="database_pwd" class="form-control form-control-lg input-block" placeholder="pwd"></input>
                            </dd>
                        </dl>
                        <dl class="form">
                            <button onclick="getTables();" class="btn btn-primary btn-large f4 btn-block" >建立</button>
                        </dl>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6" style="margin:20px;">
                <hr>
                <dl class="form">
                    <dd>
                        <h4>SELECT TABLE</h4>
                        <div id="table_selector_div" class=" col-md-12 col-sm-12 example">
                            <label style="height:30px">Table List:</label>
                            <select id="tableSelector" style="height:30px" class="form-control-lg input-block">
                                <option value="default">default</option>
                            </select>
                            <input type="button" class="btn btn-info btn-sm" onclick="getTableColumnInfo();" value="select" style="width:120px;height:30px;margin-left:100px">
                        </div>
                    </dd>
                </dl>
                <hr>
                <dl class="form">
                    <dd>
                        <h4>TABLE COLUMS</h4>
                        <div id="table_dispalyer_div" class="col-md-12 col-sm-12">
                            <!--<table id="tableDisplayer"  frame=box rules=all>
                                <tr align="left">
                                    <th align=center width=80px>Month</th>
                                    <th width=80px>Saving</th>
                                </tr>
                                <tr align="center">
                                    <td>January</td>
                                    <td>￥11</td>
                                </tr>
                            </table>-->
                        </div>
                    </dd>
                </dl>
                <hr>
                <dl class="form">
                    <dd>
                        <h4>SELECT DISPLAY ELEMENTS</h4>
                        <div id="dispaly_element_selector_div" class="displayElement col-md-12 col-sm-12">
                           <!--<div class="col-md-4 col-sm-4">
                                <p><input type="checkbox" checked="checked" style="margin-right:10px" /> test1</p>
                            </div>

                            <div class="col-md-4 col-sm-4">
                                <p><input type="checkbox" checked="checked" style="margin-right:10px" /> test2</p>
                            </div>

                            <div class="col-md-4 col-sm-4">
                                <p><input type="checkbox" checked="checked" style="margin-right:10px" /> test3</p>
                            </div>-->
                        </div>
                    </dd>
                </dl>
                <hr>
                <dl class="form">
                    <dd>
                        <h4>SELECT LABELS SOURCE COLUM</h4>
                        <div id="labels_source_div" class="col-md-12 col-sm-12">
                            <div class="col-md-6 col-sm-6">
                                <select id="labelSourceSelector">
                                    <option value="default">default</option>
                                </select>
                            </div>
                        </div>
                    </dd>
                </dl>

                <dl>
                    <dd>
                        <input type="button" class="btn btn-info btn-sm" onclick="constructLabelTask();" value="创建" style="width:120px;height:30px;margin-left:100px">
                    <dd>
                </dl>
                <hr>
            </div>
        </div>
    </section>

</body>
</html>
