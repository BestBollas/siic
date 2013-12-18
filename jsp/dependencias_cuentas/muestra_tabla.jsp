<%@page import="control_prezupueztal.Dependencias_Cuentas"%>
<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*,java.text.DecimalFormat, gestion_recursos.adkizizionez.rekiz.*,comun.*,control_prezupueztal.Dependencias_Cuentas.*" errorPage=""%>
<%@ page import="java.text.DecimalFormat" %>
<%
    BD SMBD = new BD();
    Dependencias_Cuentas DECU = new Dependencias_Cuentas();
    ResultSet rs;
    String consultas;
    int anio = Integer.parseInt(request.getParameter("anioFiltro"));
    int variable = 0;
    int bandera = 0;
    String subStrNomCuenta="";
    DECU.anio=anio;
    consultas = "SELECT id_cuenta,anio,cuenta,padre,nombre_cuenta "
                +"FROM sic.DEPENDENCIAS_CUENTAS "
                +"WHERE (padre=0 AND anio="+anio+")";
    //consultas="SELECT id_cuenta,anio,cuenta,padre,nombre_cuenta FROM sic.DEPENDENCIAS_CUENTAS WHERE padre=0 AND anio="+anio;
    rs = SMBD.SQLBD2(consultas);
    while (rs.next()) {
    subStrNomCuenta=rs.getString(5).replace(" ","-");
        variable = rs.getInt(1);
        bandera += 1;
%>
<tr aling="center">
    <td class="<%=variable%>"><%=bandera%></td>
    <td><%=rs.getInt(2)%></td>
    <td><%=rs.getString(3)%></td>
    <td><%=subStrNomCuenta%></td>
    <td><a id="linkver<%=variable%>" href="javascript:llenar_hijos_tabla(<%=variable%>,<%=rs.getInt(2)%>,'<%=subStrNomCuenta%>');">Ver hijos</a>
                    <a id="linkOcultar<%=variable%>"style="display:none" href="javascript:ocultar_tabla_hijos(<%=variable%>);">Ocultar hijos</a>
    </td>
    <td width="10px">
        <img src="../../imagenes/ikonoz/nuevo.JPG" width="20px" height="20px" title="Nuevo" onclick="linkNuevo(<%= rs.getInt(1)%>,<%=rs.getInt(2)%>, '<%= rs.getString(3)%>',<%= rs.getInt(4)%>, '<%=subStrNomCuenta%>');">
    </td>
    <td  width="10px">
        <img src="../../imagenes/ikonoz/editar.png" width="15px" height="15px" title="Editar" onclick="linkEditar(<%= rs.getInt(1)%>,<%=rs.getInt(2)%>, '<%= rs.getString(3)%>',<%= rs.getInt(4)%>, '<%=subStrNomCuenta%>');"/>
    </td>
    <td  width="10px">
        <img src="../../imagenes/ikonoz/eliminar.JPG" width="20px" height="20px" title="Eliminar" onclick="linkEliminar(<%= rs.getInt(1)%>,<%=rs.getInt(2)%>, '<%= rs.getString(3)%>',<%= rs.getInt(4)%>, '<%=subStrNomCuenta%>');"/>
    </td>
</tr>
<tr>
    <td colspan="8" align="center" width="95%" style="text-aling:center;">
        <div id="<%=variable%>">

        </div>
    </td>
</tr>
<%
}
SMBD.desconectarBD();
%>