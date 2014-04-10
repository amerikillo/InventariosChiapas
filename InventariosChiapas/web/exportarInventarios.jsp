<%-- 
    Document   : exportarInventarios
    Created on : 01-abr-2014, 13:42:01
    Author     : Americo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ConectionDB con = new ConectionDB();
    response.setContentType ("application/vnd.ms-excel"); 
    response.setHeader ("Content-Disposition", "attachment;filename=\"Inventarios Chiapas.xls\"");

    %>
    <table border="1">
        <tr>
            <td>Clave Unidad</td>
            <td>Nombre Unidad</td>
            <td>Clave Producto</td>
            <td>Descripcion</td>
            <td>Caducidad</td>
            <td>Cantidad</td>
            <td>Fec. Elaboracion</td>
        </tr>
        <%
    try{
        con.conectar();
        ResultSet rset = con.consulta("select u.id_uni, u.nombre_gnk, i.cla_pro, c.descrip, i.cad_pro, i.cant, i.fecha from tb_unidades u, inventarios i, clave_med c where i.id_uni = u.id_uni and i.cla_pro = c.clave");
        while(rset.next()){
            %>
            <tr>
            <td><%=rset.getString(1)%></td>
            <td><%=rset.getString(2)%></td>
            <td><%=rset.getString(3)%></td>
            <td><%=rset.getString(4)%></td>
            <td><%=rset.getString(5)%></td>
            <td><%=rset.getString(6)%></td>
            <td><%=rset.getString(7)%></td>
            </tr>
            <%
        }
        con.cierraConexion();
    }catch (Exception e){
        
    }
%>
    </table>
    