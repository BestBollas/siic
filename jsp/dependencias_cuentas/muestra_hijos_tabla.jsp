<%@page import="control_prezupueztal.Dependencias_Cuentas"%>
<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*,java.text.DecimalFormat, gestion_recursos.adkizizionez.rekiz.*,comun.*,control_prezupueztal.Dependencias_Cuentas.*" errorPage=""%>
<%@ page import="java.text.DecimalFormat" %>
<%
    BD SMBD = new BD();

    ResultSet rs;
    String consultas;

    int cve_padre = Integer.parseInt(request.getParameter("cve_padre"));
    int anioP = Integer.parseInt(request.getParameter("anioP"));
    String nombCuen=request.getParameter("nombreCuenta");


%>
 <div class="datagrid">
                <table id="mitablaDepenCuentasHijos" width="95%">
                    <thead>
                    <tr>
                            <th colspan="8">PAPA ES: <%=nombCuen%></th>
                    </tr>
                        <tr>
                            <th >No </th>
                            <th >A&ntilde;o</th>
                            <th >Cuenta</th>
                            <th>Nombre Cuetna</th>
                            <th >Hijos</th>
                            <th width="63px">Nuevo Hijo</th>
                            <th>Editar</th>
                            <th>Eliminar</th>
                        </tr>
                    </thead>
                    <tbody>
    <%
        //consultas = "SELECT id_cuenta,anio,cuenta,padre,nombre_cuenta FROM sic.DEPENDENCIAS_CUENTAS WHERE padre=" + cve_padre;
        consultas="SELECT id_cuenta,anio,cuenta,padre,nombre_cuenta "
                 +"FROM sic.DEPENDENCIAS_CUENTAS "
                 +"WHERE (padre="+cve_padre+") AND (anio="+anioP+")";
        rs = SMBD.SQLBD2(consultas);
        int variable = 0;
        int bandera = 0;
        String subStrNomCuenta="";
        while (rs.next()) {
            variable = rs.getInt(1);
            subStrNomCuenta=rs.getString(5).replace(" ","-");
            bandera += 1;
    %>

    <tr>
    <td width="100px" class="<%=variable%>"><%=bandera%></td>
    <td width="100px"><%=rs.getInt(2)%></td>
    <td width="100px"><%=rs.getString(3)%></td>
    <td width="100px"><%=rs.getString(5)%></td>
    <td width="100px"><a id="linkver<%=variable%>" href="javascript:llenar_hijos_tabla(<%=variable%>,<%=rs.getInt(2)%>,'<%=subStrNomCuenta%>');">Ver hijos</a>
                    <a id="linkOcultar<%=variable%>" style="display:none" href="javascript:ocultar_tabla_hijos(<%=variable%>);">Ocultar hijos</a>
    </td>

    <td  width="100px">
        <img src="../../imagenes/ikonoz/nuevo.JPG" width="20px" height="20px" title="Nuevo" onclick="linkNuevo(<%= rs.getInt(1)%>,<%=rs.getInt(2)%>, '<%= rs.getString(3)%>',<%= rs.getInt(4)%>,'<%= rs.getString(5)%>');"/>
    </td>
    <td  width="100px">
        <img src="../../imagenes/ikonoz/editar.png" width="15px" height="15px" title="Editar" onclick="linkEditar(<%= rs.getInt(1)%>,<%=rs.getInt(2)%>, '<%= rs.getString(3)%>',<%= rs.getInt(4)%>,'<%= rs.getString(5)%>');"/>
    </td>
    <td  width="100px">
        <img src="../../imagenes/ikonoz/eliminar.JPG" width="20px" height="20px" title="Eliminar" onclick="linkEliminar(<%= rs.getInt(1)%>,<%=rs.getInt(2)%>, '<%=rs.getString(3)%>',<%=rs.getInt(4)%>,'<%=rs.getString(5)%>');"/>
    </td>
</tr>
<tr>

<td colspan="8" aling="right">
    <div id="<%=variable%>">

    </div>
</td>

</tr>

<%
    }
    SMBD.desconectarBD();
%>
  </tbody>
                </table>
            </div>


