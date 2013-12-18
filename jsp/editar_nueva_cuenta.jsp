<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*, java.text.DecimalFormat,control_prezupueztal.*,comun.*" errorPage=""%>
<%
if (session.getAttribute("usuario") != null)
    {
String mensaje = String.valueOf(session.getAttribute("usuario"));
int cve_per = Integer.parseInt(String.valueOf(session.getAttribute("clave_usuario")));

int idCuentaEdit =Integer.parseInt(request.getParameter("idCuentaForm"));
int anioEdit = Integer.parseInt(request.getParameter("anioform"));
String cuentaEdit = request.getParameter("cuentaForm");
int idPadreEdit = Integer.parseInt(request.getParameter("idPadreForm"));
String nombreCuenEdit=request.getParameter("nomCuenForm");

BD SMBD = new BD();
ResultSet rs;
String consultas = "";
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../estilos/sic.css" rel="stylesheet" type="text/css">
    <link href="css/jQueryElements.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/jsp/menu/stmenu.js"></script>
    <script language="JavaScript" src="<%=request.getContextPath()%>/js/popcalendar.js"></script>
    <script type="text/javaScript" src="../../js2014/jquery_1.9.1.js"></script>
    <script type="text/javaScript" src="../../js2014/jquery_ui_1.10.3.js"></script>
    <link href="../../estilos/sic.css" rel="stylesheet" type="text/css">
    <script>
      $(document).on('ready', function() {
        $("#mensajeF").hide();
        $('#sltPadreEditar').val(idPadreV);
        $('#sltPadreEditar').hide();
        $('#sltAnioEditar').hide();
        $("#lblAnio").text($("#lblAnio").text()+": "+anioV);
        $('#lblPapa').text("PAPA: "+$('#sltPadreEditar option:selected').text());
        $("#btnCatCuenModif").click(function() {
                Modificar();
        });
        $("#btnSalir").click(function() {
         window.close();
     });
    });

      var anioV        = <%=anioEdit%>;
      var cuentaV      = "";
      var cve_persona  =<%=cve_per%>;
      var nombreCuenta = "";
      var idPadreV=<%=idPadreEdit%>;
      var idCuentaV=<%=idCuentaEdit%>
      $(function() {
        $("#btnCatCuenModif").button();
        $("#btnSalir").button();
    });
      function validarFormularioEditar() {
        if ($("#sltAnioEditar").val() == 0) {
            alert("Seleccionar Año");
            return false;

        } else if ($("#sltPadreEditar").val() == "") {
            alert("Seleccionar Padre");
            return false;

        } else if ($("#inpNombreCuentaEditar").val() == "") {
            alert("Te falto el Nombre de Cuenta");
            return false;
        }else if($("#inpCuentaEditar").val() == ""){
            alert("Te falto la Cuenta");
            return false;
        }
        return true;
    }
    function limpiar(){
        $("#inpNombreCuentaEditar").val("");
        $("#inpCuentaEditar").val("");
        $("#btnCatCuenModif").attr('disabled', 'disabled');
    }
            function Modificar() {
                $.ajax({
                    url: "dependencias_cuentas/insertarCuenta.jsp",
                    data: {'modificar': 2, 'anioF': $("#sltAnioEditar").val(), 'idPadreF': $("#sltPadreEditar").val(), 'cuentaF': $("#inpCuentaEditar").val(), 'idCuentaF': idCuentaV, 'cve_per': cve_persona, 'nombredelaCuenta': $("#inpNombreCuentaEditar").val()},
                    type: "post",
                    beforeSend: function() {
                    },
                    "success": function(result) {
                        if (result != 0) {
                            $("#mensajeF").show();
                            window.opener.muestra_tabla(anioV);
                            limpiar();
                            $("#mensajeF").text("Se Modifico Correctamente");
                            $("#mensajeF").animate({"height": "hide"}, {duration: 3000});
                        } else {
                            alert("Ocurrio un Error");
                        }
                    },
                    "error": function(result) {
                        alert("Ocurrio un Error");
                    }
                });
            }
                      function soloLetras(e) {
                key = e.keyCode || e.which;
                tecla = String.fromCharCode(key).toLowerCase();
                letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
                especiales = [9, 8, 39, 45, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57];
                tecla_especial = false
                for (var i in especiales) {
                    if (key == especiales[i]) {
                        tecla_especial = true;
                        break;
                    }
                }
                if (letras.indexOf(tecla) == -1 && !tecla_especial)
                    return false;
            }

            function limpia(ele) {
                var val = document.getElementById(ele).value;
                var tam = val.length;
                for (i = 0; i < tam; i++) {
                    if (!isNaN(val[i]))
                        document.getElementById(ele).value = '';
                }
            }
</script>
<style type="text/css" media="screen">

    input[type='text'],select{
        border: 1px solid #006679;
        border-radius: 20px;
        display:block;
        width:21em;
        margin: 1em;
        padding: 4px;
    }
    #btnSalir,#btnCatCuenModif{
        display: inline-block;
        margin: 2% auto;
        margin-left: 4em;
    }
    #editarCuenta{
        border: 1px solid #000;
        border-radius: 20px;
        display: block;
        color: black;
        font-size: 1em;
        height: 16em;
        margin: 1% auto ;
        padding: 1em;
        text-align: left;
        box-shadow: -3px -3px 2px grey;
        width:20em;
    }
      #editarCuenta label{
        display: inline-block;
        margin: 1px 0px 0px 0px;
        padding: 2px;
        width: 100%;
        font-size: 1em;
        text-align: left;
     }
    #mensajeF{
        display: inline-block;
        margin: 0em 0 6px 170px;
        padding: 4px;
        width: 12em;
        font-size: 1.3em;
        color:red;
        text-align: center;
        font-weight:bold;
    }
</style>
</head>
<body>
    <div align="center">
        <table width="397" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="usuario"> <div align="center"><%=mensaje%></div></td>
            </tr>
            <tr >
                <td class="encabezado" align="center">
                    EDITAR CUENTA</td>
                </tr>
            </table>
        </div>
        <div id="editarCuenta" title="Editar Cuenta">
            <label id="lblAnio">A&ntilde;o</label>
            <select name="sltAnio" id="sltAnioEditar" disabled="true">
             <option value="<%=anioEdit%>"><%=anioEdit%></option>
         </select>
         <label>Cuenta</label>
         <input type="text" name="inpCuentaEditar" id="inpCuentaEditar"  placeholder="Cuenta" value="<%=cuentaEdit%>"  onkeypress="return soloLetras(event)" onblur="limpia(inpCuentaEditar)"/>
         <label>Nombre</label>
         <input type="text" name="inpNombreCuentaEditar" id="inpNombreCuentaEditar"  placeholder="Nombre" value="<%=nombreCuenEdit%>"  onkeypress="return soloLetras(event)" onblur="limpia(inpNombreCuentaEditar)"/>
         <label id="lblPapa">Padre</label>
         <select name="sltPadre" id="sltPadreEditar" disabled="true">
         <option value="0">ES PAPA</option>
            <%
                consultas = "SELECT sic.DEPENDENCIAS_CUENTAS.id_cuenta,sic.DEPENDENCIAS_CUENTAS.cuenta "
                            +"FROM sic.DEPENDENCIAS_CUENTAS";
            rs = SMBD.SQLBD2(consultas);
            while (rs.next()) {
                %>
                    <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                <%
            }
            SMBD.desconectarBD();
            %>
        </select>
        <input type="button" id="btnCatCuenModif" value="Modificar"/>
        <button id="btnSalir">Salir</button>
    </div>
    <label  id="mensajeF">Mensaje</label>
    <div align="center">
        <p><span class="SoloTexto2"><span>Universidad Tecnol&oacute;gica de San Juan del R&iacute;o<br> 
            Departamento de Tecnologias de Informaci&oacute;n
            <br>
        </span> <a class="liga" href="mailto:ncruzs@utsjr.edu.mx">Coordinador de Desarrollo de Sistemas</a></span> </p>
    </div>
</body>
</html>
<%
}
else
    {
response.sendRedirect(request.getContextPath()+"/index.html");
}
%>