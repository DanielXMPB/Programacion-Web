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
 * @author Eduar Ortiz
 */
public class Categoria implements InterfaceCategoria{

    private int id_categoria;
    private String nombre;
    private String descripcion;

    public Categoria(int id_categoria, String nombre, String descripcion) {
        this.id_categoria = id_categoria;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public Categoria() {
    }

    public Categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public boolean guardarCategoria() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO categoria"
                + "(id_categoria, nombre, descripcion)"
                + "VALUES(" + this.id_categoria + ",'" + this.nombre + "', '" + this.descripcion + "');";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sql)) {
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
    public boolean eliminarCategoria() {
        boolean exito = false;
        String sql = "DELETE FROM categoria WHERE id_categoria=" + this.id_categoria + ";";
        ConexionBD conexion = new ConexionBD();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
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
    public boolean actualizarCategoria() {
        boolean exito = false;
        String sql = "UPDATE categoria\n" +
                "SET nombre='"+this.nombre+"', descripcion='"+this.descripcion+"'\n" +
                "WHERE id_categoria="+this.id_categoria+";";
        ConexionBD conexion = new ConexionBD();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
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
    public List<Categoria> listarCategorias() {

        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM categoria;";
        ConexionBD conexion = new ConexionBD();

        ResultSet rs = conexion.consultarBD(sql);

        try {
            Categoria c;
            while (rs.next()) {
                c = new Categoria();
                c.setNombre(rs.getString("nombre"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setId_categoria(rs.getInt("id_categoria"));
                categorias.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Categoria.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }

        return categorias;
    }

    @Override
    public Categoria getCategoria() {
        String sql = "SELECT * FROM categoria WHERE id_categoria=" + this.id_categoria + ";";
        ConexionBD conexion = new ConexionBD();

        ResultSet rs = conexion.consultarBD(sql);

        try {
            if (rs.next()) {
                this.id_categoria = rs.getInt("id_categoria");
                this.descripcion = rs.getString("descripcion");
                this.nombre = rs.getString(rs.getString("nombre"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Categoria.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }
}
