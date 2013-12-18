<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*, java.text.DecimalFormat,control_prezupueztal.*,comun.*" errorPage=""%>
<%
    if (session.getAttribute("usuario") != null) {
        String mensaje = String.valueOf(session.getAttribute("usuario"));
        int cve_per = Integer.parseInt(String.valueOf(session.getAttribute("clave_usuario")));
        int idCuentaElimi = Integer.parseInt(request.getParameter("idCuentaElim"));
        int anioElimi = Integer.parseInt(request.getParameter("anioElim"));
        String cuentaElimi = request.getParameter("cuenElim");
        int idPadre = Integer.parseInt(request.getParameter("idPadre"));
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
        <link href="../../estilos/sic.css" rel="stylesheet" type="text/css"/>
        <script>
            $(document).on('ready', function() {
                $("#mensajeF").hide();
                $("#lblEliminarFalse").hide();
                $('#lblEliminarHijos').hide();
                $("#btnCatCuenElimi").click(function() {
                    Eliminar();
                });
                $("#btnCatCuenCancelar").click(function() {
                    window.close();
                });
            });
            var idCuentaV =<%=idCuentaElimi%>;
            var anioV =<%=anioElimi%>;
            var cuentaV =<%=cuentaElimi%>;
            var idPapaV=<%=idPadre%>;
            $(function() {
                $("#btnCatCuenElimi").button();
                $("#btnCatCuenCancelar").button();
                $("#btnSalir").button();
            });
            function Eliminar() {
                $.ajax({
                    url: "dependencias_cuentas/insertarCuenta.jsp",
                    data: {'eliminar': 3, 'idCuentaF': idCuentaV, 'anioElim': anioV, 'cuentaFor': cuentaV,'idPapa':idPapaV},
                    type: "post",
                    "success": function(result) {
                        var valor = parseInt(result);
                        switch (valor) {
                            case 1:
                                window.opener.muestra_tabla(anioV);
                                $("#mensajeF").show();
                                $("#btnCatCuenElimi").attr('disabled', 'disabled');
                                $("#mensajeF").text("Se Elimino Correctamente");
                                $("#mensajeF").animate({"height": "hide"}, {duration: 3000});
                                break;
                            case 2:
                                $("#btnCatCuenElimi").attr('disabled', 'disabled');
                                $("#lblEliminarTrue").text("ESTA CUENTA NO SE PUEDE ELIMINAR PUESTO QUE YA FUE ASIGNADA A UN PROYECTO");
                                $("#lblEliminarTrue").hide();
                                $("#lblEliminarFalse").show();
                                $('#lblEliminarHijos').hide();
                                break;
                            case 3:
                                $("#btnCatCuenElimi").attr('disabled', 'disabled');
                                $("#lblEliminarTrue").hide();
                                $("#lblEliminarFalse").hide();
                                $('#lblEliminarHijos').show();
                                break;
                            default :
                                alert("Ocurrio un error al Eliminar");
                                break;
                        }
                    },
                    "error": function(result) {
                        alert("Ocurrio un Error");
                    }
                });
            }
        </script>
        <style>

            #lblEliminarFalse,#lblEliminarHijos{
                font-size: 1.5em;
                width:18em;
                margin:4% auto;
            }
            #btnCatCuenElimi,#btnCatCuenCancelar,#btnSalir{
                margin-left: 6em;
            }
            #mensajeF{
                display: inline-block;
                margin: 0.5em 0px 0px 84px;
                padding: 4px;
                width: 12em;
                font-size: 1.3em;
                color:red;
                text-align: center;
                font-weight:bold;

            }
            #artEliminar h1{
                width: 13em;
                text-align: justify;
                color:red;
            }
            #artEliminar{
                border: 1px solid #000;
                border-radius: 20px;
                display: block;
                color: black;
                font-size: 1em;
                height: 12em;
                margin: 1% auto ;
                padding: 1em;
                box-shadow: -3px -3px 2px grey;
                width: 27em;
            }
            footer{
                color: black;
                font-size: 1em;
                height: 5em;
                margin: 2em;
                padding: 2em;
                width: 21em;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <header align="center">
            <table width="397" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="usuario"> <div align="center"><%=mensaje%></div></td>
                </tr>
                <tr >
                    <td class="encabezado" align="center">
                        EDITAR CUENTA
                    </td>
                </tr>
            </table>
        </header>

    <aricle id="artEliminar" title="Eliminar Cuenta">
        <h1 id="lblEliminarTrue">ESTA SEGURO QUE DESEA ELIMINAR ESTA CUENTA</h1>
        <h1 id="lblEliminarFalse">ESTA CUENTA NO SE PUEDE ELIMINAR PUESTO QUE YA FUE ASIGNADA A UN PROYECTO</h1>
        <h1 id="lblEliminarHijos">ESTA CUENTA NO SE PUEDE ELIMINAR PUESTO QUE TIENE CUENTAS ASIGNADAS</h1>
        <input type="button" id="btnCatCuenElimi" value="Eliminar"/>
        <input type="button" id="btnCatCuenCancelar" value="Cancelar"/>
    </article>
    <label  id="mensajeF">Mensaje</label>
    <footer align="center">
        <p><span class="SoloTexto2"><span>Universidad Tecnol&oacute;gica de San Juan del R&iacute;o<br> 
                    Departamento de Tecnologias de Informaci&oacute;n
                    <br>
                </span> <a class="liga" href="mailto:ncruzs@utsjr.edu.mx">Coordinador de Desarrollo de Sistemas</a></span> </p>
    </footer>

</body>
</html>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
%>
