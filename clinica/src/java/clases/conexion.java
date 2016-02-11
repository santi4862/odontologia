package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class conexion {

    private String bdd = "clinica";
    private String usuario = "postgres";
    private String clave = "root";
    private String servidor = "localhost";
    private String sgbd = "org.postgresql.Driver";
    private String enlace = "";
    private String jdbc = "postgresql";
    private Connection conecta = null;

    public Connection conexionget() {
        return this.conecta;
    }

    public void bddset(String bdd) {
        this.bdd = bdd;
    }

    public void usuarioset(String usuario) {
        this.usuario = usuario;
    }

    public void claveset() {
        this.clave = clave;
    }

    public void servidorset(String servidor) {
        this.servidor = servidor;

    }

    public void sgbdset(String sgbd) {
        this.sgbd = sgbd;
    }

    public void jdbcset(String jdbc) {
        this.jdbc = jdbc;
    }

    public String bddget() {
        return this.bdd;
    }

    public String usuariget() {
        return this.usuario;
    }

    public String claveget() {
        return this.clave;
    }

    public String servidorget() {
        return this.servidor;
    }

    public String sgbdget() {
        return this.sgbd;
    }

    public String jdbcget() {
        return this.jdbc;
    }

    public void conectar() {
        try {
            Class.forName(this.sgbd);
            this.enlace = "jdbc:" + this.jdbc + "://" + this.servidor + "/" + this.bdd;
            conecta = DriverManager.getConnection(this.enlace, this.usuario, this.clave);
            if (conecta != null) {
                System.out.println("exitoso");
            }
        } catch (SQLException ex) {
            System.out.println("error 1:");
        } catch (ClassNotFoundException ex) {
            System.out.println("error 2:");
        }
    }

    public void desconectar() {
        try {
            conecta.close();
        } catch (SQLException ex) {
            System.out.println("" + ex);
            Logger.getLogger(conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet consulta(String consulta) {
        ResultSet termina = null;
        try {
            this.conectar();
            Statement inicia = (Statement) conecta.createStatement();
            termina = inicia.executeQuery(consulta);
            this.desconectar();

        } catch (SQLException ex) {
            Logger.getLogger(conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return termina;
    }
}
