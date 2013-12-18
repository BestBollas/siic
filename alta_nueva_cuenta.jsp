<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*, java.text.DecimalFormat,control_prezupueztal.*,comun.*" errorPage=""%>
<%
    if (session.getAttribute("usuario") != null) {
        String mensaje = String.valueOf(session.getAttribute("usuario"));
        int cve_per = Integer.parseInt(String.valueOf(session.getAttribute("clave_usuario")));
        int anio = Integer.parseInt(request.getParameter("anioFiltro"));

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
                $('#sltPadreNuevaCuenta').hide();
                $('#sltAnioNuevaCuenta').hide();
                $('#lblAnio').text($('#lblAnio').text() + ": " + anioV);
                $("#btnCatCuenGuardar").click(function() {

                    if (validarNuevaCuenta()) {
                        anioV = $("#sltAnioNuevaCuenta").val();
                        cuentaV = $("#inpCuentaNuevaCuenta").val();
                        nombreCuenta = $("#inpNombreCuentaNuevaCuenta").val();
                        insertarNuevaCuenta(cve_persona);
                    }
                });
                $("#btnSalir").click(function() {
                    window.close();
                });
            });
            var cve_persona =<%=cve_per%>;
            var idCuentaV = 0;
            var anioV = <%=anio%>;
            var cuentaV = "";
            var idPadreV = 0;

            $(function() {
                $("#btnCatCuenGuardar").button();
                $("#btnSalir").button();
            });
            function validarNuevaCuenta() {
                if ($("#sltAnioNuevaCuenta").val() == 0) {
                    alert("Seleccionar Año");
                    return false;

                } else if ($("#sltPadreNuevaCuenta").val() == "") {
                    alert("Seleccionar Padre");
                    return false;

                } else if ($("#inpNombreCuentaNuevaCuenta").val() == "") {
                    alert("Te falto el Nombre de Cuenta");
                    return false;
                } else if ($("#inpCuentaNuevaCuenta").val() == "") {
                    alert("Te falto la Cuenta");
                    return false;
                }
                return true;
            }
            function limpiar() {
                $("#inpCuentaNuevaCuenta").val("");
                $("#sltPadreNuevaCuenta").val(0);
                $("#inpNombreCuentaNuevaCuenta").val("");
            }
            function insertarNuevaCuenta(cve_per) {
                $.ajax({
                    url: "dependencias_cuentas/insertarCuenta.jsp",
                    data: {'insertar': 1, 'anioF': $("#sltAnioNuevaCuenta").val(), 'idPadreF': $("#sltPadreNuevaCuenta").val(), 'cuentaF': $("#inpCuentaNuevaCuenta").val(), 'cve_per': cve_per, 'nombredelaCuenta': $("#inpNombreCuentaNuevaCuenta").val()},
                    type: "post",
                    beforeSend: function() {
                    },
                    "success": function(result) {
                        if (result != 0) {
                            $("#mensajeF").show();
                            $("#mensajeF").text("Se Inserto Correctamente");
                            window.opener.muestra_tabla(anioV);
                            limpiar();
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
        <style type="text/css">
            #nuevaCuenta h1{
                font-size: 1.5em;
                text-align:center;
                color:red;
            }
            input[type='text'],select{
                border: 1px solid #006679;
                border-radius: 20px;
                display:block;
                width:20em;
                margin: 1em;
                padding: 4px;
            }
            #btnSalir,#btnCatCuenGuardar{
                display: inline-block;
                margin: 2% auto;
                margin-left: 2em;
            }
            #nuevaCuenta{
                border: 1px solid #000;
                border-radius: 20px;
                display: block;
                color: black;
                font-size: 1em;
                height: 19em;
                margin: 1% auto ;
                padding: 1em;
                text-align: left;
                box-shadow: -3px -3px 2px grey;
                width:20em;
            }
            #nuevaCuenta label{
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
                        ALTA NUEVA CUENTA</td>
                </tr>
            </table>
        </div>

        <div id="nuevaCuenta" title="Nueva cuenta">
            <label id="lblAnio">A&ntilde;o</label>
            <select name="sltAnioNuevaCuenta" id="sltAnioNuevaCuenta" disabled="true">
                <option value="<%=anio%>"><%=anio%></option>
            </select>
            <label>Cuenta</label>
            <input type="text" name="inpCuentaNuevaCuenta" id="inpCuentaNuevaCuenta"  placeholder="Cuenta" onkeypress="return soloLetras(event)" onblur="limpia(inpCuentaNuevaCuenta)"/>
            <label>Nombre:</label>
            <input type="text" name="inpNombreCuentaNuevaCuenta" id="inpNombreCuentaNuevaCuenta"  placeholder="Nombre" onkeypress="return soloLetras(event)" onblur="limpia(inpNombreCuentaNuevaCuenta)"/>
            <h1>ESTA CUENTA ES LA PRICNIPAL</h1>
            <select name="sltPadre" id="sltPadreNuevaCuenta" disabled="true">
                <option value="0">Es Padre</option>
            </select>
            <button id="btnCatCuenGuardar">Crear Nueva Cuenta</button>
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
    } else {
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
%>