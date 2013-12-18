<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*, java.text.DecimalFormat,control_prezupueztal.*,comun.*" errorPage=""%>
<%
if (session.getAttribute("usuario") != null)
    {
String mensaje = String.valueOf(session.getAttribute("usuario"));
int cve_per = Integer.parseInt(String.valueOf(session.getAttribute("clave_usuario")));


int anioNuevoHijoPapa = Integer.parseInt(request.getParameter("anioForm"));
String nomCuentaPaPa=request.getParameter("nomCuentaForm");
int idPadreNuevoHijo = Integer.parseInt(request.getParameter("idPadreForm"));

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
    <script type="text/javaScript" src="../../js2014/jquery_1.9.1.js"></script>
    <script type="text/javaScript" src="../../js2014/jquery_ui_1.10.3.js"></script>
    <link href="../../estilos/sic.css" rel="stylesheet" type="text/css">
    <script>
      $(document).on('ready', function() {
        $("#mensajeF").hide();
        $("#h4Titulo").text("El PAPA ES: " + nombrePapa);
        $('#lblAnio').text($('#lblAnio').text()+": "+anioV);
        $('#lblPadre').text("Nombre Papa: "+nombrePapa);

        $("#btnCatCuenGuardarHijo").click(function() {
            if (validarNuevaCuenta()) {
                cuentaV = $("#inpCuentaNuevoHijo").val();
                nombreCuenta = $("#inpNombreCuentaNuevoHijo").val();
                insertarNuevoHijo(cve_persona);
            }
        });

        $("#btnSalir").click(function() {
           window.close();
       });

    });

      var anioV       =<%=anioNuevoHijoPapa%> ;
      var idpadre     =<%=idPadreNuevoHijo%>;
      var cve_persona =<%=cve_per%>;
      var nombrePapa  =<%=nomCuentaPaPa%>;

      $(function() {
        $("#btnCatCuenGuardarHijo").button();
        $("#btnSalir").button();
    });
      function validarNuevaCuenta() {
        if ($("#inpCuentaNuevoHijo").val() == 0) {
            alert("El campo cuenta no puede estar vacio");
            return false;

        } else if ($("#inpNombreCuentaNuevoHijo").val() == "") {
            alert("El campo nombre de la cuenta no puede estar vacio");
            return false;
        }
        return true;
    }
    function limpiar(){
        $("#inpNombreCuentaNuevoHijo").val("");
        $("#inpCuentaNuevoHijo").val("");
    }
            function insertarNuevoHijo(cve_per) {
                $.ajax({
                    url: "dependencias_cuentas/insertarCuenta.jsp",
                    data: {'insertarNewHijo': 1, 'anioF': anioV, 'idPadreF': idpadre, 'cuentaF': $("#inpCuentaNuevoHijo").val(), 'cve_per': cve_per, 'tipo': 1, 'nombredelaCuenta': $("#inpNombreCuentaNuevoHijo").val()},
                    type: "post",
                    beforeSend: function() {
                    },
                    "success": function(result) {
                        if (result != 0) {
                            $("#mensajeF").show();
                            window.opener.llenar_hijos_tabla(idpadre,anioV,nombrePapa);
                            limpiar();
                            $("#mensajeF").text("Se Inserto Correctamente");
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
        width:22em;
        margin: 0em;
        padding: 4px;
    }
    #btnSalir,#btnCatCuenGuardarHijo{
        display: inline-block;
        margin: 2% auto;
    }
    #nuevoHijo{
        border: 1px solid #000;
        border-radius: 20px;
        display: block;
        color: black;
        font-size: 1em;
        height: 15em;
        margin: 2% auto ;
        padding: 2em;
        text-align: center;
        box-shadow: -3px -3px 2px grey;
        width:20em;
    }
     #nuevoHijo label{
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
                    ALTA NUEVO HIJO DE LA CUENTA</td>
                </tr>
            </table>
        </div>
        <div id="nuevoHijo" title="Nuevo Hijo">
            <h4 id="h4Titulo"></h4>
            <label id="lblAnio">A&ntilde;o</label>
            <label>Cuenta</label>
            <input type="text" name="inpCuenta" id="inpCuentaNuevoHijo"  placeholder="Cuenta" onkeypress="return soloLetras(event)" onblur="limpia(inpCuentaNuevoHijo)"/>
            <label>Nombre</label>
            <input type="text" name="inpNombreCuentaNuevoHijo" id="inpNombreCuentaNuevoHijo"  placeholder="Nombre"  onkeypress="return soloLetras(event)" onblur="limpia(inpNombreCuentaNuevoHijo)"/>
            <button id="btnCatCuenGuardarHijo">Crear Nuevo Hijo</button>
            <button id="btnSalir">Salir</button>
        </div>
        <label  id="mensajeF">MensajeUpdate</label>
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