package Logica;

import Persisitencia.ConexionBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Daniel Perez
 */
public class Editorial implements InterfaceEditorial{
    private int id_editorial;
    private String nombre;

    public Editorial(int id_editorial, String nombre) {
        this.id_editorial = id_editorial;
        this.nombre = nombre;
    }

    public Editorial() {
    }

    public Editorial(int id_editorial) {
        this.id_editorial = id_editorial;
    }

    public int getId_editorial() {
        return id_editorial;
    }

    public void setId_editorial(int id_editorial) {
        this.id_editorial = id_editorial;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    @Override
    public boolean guardarEditorial(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO editorial (id_editorial, nombre)"
                + " VALUES("+this.id_editorial+",'"+this.nombre+"');";
        if (conexion.setAutoCommitBD(false)) {
            if(conexion.insertarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }
    
    @Override
    public boolean elimnarEditorial() {
        boolean exito = false;
        String sql = "DELETE FROM editorial WHERE id_editorial = " + this.id_editorial + ";";
        ConexionBD conexion = new ConexionBD();
        if(conexion.setAutoCommitBD(false)){
            if(conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }
    
    @Override
    public boolean actualizarEditorial() {
        boolean exito = false;
        String sql = "UPDATE editorial SET nombre ='" + this.nombre + "'"
                + "WHERE id_editorial = " + this.id_editorial + ";";
        ConexionBD conexion = new ConexionBD();
        if(conexion.setAutoCommitBD(false)) {
            if(conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }
    
    @Override
    public List<Editorial> listarEditoriales(){
        List<Editorial> editoriales = new ArrayList();
        String sql = "SELECT * FROM editorial;";
        ConexionBD conexion = new ConexionBD();
        
        ResultSet rs = conexion.consultarBD(sql);
        
        try {
            Editorial e;
            while (rs.next()){
                e = new Editorial();
                e.setId_editorial(rs.getInt("id_editorial"));
                e.setNombre(rs.getString("nombre"));
                editoriales.add(e);
            }
        } catch (SQLException ex){
            Logger.getLogger(Editorial.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
                
        return editoriales;
    }
    
    @Override
    public String toString() {
        return "Editorial{" + "id_editorial=" + id_editorial +
                ",nombre=" + nombre +'}';
    }
    
    @Override
    public Editorial getEditorial() {
        String sql = "SELECT * FROM editorial WHERE id_editorial="+this.id_editorial+";";
        ConexionBD conexion = new ConexionBD();
        
        try {
            ResultSet rs = conexion.consultarBD(sql);
            if (rs.next()) {
                this.id_editorial=rs.getInt("id_editorial");
                this.nombre=rs.getString("nombre");
            }
        } catch (SQLException ex) {
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }
    
}
