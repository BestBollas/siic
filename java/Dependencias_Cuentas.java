/*
 * Esta clase es para depencencias_cuesntas.jsp
 */
package control_prezupueztal;
//Todas las librerias en comun
import comun.BD;
import java.sql.*;
import java.lang.*;
//import java.sql.Date.*;
import java.util.*;
import java.util.Date;
/*
 * Autor Sigmud Eder Bollas Tovar 28/11/2013 9:51
 */

public class Dependencias_Cuentas {

    Connection con; // variable de tipo coneccion
    ResultSet rs, rp;	// variable de tipo resultado para mostrar los querys
    Statement smt;
    BD SMBD = new BD();
    public int idCuentaMaximo, anio, si, cve_persona, tipo, idPadre, anioF, bandera, flag, idCuenta;
    public String cuenta, consultas, nombreCuenta;

    public Dependencias_Cuentas() {
        idCuentaMaximo = 0;
        flag = 0;
        anio = 0;
        si = 0;
        bandera = 0;
        idPadre = 0;
        cuenta = "";
        idCuenta = 0;
        consultas = "";
        cve_persona = 0;
        tipo = 0;
        nombreCuenta = "";
        anioF = 0;
    }

    public void modificarTipo() throws Exception {
        consultas = "UPDATE DEPENDENCIAS_CUENTAS set TIPO=0"
                + " where (ID_CUENTA=" + idPadre + ") AND "
                + "(ANIO='" + anio + "')";
        si = SMBD.insertarSQL(consultas);
        SMBD.desconectarBD();
    }

    public void InsertarHijo() throws Exception {
        modificarTipo();
        if (si != 0) {
            MaximoId();
            consultas = "INSERT INTO DEPENDENCIAS_CUENTAS "
                    + "(ID_CUENTA,ANIO,CUENTA,PADRE,CVE_PERSONA,TIPO,NOMBRE_CUENTA) "
                    + "values(" + idCuentaMaximo + "," + anio + ",'" + cuenta + "'," + idPadre + "," + cve_persona + "," + tipo + ",'" + nombreCuenta + "')";
            si = SMBD.insertarSQL(consultas);
            SMBD.desconectarBD();
        }
    }

    public void Insertar() throws Exception {

        MaximoId();
        consultas = "INSERT INTO DEPENDENCIAS_CUENTAS (ID_CUENTA,ANIO,CUENTA,PADRE,CVE_PERSONA,TIPO,NOMBRE_CUENTA) "
                + "values(" + idCuentaMaximo + "," + anio + ",'" + cuenta + "'," + idPadre + "," + cve_persona + "," + tipo + ",'" + nombreCuenta + "')";
        si = SMBD.insertarSQL(consultas);
        SMBD.desconectarBD();
    }

    public void Modificar() throws Exception {
        consultas = "UPDATE DEPENDENCIAS_CUENTAS "
                + "set ID_CUENTA=" + idCuenta + " , ANIO=" + anio + " , CUENTA='" + cuenta + "' , PADRE=" + idPadre + ",NOMBRE_CUENTA='" + nombreCuenta + "' "
                + "WHERE (ID_CUENTA=" + idCuenta + ") AND (ANIO=" + anio + ")";
        si = SMBD.insertarSQL(consultas);
        SMBD.desconectarBD();

    }

    public void Eliminar() throws Exception {
        consultas = "DELETE DEPENDENCIAS_CUENTAS"
                + " WHERE (ID_CUENTA=" + idCuenta + ") AND (ANIO=" + anioF + ")";
        si = SMBD.insertarSQL(consultas);
        SMBD.desconectarBD();
        modificarTipoHijo();
    }

    public int esPapa() throws Exception {
        consultas = "SELECT padre "
                + "FROM sic.DEPENDENCIAS_CUENTAS WHERE "
                + "(ID_CUENTA="+idPadre+") AND (ANIO="+anioF+")";
        
        rs = SMBD.SQLBD2(consultas);
        if (rs.next()) {
            bandera = rs.getInt(1);
        }
        
        return bandera;
    }

    public void modificarTipoHijo() throws Exception {
        if (validaHijo(idPadre) != 0) {
            System.out.println("Tiene hijos");
        } else {
            if (esPapa() == 0) {
                System.out.println("Es Papa");
            } else {
                System.out.println("No tiene hijos ejecutar la funcion moficiarHijos");
                consultas = "UPDATE DEPENDENCIAS_CUENTAS set TIPO=1"
                        + " where (ID_CUENTA=" + idPadre + ") AND "
                        + "(ANIO='" + anioF + "')";
                si = SMBD.insertarSQL(consultas);
                SMBD.desconectarBD();
            }
        }
    }

    public void MaximoId() throws Exception {
        consultas = "SELECT MAX(ID_CUENTA) "
                + "FROM sic.DEPENDENCIAS_CUENTAS "
                + "WHERE (ANIO=" + anio + ")";
        rs = SMBD.SQLBD2(consultas);
        while (rs.next()) {
            idCuentaMaximo = rs.getInt(1) + 1;
        }
        SMBD.desconectarBD();
    }

    public int cuentaRepetida() throws Exception {
        consultas = "SELECT sic.DEPENDENCIAS_CUENTAS.ID_CUENTA,sic.DEPENDENCIAS_CUENTAS.ANIO,sic.DEPENDENCIAS_CUENTAS.CUENTA,sic.DEPENDENCIAS_CUENTAS.PADRE,sic.DEPENDENCIAS_CUENTAS.FECHA_CREACION ,sic.DEPENDENCIAS_CUENTAS.CVE_PERSONA,sic.DEPENDENCIAS_CUENTAS.TIPO,sic.DEPENDENCIAS_CUENTAS.NOMBRE_CUENTA "
                + "FROM sic.DEPENDENCIAS_CUENTAS "
                + "WHERE (sic.DEPENDENCIAS_CUENTAS.ANIO=" + anio + ") AND "
                + "(sic.DEPENDENCIAS_CUENTAS.CUENTA='" + cuenta + "')";
        rs = SMBD.SQLBD2(consultas);
        if (rs.next()) {
            bandera = rs.getInt(1);
        }
        return bandera;
    }

    public int validaEliminar() throws Exception {
        consultas = "SELECT SIC.DEPENDENCIAS_CUENTAS.TIPO "
                + "FROM DEPENDENCIAS_CUENTAS,ZALDO_PROYEKTO_MENSUAL "
                + "WHERE (sic.DEPENDENCIAS_CUENTAS.CUENTA=sic.ZALDO_PROYEKTO_MENSUAL.CUENTA) AND "
                + "(sic.DEPENDENCIAS_CUENTAS.TIPO=1) AND "
                + "(sic.DEPENDENCIAS_CUENTAS.ANIO=sic.ZALDO_PROYEKTO_MENSUAL.ANIO) AND "
                + "(sic.ZALDO_PROYEKTO_MENSUAL.NUM_MES=1) AND "
                + "(sic.DEPENDENCIAS_CUENTAS.CUENTA='" + cuenta + "')";
        rs = SMBD.SQLBD2(consultas);
        while (rs.next()) {
            flag = 1;
        }
        return flag;
    }

    public int validaHijo(int idCuen) throws Exception {
        consultas = "SELECT sic.DEPENDENCIAS_CUENTAS.ID_CUENTA "
                + "FROM sic.DEPENDENCIAS_CUENTAS "
                + "WHERE (sic.DEPENDENCIAS_CUENTAS.PADRE=" + idCuen + ") AND "
                + "(sic.DEPENDENCIAS_CUENTAS.ANIO=" + anioF + ")";

        rs = SMBD.SQLBD2(consultas);
        while (rs.next()) {
            bandera = 1;
        }
        return bandera;
    }

    public static void main(String[] args) throws Exception {
        BD SMBD = new BD();
        SMBD.cve_proyekto = 139;
        SMBD.cve_partida = 186;


        //               System.out.println(SMBD.fecha_convertida_tiempo_real("18/06/2013"));

//                SMBD.datoz_proyekto(110, 123,"10/06/2013" );

        /*                System.out.println(SMBD.fecha_convertida_tiempo_real_compaq("24/01/2013") );
         /*                ResultSet rs;
         rs = SMBD.SQLBDCOMPAQ("SELECT Codigo, Nombre "
         +"FROM   ctUNIVERSIDAD_TECNOLOGICA_SAN_JUAN_DE.dbo.Cuentas "
         +"WHERE     (Afectable = 1) AND (EsBaja = 0) AND (Id > 12) "
         +"ORDER BY Codigo");
         while (rs.next())
         {
         System.out.println(rs.getString(1)+" -- "+rs.getString(2));
         }
         SMBD.desconectarBD();*/
        System.out.println(SMBD.nombre_persona(97));

    }
}
