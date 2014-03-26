<%-- 
    Document   : index
    Created on : 27-oct-2013, 20:24:40
    Author     : amerikillo
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>
<%
    ConectionDB con = new ConectionDB();
    Consultas cons = new Consultas();

    DecimalFormat format = new DecimalFormat("###,###,###");
    int can=0;
    /*con.conectar();
     ResultSet rset = con.consulta(cons.obtiene_unidades());
     while (rset.next()){
        
     }
     con.cierraConexion();*/
    try {
        con.conectar();
        ResultSet rset = con.consulta("select cla_pro from inventarios where cla_pro not in (select clave from clave_med);");
        while (rset.next()) {
            con.ejecuta("insert into clave_med values ('0', '0', '" + rset.getString("cla_pro") + "', 'Sin descripcion', '-', '-', '-')");
        }
        con.cierraConexion();
    } catch (Exception e) {
    }
    String nom_gnk = "", fecha = "", canti = "";
    try {
        con.conectar();
        ResultSet rset = con.consulta("select u.nombre_gnk, i.fecha, sum(i.cant) as cant from tb_unidades u, inventarios i where i.id_uni = '" + request.getParameter("unidad") + "' and u.id_uni = i.id_uni");
        while (rset.next()) {
            nom_gnk = rset.getString("nombre_gnk");
            fecha = rset.getString("fecha");
            canti = rset.getString("cant");
            canti = ""+format.format(Integer.parseInt(canti));
        }
        con.cierraConexion();
    } catch (Exception e) {
    }
    if (nom_gnk == null) {
        nom_gnk = "";
        fecha = "";
        canti = "";
    }
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
        <link href="css/data_table.css" rel="stylesheet" type="text/css" />
        <link href="css/demo_table_jui.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            /* BeginOAWidget_Instance_2586523: #dataTable */

            @import url("../css/custom/base/jquery.ui.all.css");
            #dataTable {padding: 0;margin:0;width:100%;}
            #dataTable_wrapper{width:100%;}
            #dataTable_wrapper th {cursor:pointer} 
            #dataTable_wrapper tr.odd {color:#000; background-color:#FFF}
            #dataTable_wrapper tr.odd:hover {color:#333; background-color:#CCC}
            #dataTable_wrapper tr.odd td.sorting_1 {color:#000; background-color:#999}
            #dataTable_wrapper tr.odd:hover td.sorting_1 {color:#000; background-color:#666}
            #dataTable_wrapper tr.even {color:#FFF; background-color:#666}
            #dataTable_wrapper tr.even:hover, tr.even td.highlighted{color:#EEE; background-color:#333}
            #dataTable_wrapper tr.even td.sorting_1 {color:#CCC; background-color:#333}
            #dataTable_wrapper tr.even:hover td.sorting_1 {color:#FFF; background-color:#000}

            /* EndOAWidget_Instance_2586523 */
            tam14 {
                font-size: 14px;
            }
            .negritas {
                font-weight: bold;
            }
            .rojo {
                color: #900;
            }
            .FECHA {
                font-size: 12px;
            }
            .gray {
                color: #CCC;
            }
            .gray strong {
                color: #999;
            }
            .neg2 {
                font-weight: bold;
            }
        </style>
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
                        <li class="active"><a href="http://166.78.128.202:8080/CensosChia/indexMain.jsp">Menú</a></li>
                        <li><a href="consulta.jsp">Consulta</a></li>
                        <li><a href="http://166.78.128.202:8080/CensosChia/">Salir</a></li>
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
            <h1>Consulta de Inventarios</h1>
            <h5>Seleccione la unidad a consultar su inventario</h5>
            <!-- Los Botones tendran la siguiente forma -->
            <form name="form" method="post">
                <div class="form-group form-horizontal">
                    <div class="col-sm-1 form-horizontal">
                        Jurisdicción:
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control form-horizontal" name="jurisdiccion" id = "jurisdiccion" onchange="rellenaUni();">
                            <option value ="">Seleccione Jurisdicción</option>
                            <%
                                try {
                                    con.conectar();
                                    int no_jur = 1;
                                    ResultSet rset = con.consulta("select tu.juris from tb_unidades tu, inventarios i where i.id_uni = tu.id_uni group by tu.juris order by tu.juris asc;");
                                    while (rset.next()) {
                                        //out.println("<option value ='J"+no_jur+"'>"+rset.getString(1)+"</option>");
                                        String var[] = rset.getString(1).split(" ");
                                        out.println("<option value ='J" + var[2] + "'>" + rset.getString(1) + "</option>");
                                        //no_jur++;
                                    }
                                    //no_jur=0;
                                    con.cierraConexion();
                                } catch (Exception e) {
                                }
                            %>
                            <!--option value ="J1">Jurisdicción Sanitaria 1</option>
                            <option value ="J2">Jurisdicción Sanitaria 2</option>
                            <option value ="J3">Jurisdicción Sanitaria 3</option>
                            <option value ="J4">Jurisdicción Sanitaria 4</option>
                            <option value ="J5">Jurisdicción Sanitaria 5</option>
                            <option value ="J6">Jurisdicción Sanitaria 6</option>
                            <option value ="J7">Jurisdicción Sanitaria 7</option>
                            <option value ="J8">Jurisdicción Sanitaria 8</option>
                            <option value ="J9">Jurisdicción Sanitaria 9</option>
                            <option value ="J10">Jurisdicción Sanitaria 10</option-->
                        </select>
                    </div>
                    <div class="col-sm-1 form-horizontal">
                        Unidad
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control form-horizontal" name="unidad" id="unidad" >
                            <option>Unidad</option>
                        </select>
                    </div>
                    <div class="col-sm-2 form-horizontal">
                        <button class="btn btn-block btn-primary" type="submit">Consultar</button>
                    </div>
                </div>
                <br /><br /><br />
                <div class="form-group form-horizontal">
                    <div class="col-sm-1 form-horizontal">
                        Unidad
                    </div>
                    <div class="col-sm-5">
                        <input class="form-control" type="text" value="<%=nom_gnk%>" />
                    </div>
                    <div class="col-sm-1 form-horizontal">
                        Cantidad de piezas
                    </div>
                    <div class="col-sm-2">
                        <input class="form-control" type="text" value="<%=canti%>" />
                    </div>
                    <div class="col-sm-1 form-horizontal">
                        Fecha de Captura
                    </div>
                    <div class="col-sm-2">
                        <input class="form-control" type="text" value="<%=fecha%>" />
                    </div>
                </div>
                <br /><br />
            </form>

            <table width="" border="0" cellpadding="0" cellspacing="0" id="dataTable">
                <thead>
                <th width="7%" class="FECHA" >CLAVE</th>
                <th width="51%" class="FECHA">DESCRIPCI&Oacute;N</th>
                <th width="16%" class="FECHA">CADUCIDAD</th>
                <th width="12%" class="FECHA">EXISTENCIAS</th>
                </thead>
                <tbody>
                    <!--Loop start, you could use a repeat region here-->
                    <%                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select i.cla_pro, i.lot_pro, i.cad_pro, sum(i.cant) as cant, c.descrip from inventarios i, clave_med c where i.cla_pro = c.clave and i.id_uni = '" + request.getParameter("unidad") + "' group by i.cla_pro, i.lot_pro, i.cad_pro");
                            while (rset.next()) {
                    %>
                    <tr height="20">
                        <td class="negritas" align="center"><%=rset.getString("cla_pro")%></td>
                        <td class="negritas" ><%=rset.getString("descrip")%></td>
                        <td class="negritas" align="center"><%=rset.getString("cad_pro")%></td>
                        <td colspan="3" align="center" class="negritas"><%=format.format(Integer.parseInt(rset.getString("cant")))%></td>
                    </tr>
                    <%
                            }
                            con.cierraConexion();
                        } catch (Exception e) {

                        }
                    %>
                    <!--Loop end-->
                </tbody>
            </table>
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
<script src="js/jquery.dataTables.js" type="text/javascript"></script>
<script src="js/jquery.dataTables.columnFilter.js" type="text/javascript"></script>
<script src="js/jquery.dataTables.pagination.js" type="text/javascript"></script>
<script type="text/javascript">
// BeginOAWidget_Instance_2586523: #dataTable

                            $(document).ready(function() {
                                oTable = $('#dataTable').dataTable({
                                    "bJQueryUI": true,
                                    "bScrollCollapse": false,
                                    "sScrollY": "400px",
                                    "bAutoWidth": true,
                                    "bPaginate": true,
                                    "sPaginationType": "two_button", //full_numbers,two_button
                                    "bStateSave": true,
                                    "bInfo": true,
                                    "bFilter": true,
                                    "iDisplayLength": 25,
                                    "bLengthChange": true,
                                    "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todos"]]
                                });
                            });

// EndOAWidget_Instance_2586523
</script>
<script>
    function rellenaUni() {

        removeAllOptions(document.form.unidad);



        if (document.form.jurisdiccion.value === 'J1') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 1' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>

        }

        if (document.form.jurisdiccion.value === 'J2') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 2' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>

        }
        if (document.form.jurisdiccion.value === 'J3') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 3' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>
        }
        if (document.form.jurisdiccion.value === 'J4') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 4' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>
        }
        if (document.form.jurisdiccion.value === 'J5') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 5' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>
        }
        if (document.form.jurisdiccion.value === 'J6') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 6' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>
        }
        if (document.form.jurisdiccion.value === 'J7') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 7' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>
        }
        if (document.form.jurisdiccion.value === 'J8') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 8' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>

        }
        if (document.form.jurisdiccion.value === 'J9') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 9' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>

        }
        if (document.form.jurisdiccion.value === 'J10') {
    <%        try {
            con.conectar();
            ResultSet rset = con.consulta("select u.juris, u.id_uni, u.nombre_gnk from tb_unidades u, inventarios i where u.id_uni = i.id_uni and u.juris='JURISDICCION SANITARIA 10' group by u.id_uni;");
            while (rset.next()) {
                out.println("addOption(document.form.unidad, '" + rset.getString("id_uni") + "', '" + rset.getString("nombre_gnk") + "');");

            }
            con.cierraConexion();
        } catch (Exception e) {
        }

    %>
        }
    }

    function removeAllOptions(selectbox)
    {
        var i;
        for (i = selectbox.options.length - 1; i >= 0; i--)
        {
            //selectbox.options.remove(i);
            selectbox.remove(i);
        }
    }

    function addOption(selectbox, value, text)
    {
        var optn = document.createElement("OPTION");
        optn.text = text;
        optn.value = value;

        selectbox.options.add(optn);
        //putString(optn.valueoptions
        // var cad2= document.form1.SubCat.value;

    }
</script>