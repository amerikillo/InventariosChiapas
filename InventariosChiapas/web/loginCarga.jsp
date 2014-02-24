<%-- 
    Document   : index
    Created on : 27-oct-2013, 20:24:40
    Author     : amerikillo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>
<%
    ConectionDB con = new ConectionDB();
    Consultas cons = new Consultas();

    /*con.conectar();
     ResultSet rset = con.consulta(cons.obtiene_unidades());
     while (rset.next()){
        
     }
     con.cierraConexion();*/
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <title>:: Inventarios Rurales Chiapas ::</title>
    </head>
    <body>
        <!-- Fixed navbar -->
        <div class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp">Inventarios Rurales Chiapas</a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="consulta.jsp">Consulta</a></li>
                        <li><a href="loginCarga.jsp">Subir Inventarios</a></li>
                        <li><a href="#contact">Sistemas</a></li>
                        <!--li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li class="dropdown-header">Nav header</li>
                                <li><a href="#">Separated link</a></li>
                                <li><a href="#">One more separated link</a></li>
                            </ul>
                        </li-->
                    </ul>
                    <!--ul class="nav navbar-nav navbar-right">
                        <li><a href="../navbar/">Default</a></li>
                        <li><a href="../navbar-static-top/">Static top</a></li>
                        <li class="active"><a href="./">Fixed top</a></li>
                    </ul-->
                </div><!--/.nav-collapse -->
            </div>
        </div>

        <!-- Cuerpo de la pagina -->
        <div class="container">
            <h1>Plantilla de Proyectos!</h1>
            <form action="Login">
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-lg-2">
                            Usuario:
                        </div>
                        <div class="col-lg-3">
                            <input type="text" class="form-control" name="name" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-2">
                            Contraseña:
                        </div>
                        <div class="col-lg-3">
                            <input type="password" class="form-control" name="pass"  />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <button class="btn btn-block" type="submit" name="accion" value="login">Enviar</button>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Los Botones tendran la siguiente forma -->
        </div>

        <div class="navbar navbar-default navbar-fixed-bottom">
            <div class="container">
                <div class="text-center text-muted">
                    Derechos Reservardos <span class="glyphicon glyphicon-registration-mark"></span>
                </div>
            </div>
        </div>
    </body>
</html>

<!-- 
================================================== -->
<!-- Se coloca al final del documento para que cargue mas rapido -->
<!-- Se debe de seguir ese orden al momento de llamar los JS -->
<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>