<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*, java.text.DecimalFormat,control_prezupueztal.*,comun.*" errorPage=""%>
<%
    if (session.getAttribute("usuario") != null) {
        DecimalFormat formato = new DecimalFormat("###,###,###.00");
        String mensaje = String.valueOf(session.getAttribute("usuario"));
        int cve_per = Integer.parseInt(String.valueOf(session.getAttribute("clave_usuario")));
        BD SMBD = new BD();
        ResultSet rs;
        String consultas = "";
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="../estilos/sic.css" rel="stylesheet" type="text/css">
        <link href="css/jQueryElements.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/jsp/menu/stmenu.js"></script>
        <script language="JavaScript" src="<%=request.getContextPath()%>/js/popcalendar.js"></script>
        <script type="text/javaScript" src="../../js2014/jquery_1.9.1.js"></script>
        <script type="text/javaScript" src="../../js2014/jquery_ui_1.10.3.js"></script>
        <script>
            var idPadreV = 0;
            var cuentaPadreV = "";
            var anioV = 0;
            var cuentaV = "";
            var idCuentaV = 0;
            var eleTablaNew;
            var eleTablaold;
            var anioValFiltro = 0;
            var cve_persona =<%=cve_per%>;
            var nombreCuenta = "";

            $(document).on('ready', function() {
                $("#btnSalir").click(function() {
                    location.href = "inicio.jsp?menu=2&op=6";
                });

                $("#btnNuevaCuenta").click(function() {
                    if ($('#sltAnioFiltro').val() != 0) {
                        var URL = 'alta_nueva_cuenta.jsp?anioFiltro=' + anioValFiltro;
                        var vWinPres = window.open(URL, "Alta Nueva Cuenta", "status=yes,scrollbars=yes,resizable=no, width=600,height=600");
                    } else {
                        alert("Seleciona un Año");
                    }
                });

                $("#sltAnioFiltro").change(function() {
                    var selectedOption = $(this).find('option:selected');
                    anioValFiltro = $(selectedOption).val();
                    muestra_tabla(anioValFiltro);
                }).change();

                $("#sltPadre").change(function() {
                    var selectedOption = $(this).find('option:selected');
                    cuentaPadreV = $(selectedOption).text();
                    idPadreV = $(selectedOption).val();
                    anioV = 0;
                }).change();
            });

            $(function() {
                $("#btnNuevaCuenta").button();
                $("#btnSalir").button();
            });

            function muestra_tabla(anio) {
                $.ajax({
                    url: "dependencias_cuentas/muestra_tabla.jsp",
                    data: {'anioFiltro': anio},
                    type: "post",
                    beforeSend: function() {

                    },
                    "success": function(result) {

                        $("#mitablaDepenCuentas tbody").html(result);
                        //$("#sltPadre option").html(result);
                    },
                    "error": function(result) {
                        alert("Ocurrio un Error " + idPapa);
                    }
                });
            }

            function linkNuevo(idForm, anioForm, cuentaForm, padreForm, nomCuenta) {
                idCuentaV = idForm;
                anioV = anioForm;
                cuentaV = cuentaForm;
                idPadreV = padreForm;
                nombreCuenta = nomCuenta.replace(/-/gi, " ");
                var URL = "crear_nuevo_hijo_cuenta.jsp?anioForm=" + anioV + "&nomCuentaForm='" + nombreCuenta + "'&idPadreForm=" + idCuentaV;
                var vWinPres = window.open(URL, "Alta Nuevo Hijo Cuenta", "status=yes,scrollbars=yes,resizable=no, width=600,height=600");
            }

            function linkEditar(idForm, anioForm, cuentaForm, padreForm, nomCuenta) {
                idCuentaV = idForm;
                anioV = anioForm;
                cuentaV = cuentaForm;
                idPadreV = padreForm;
                nombreCuenta = nomCuenta.replace(/-/gi, " ");
                var URL = 'editar_nueva_cuenta.jsp?anioform=' + anioV + "&idCuentaForm=" + idCuentaV + "&idPadreForm=" + idPadreV + "&cuentaForm=" + cuentaV + "&nomCuenForm=" + nombreCuenta;
                var vWinPres = window.open(URL, "Editar Nueva Cuenta", "status=yes,scrollbars=yes,resizable=no, width=600,height=600");
            }

            function linkEliminar(idForm, anioForm, cuentaForm, padreForm, nomCuenta) {
                idCuentaV = idForm;
                anioV = anioForm;
                cuentaV = cuentaForm;
                idPadreV = padreForm;
                nombreCuenta = nomCuenta.replace(/-/gi, " ");
                var URL = 'eliminar_cuenta.jsp?anioElim=' + anioV + "&idCuentaElim=" + idCuentaV + "&cuenElim=" + cuentaV+"&idPadre="+idPadreV;
                var vWinPres = window.open(URL, "Eliminar Cuenta", "status=yes,scrollbars=yes,resizable=no, width=600,height=400");
            }

            function resetearVariable() {

                $("#inpCuenta").val("");
                $('#sltAnio > option[value=""]').attr('selected', 'selected');
                $('#sltPadre > option[value=""]').attr('selected', 'selected');
                $("#centro").slideUp();
                $("#inpNombreCuentaNuevaCuenta").val("");
            }

            function llenar_hijos_tabla(idPapa, anioPapa,nomCuen) {
                $('#linkver'+idPapa).hide();
                $.ajax({
                    url: "dependencias_cuentas/muestra_hijos_tabla.jsp",
                    data: {'cve_padre': idPapa, 'anioP': anioPapa,'nombreCuenta':nomCuen},
                    type: "post",
                    "success": function(result) {
                        $('#' + idPapa).html(result).slideDown(2000);
                        $('#linkOcultar'+idPapa).show();
                        //$("#sltPadre option").html(result);
                    },
                    "error": function(result) {
                        alert("Ocurrio un Error " + anioPapa);
                    }
                });
            }
            function ocultar_tabla_hijos(idPapa){
                $('#linkOcultar'+idPapa).hide();
                $('#linkver'+idPapa).show();
                $('#' + idPapa).html(" ").slideDown(2000);
            }


        </script>
        <style type="text/css">
            table tbody tr td{
                text-align: center;
            }

            .datagrid table { border-collapse: collapse; text-align: left; width: 100%; }
            .datagrid {font: normal 12px/150% Geneva, Arial, Helvetica, sans-serif; background: #fff; overflow: hidden; border: 3px solid #006699; -webkit-border-radius: 10px; -moz-border-radius: 10px; border-radius: 10px; }
            .datagrid table td,
            .datagrid table th { padding: 6px 10px; }
            .datagrid table thead th {background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #006699), color-stop(1, #00557F) );background:-moz-linear-gradient( center top, #006699 5%, #00557F 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#006699', endColorstr='#00557F');background-color:#006699; color:#FFFFFF; font-size: 15px; font-weight: bold; border-left: 1px solid #0070A8; }
            .datagrid table thead th:first-child { border: none; }
            .datagrid table tbody td { color: #00557F; border-left: 5px solid #E1EEF4;font-size: 14px;border-bottom: 3px solid #E1EEF4;font-weight: normal; }
            .datagrid table tbody .alt td { background: #E1EEf4; color: #00557F; }
            .datagrid table tbody td:first-child { border-left: none; }
            .datagrid table tbody tr:last-child td { border-bottom: none; }
            .datagrid table tfoot td div { border-top: 1px solid #006699;background: #E1EEf4;}
            .datagrid table tfoot td { padding: 0; font-size: 13px ;}
            .datagrid table tfoot td div{ padding: 5px; }
            .datagrid table tfoot td ul { margin: 0; padding:0; list-style: none; text-align: right; }
            .datagrid table tfoot  li { display: inline; }
            .datagrid table tfoot li a { text-decoration: none; display: inline-block;  padding: 2px 8px; margin: 1px;color: #FFFFFF;border: 2px solid #006699;-webkit-border-radius: 20px; -moz-border-radius: 20px; border-radius: 20px; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #006699), color-stop(1, #00557F) );background:-moz-linear-gradient( center top, #006699 5%, #00557F 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr ='#006699', endColorstr='#00557F');background-color:#006699; }
            .datagrid table tfoot ul.active,
            .datagrid table tfoot ul a:hover { text-decoration: none;border-color: #00557F; color: #FFFFFF; background: none; background-color:#006699;}
            #mitablaDepenCuentas,#mitablaDepenCuentasHijos{
                width:100%;
                font-size: 1em;
                text-align:center;
            }

            #nuevoHijo,#nuevaCuenta,#editarCuenta{

                display: block;
                color: black;
                font-size: 1em;
                height: 13em;
                margin: 1% auto ;
                padding: 1em;
                text-align: left;
                width:14em;
            }

            input[type='text'],select{
                display:block;
                width:15em;
                margin: 0em;
                padding: 4px;
            }

            #nuevoHijo,#nuevaCuenta,#editar{
                display: inline-block;
                margin: 1em 1em 1em 1em;
                padding: 2px;
                width: 10em;
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

            #icon{
                width: 16px;
                height: 16px;
                background-image: url(images/ui-icons_0078ae_256x240.png);
                background-position: -80px -112px;
            }

            #mitablaDepenCuentas tbody tr{
                cursor: pointer;
            }

            button{
                display: inline-block;
            }

            .colorr {
                color: #FF0000;
            }

            #sltAnioFiltro {
                border-radius: 20px;
                border:1px solid #006679;
                margin-bottom: 1em;
                display:inline-block;
                padding: 2px;
            }

            #lblAnioFiltro{
                display: inline-block;
                font-size: 22px;
            }

            #imagenVer{
                width:39px;
                height:24px;
                background-image:url(imagenes/ojo.jpg);
                background-position: -144px -93px;
                background-size: 136px;
            }

        </style>
        <link href="../../estilos/sic.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <table width="67%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <div align="center"><img src="../../imagenes/banner.jpg"></div>
                    <table width="71%" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <div align="center">
                                    <script type="text/javascript" language="javascript1.2" src="<%=request.getContextPath()%>/jsp/menu/menu.js">
                                    </script>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div align="center"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="titulo">
                                <div align="center"><%=SMBD.busca_area_usuario(Integer.parseInt(String.valueOf(session.getAttribute("clave_usuario"))))%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="usuario">
                                <div align="center"><%=mensaje%></div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="encabezado">
                </td>
            </tr>
        </table>
        <div align="center">
            <button id="btnNuevaCuenta">Nueva Cuenta</button>
            <button id="btnSalir">Salir</button>
            <label id="lblAnioFiltro" for="sltAnioFiltro">A&ntilde;o:</label>
            <select name="sltAnioFiltro" id="sltAnioFiltro">
                <option value="0">Seleccionar...</option>
                <option value="2014">2014</option>
                <option value="2015">2015</option>
                <option value="2016">2016</option>
            </select>
            <div class="datagrid">
                <table id="mitablaDepenCuentas" width="95%">
                    <thead>
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
                    </tbody>
                </table>
            </div>
            <p><span class="SoloTexto2"><span>Universidad Tecnol&oacute;gica de San Juan del
                        R&iacute;o<br>
                        Departamento de TI <br>
                    </span> <a class="liga" href="mailto:ncruzs@utsjr.edu.mx" title="Neftali Cruz Soriano">Coordinador de Desarrollo
                        de Sistemas</a></span> </p>
        </div>




    </body>
</html>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
%>