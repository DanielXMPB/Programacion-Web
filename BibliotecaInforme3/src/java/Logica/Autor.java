/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
public class Autor implements InterfaceAutor{
    private int id_autor;
    private String nombre;
    private String alias;
    private String nacionalidad;

    public Autor(int id_autor, String nombre, String alias, String nacionalidad) {
        this.id_autor = id_autor;
        this.nombre = nombre;
        this.alias = alias;
        this.nacionalidad = nacionalidad;
    }

    public Autor() {
    }

    public Autor(int id_autor) {
        this.id_autor = id_autor;
    }

    public Autor(String nombre) {
        this.nombre = nombre;
    }

    public int getId_autor() {
        return id_autor;
    }

    public void setId_autor(int id_autor) {
        this.id_autor = id_autor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }
    
    @Override
    public boolean guardarAutor(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO autor"
                + "(id_autor, nombre, alias, nacionalidad)"
                + "VALUES(" + this.id_autor + ", '" + this.nombre + "', '" + this.alias + "', '" + this.nacionalidad + "');";
        if(conexion.setAutoCommitBD(false)){
            if(conexion.insertarBD(sql)){
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            }else{
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }
    
    @Override
    public boolean eliminarAutor() {
        boolean exito = false;
        String sql = "DELETE FROM autor WHERE id_autor = " + this.id_autor + ";";
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
    public boolean actualizarAutor() {
        boolean exito = false;
        String sql = "UPDATE autor SET nombre ='"+this.nombre+"'"
                + ",alias ='"+this.alias+"', nacionalidad ='"+this.nacionalidad+"'"
                + "WHERE id_autor=" + this.id_autor + ";";
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
    public List<Autor> listarAutores() {
        List<Autor> autores = new ArrayList<>();
        String sql = "SELECT * FROM autor;";
        ConexionBD conexion = new ConexionBD();
        
        ResultSet rs = conexion.consultarBD(sql);
        
        try {
            Autor a;
            while (rs.next()) {
                a = new Autor();
                a.setId_autor(rs.getInt("id_autor"));
                a.setNombre(rs.getString("nombre"));
                a.setAlias(rs.getString("alias"));
                a.setNacionalidad(rs.getString("nacionalidad"));
                autores.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Autor.class.getName()).log(Level.SEVERE,null,ex);
        } finally {
            conexion.cerrarConexion();
        }
        
        return autores;
    }
    
    @Override
    public String toString(){
        return "Autor{" + "id_autor=" + id_autor +
                ",nombre =" + nombre + ",alias=" + alias +
                ",nacionalidad=" + nacionalidad + '}';
    }
    
    @Override
    public Autor getAutor() {
        String sql = "SELECT * FROM autor WHERE codigo="+this.id_autor+";";
        ConexionBD conexion = new ConexionBD();
        
        ResultSet rs = conexion.consultarBD(sql);
        
        try {
            if (rs.next()) {
                this.id_autor=rs.getInt("id_autor");
                this.nombre=rs.getString("nombre");
                this.alias=rs.getString("alias");
                this.nacionalidad=rs.getString("nacionalidad");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Autor.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }
    
    @Override
    public Autor searchAutor(){
        String sql = "SELECT id_autor,nombre,alias,nacionalidad FROM autor WHERE nombre like '%"+this.nombre+"%'";
        ConexionBD conexion = new ConexionBD();
        
        ResultSet rs = conexion.consultarBD(sql);
        
        try{
            if (rs.next()) {
                this.id_autor=rs.getInt("id_autor");
                this.nombre=rs.getString("nombre");
                this.alias=rs.getString("alias");
                this.nacionalidad=rs.getString("nacionalidad");
            }
        } catch(SQLException ex) {
            Logger.getLogger(Autor.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        
        return this;
    }
}
