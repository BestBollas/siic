<%@page import="control_prezupueztal.Dependencias_Cuentas"%>
<%@ page language="java" import="java.sql.*,java.lang.*,java.util.*,java.text.DecimalFormat, gestion_recursos.adkizizionez.rekiz.*,comun.*,control_prezupueztal.Dependencias_Cuentas.*" errorPage=""%>
<%@ page import="java.text.DecimalFormat" %>
<%
    BD SMBD = new BD();
    Dependencias_Cuentas DECU = new Dependencias_Cuentas();
    ResultSet rs;
    String consultas;
    int bandera;
    bandera = 0;
    consultas = "";

    if (request.getParameter("insertar") != null) {
        DECU.anio = Integer.parseInt(request.getParameter("anioF"));
        DECU.idPadre = Integer.parseInt(request.getParameter("idPadreF"));
        DECU.cuenta = request.getParameter("cuentaF");
        DECU.cve_persona = Integer.parseInt(request.getParameter("cve_per"));
        DECU.nombreCuenta = request.getParameter("nombredelaCuenta");
        DECU.tipo = 0;
        try {
            DECU.cuentaRepetida();
            if (DECU.bandera != 0) {
                out.print(0);
            } else {
                try {
                    DECU.Insertar();
                    out.print(DECU.si);
                } catch (Exception e) {
                    out.print("<----" + e);
                }
            }
        } catch (Exception e) {
            out.print("--->" + e);
        }


    } else if (request.getParameter("eliminar") != null) {
        DECU.anioF = Integer.parseInt(request.getParameter("anioElim"));
        DECU.cuenta = request.getParameter("cuentaFor");
        DECU.idCuenta = Integer.parseInt(request.getParameter("idCuentaF"));
        DECU.idPadre = Integer.parseInt(request.getParameter("idPapa"));
        if (DECU.validaHijo(DECU.idCuenta) != 0) {
           out.print(3);
        } else {
             if (DECU.validaEliminar() != 0) {
             out.print(2);
            } else {
                   try {
                    DECU.Eliminar();
                    out.print(DECU.si);
                } catch (Exception e) {
                    out.print(e);
                }
            }
        }

    } else if (request.getParameter("modificar") != null) {
        DECU.idCuenta = Integer.parseInt(request.getParameter("idCuentaF"));
        DECU.anio = Integer.parseInt(request.getParameter("anioF"));
        DECU.idPadre = Integer.parseInt(request.getParameter("idPadreF"));
        DECU.cuenta = request.getParameter("cuentaF");
        DECU.cve_persona = Integer.parseInt(request.getParameter("cve_per"));
        DECU.nombreCuenta = request.getParameter("nombredelaCuenta");
        try {
            DECU.Modificar();
            out.print(DECU.si);
        } catch (Exception e) {
            out.print(e);
        }
    }  else if (request.getParameter("insertarNewHijo") != null) {
        DECU.anio = Integer.parseInt(request.getParameter("anioF"));
        DECU.idPadre = Integer.parseInt(request.getParameter("idPadreF"));
        DECU.cuenta = request.getParameter("cuentaF");
        DECU.cve_persona = Integer.parseInt(request.getParameter("cve_per"));
        DECU.nombreCuenta = request.getParameter("nombredelaCuenta");
        DECU.tipo = 1;
        try {
            DECU.InsertarHijo();
            out.print(DECU.si);
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
