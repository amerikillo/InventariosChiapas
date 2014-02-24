*<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
         import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" session="true"%>
<%
    HttpSession sesion = request.getSession();
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
    String val = "", user = "";

    if (sesion.getAttribute("valida") != null) {
        val = (String) sesion.getAttribute("valida");
        user = (String) sesion.getAttribute("usuario");
    }

//out.print(user);
    if (!val.equals("valido")) {

%>
<script>self.location = '../index.jsp';</script>
<%        }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    /**
     * -----------------------------------------------------------------------------------------------------------------------------
     * ARCHIVO: inven.jsp FUNCIÓN: Muestra los inventarios según la unidad que
     * se haya escogido- nayarit 2013 CONECTOR Y DBMS: JDBC Y MySQL DISEÑO Y
     * AUTOR : RHW
------------------------------------------------------------------------------------------------------------------------------
     */
// Conexión a la BDD ------------------------------------
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection conn = null;
    conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica", "receta_usr", "M8KbqNjTD2");
    Statement stmt = conn.createStatement();
    ResultSet rset = null;
    ResultSet rset_date = null;
// ------------------------------------------------------
// Variables de entorno ---------------------------------
    NumberFormat nf1 = NumberFormat.getInstance(Locale.US);
    String juri_jv = "";
    String ran1_jv = "";
    String ran2_jv = "";
    String ban_jv = "";
    String ran1 = "";
    String ran2 = "";
    String mpio_jv = "";
    String valor_jv = "", piezas = "", min = "", max = "";
    String uni_jv = "", mes_jv = "", name_jv = "", fecha = "", mensaje = "", cadu = "", fecha1 = "";

    int piezas2 = 0, piezas3 = 0, min2 = 0, min3 = 0, max2 = 0, max3 = 0;
    int suma_cant = 0;
    int suma_min = 0;
    int suma_max = 0;
// ------------------------------------------------------
// try para obtener los datos como parámtros ------------
    try {
        uni_jv = request.getParameter("uni");
        fecha1 = request.getParameter("fecha");

    } catch (Exception e) {
        System.out.print("not");
    }
    rset = stmt.executeQuery("select dp.cla_pro as cv_med, p.des_pro as descrip, i.cant as cant, i.fec_ela as f_elabo, dp.lot_pro as lote, dp.cad_pro as caducidad from receta_electronica.jurisdicciones as j, receta_electronica.municipios as m,  receta_electronica.unidades as u, receta_electronica.inventarios_rurales as i, receta_electronica.detalle_productos as dp, receta_electronica.productos as p where   j.cla_jur = m.cla_jur AND m.cla_mun = u.cla_mun AND u.cla_uni = i.cla_uni AND p.cla_pro = dp.cla_pro AND dp.det_pro = i.det_pro AND i.cla_uni = '" + uni_jv + "' and i.fec_ela = '" + fecha1 + "' ;");
// fin bloque try ---------------------------------------
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>:: INVENTARIOS ::</title>
        <style type="text/css">
            <!--
            .style1 {color: #FFFFFF}
            .style2 {
                font-size: 11px;
                font-family: Arial, Helvetica, sans-serif;
            }
            .style4 {color: #FFFFFF; font-size: 11px; font-family: Arial, Helvetica, sans-serif; }
            .style5 {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 18px;
                color: #006;
                font-weight: bold;
            }
            .FECHA {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 14px;
                font-weight: bold;
                color: #333;
            }
            -->
        </style>
        <link href="../css/data_table.css" rel="stylesheet" type="text/css" />
        <link href="../css/demo_table_jui.css" rel="stylesheet" type="text/css" />
        <script src="../Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="../Scripts/jquery.dataTables.columnFilter.js" type="text/javascript"></script>
        <script src="../Scripts/jquery.dataTables.pagination.js" type="text/javascript"></script>
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
        <script type="text/xml">
        <!--
        <oa:widgets>
          <oa:widget wid="2586523" binding="#dataTable" />
        </oa:widgets>
        -->
        </script>
    </head>

    <body>
        <div align="center">
            <table width="837" cellpadding="0" cellspacing="0">
                <col width="137" />
                <col width="80" span="2" />
                <col width="107" />
                <col width="101" />
                <col width="120" />
                <col width="80" span="2" />
                <tr height="20">
                    <td height="20" colspan="2"><div align="center" class="style5"><a name="arriba" id="arriba"></a>INVENTARIO POR    UNIDAD </div></td>
                </tr>
                <tr height="20">
                    <td height="20" colspan="2"><div align="center" class="style5">PROYECTO CENSOS NAYARIT</div></td>
                </tr>
                <tr height="20">
                    <td height="20" colspan="2"><div align="left"><a href="menu_inven.jsp" class="style2">Regresar a Menú</a></div></td>
                </tr>
                <%
                    String des_uni = "";
                    rset = stmt.executeQuery("select des_uni from unidades where cla_uni = '" + uni_jv + "'");
                    while (rset.next()) {
                        des_uni = rset.getString("des_uni");
                    }
                %>
                <tr height="20">
                    <td width="568" height="20" class="style2"><span class="negritas">Unidad Seleccionada:</span>&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;&nbsp; <%=des_uni%> <br />
                            FECHA DE TOMA DE INVENTARIO A LA FECHA: <span class="rojo"><%=fecha1%> (AAAA/MM/DD)</span></strong></td>
                    <td width="267" height="20" align="right" class="style2"><span class="neg2">Exportar</span> <img src="../imagen/exc.jpg" alt="Importar a Excel" width="41" height="29" usemap="#mapa_exp" border="0" /></td>
                </tr>
                <tr height="20">
                    <td height="20" colspan="2" class="style2"><!--a href="#abajo">Ir a Totales</a--> </td>
                </tr>
            </table>
            <table width="840" height="56" border="1" cellpadding="0" cellspacing="0">
                <col width="137" />
                <col width="80" span="2" />
                <col width="107" />
                <col width="101" />
                <col width="120" />
                <col width="80" span="2" />

                <tr height="20">
                    <td class="style2">
                        <%
                            rset = stmt.executeQuery("select dp.cla_pro as cv_med, p.des_pro as descrip, sum(i.cant) as cant, i.fec_ela as f_elabo, dp.lot_pro as lote, dp.cad_pro as caducidad from receta_electronica.jurisdicciones as j, receta_electronica.municipios as m,  receta_electronica.unidades as u, receta_electronica.inventarios_rurales as i, receta_electronica.detalle_productos as dp, receta_electronica.productos as p where   j.cla_jur = m.cla_jur AND m.cla_mun = u.cla_mun AND u.cla_uni = i.cla_uni AND p.cla_pro = dp.cla_pro AND dp.det_pro = i.det_pro AND i.cla_uni = '" + uni_jv + "'  and i.fec_ela = '" + fecha1 + "' group by dp.cla_pro ;");

                        %>
                        <table width="97%" border="0" cellpadding="0" cellspacing="0" id="dataTable">
                            <thead>
                                <tr>
                                    <th colspan="5" class="FECHA" ><hr /></th>
                                </tr>
                                <tr>
                                    <th width="7%" class="FECHA" >CLAVE</th>
                                    <th width="51%" class="FECHA">DESCRIPCI&Oacute;N</th>
                                    <th width="14%" class="FECHA">LOTE</th>
                                    <th width="16%" class="FECHA">CADUCIDAD</th>
                                    <th width="12%" class="FECHA">EXISTENCIAS</th>
                                </tr>
                                <tr>
                                    <th colspan="5" class="FECHA" ><hr /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <!--Loop start, you could use a repeat region here-->
                                <%      while (rset.next()) {
                                        Connection conn_cadu = null;
                                        conn_cadu = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica", "receta_usr", "M8KbqNjTD2");
                                        Statement stmt_cadu = conn_cadu.createStatement();
                                        suma_cant += (suma_cant = Integer.parseInt(rset.getString("cant")));
                                        fecha = rset.getString("f_elabo");
                                        cadu = rset.getString("caducidad");
                                        if (!cadu.equals("-")) {
                                            if (cadu.equals("1900-01-01")) {
                                                cadu = "S/C";
                                            } else {
                                                rset_date = stmt_cadu.executeQuery("SELECT DATE_FORMAT('" + cadu + "', '%d/%m/%Y')");
                                                if (rset_date.next()) {
                                                    cadu = rset_date.getString("DATE_FORMAT('" + cadu + "', '%d/%m/%Y')");
                                                }
                                            }
                                        }
                                %> 
                                <tr height="20">
                                    <td class="negritas" align="center"><%=rset.getString("cv_med")%></td>
                                    <td class="negritas" ><%=rset.getString("descrip")%></td>
                                    <td class="negritas" align="center"><%=rset.getString("lote")%></td>
                                    <td class="negritas" align="center"><%=cadu%></td>
                                    <td colspan="3" align="center" class="negritas"><%=rset.getString("cant")%></td>
                                </tr>
                                <%conn_cadu.close();
                                    } // fin de while

                                %>
                                <!--Loop end-->
                            </tbody>
                        </table>


                    </td>
                </tr>
            </table>
            <map name="mapa_exp" id="mapa_exp">
                <area shape="rect" coords="5,3,40,27" href="impor_inv.jsp?uni=<%=uni_jv%>&fecha=<%=fecha1%>" />
            </map>
        </div>
        <h5 align="center">TOTAL DE PIEZAS EN EL INVENTARIO:<span class="style5"> <%=nf1.format(suma_cant)%></span></h5>
        <h6 align="center" class="gray"><strong>DERECHOS RESERVADOS GNKL/DESARROLLOS WEB ® 2009 - 2013</strong></h6>

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

        <%
            // ----- try que cierra la conexión a la base de datos
            try {
                // Se cierra la conexión dentro del try
                conn.close();
            } catch (Exception e) {
                mensaje = e.toString();
            } finally {
                if (conn != null) {
                    conn.close();
                    if (conn.isClosed()) {
                        mensaje = "desconectado2";
                    }
                }
            }
                                //out.print(mensaje);
            // ---- fin de la conexión	 	  

        %>
        </table>
    </body>
</body>
</html>
