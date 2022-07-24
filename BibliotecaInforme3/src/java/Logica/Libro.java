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
 * @author MIGUEL HENAO
 */
public class Libro implements InterfaceLibro {

    private String isbn;
    private String nombre;
    private int id_autor;
    private int id_categoria;
    private int id_ediorial;
    private String fechapublicacion;
    private int Paginas;
    private String descripcion;
    private Autor autor;
    private Categoria categoria;
    private Editorial editorial;

    public Libro(String isbn, String nombre, int id_autor, int id_categoria, int id_ediorial, String fechapublicacion, int Paginas, String descripcion) {
        this.isbn = isbn;
        this.nombre = nombre;
        this.id_autor = id_autor;
        this.id_categoria = id_categoria;
        this.id_ediorial = id_ediorial;
        this.fechapublicacion = fechapublicacion;
        this.Paginas = Paginas;
        this.descripcion = descripcion;
    }

    public Libro() {
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getId_autor() {
        return id_autor;
    }

    public void setId_autor(int id_autor) {
        this.id_autor = id_autor;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int Id_categoria) {
        this.id_categoria = Id_categoria;
    }

    public int getId_ediorial() {
        return id_ediorial;
    }

    public void setId_ediorial(int id_ediorial) {
        this.id_ediorial = id_ediorial;
    }

    public String getFechapublicacion() {
        return fechapublicacion;
    }

    public void setFechapublicacion(String fechapublicacion) {
        this.fechapublicacion = fechapublicacion;
    }

    public int getPaginas() {
        return Paginas;
    }

    public void setPaginas(int Paginas) {
        this.Paginas = Paginas;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Autor getAutor() {
        return autor;
    }

    public void setAutor(Autor autor) {
        this.autor = autor;
    }

    public Editorial getEditorial() {
        return editorial;
    }

    public void setEditorial(Editorial editorial) {
        this.editorial = editorial;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    @Override
    public boolean guardarLibro() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO Libro\n"
                + "(isbn, nombre, autor, categoria, id_editorial, fecha_publicacion, paginas, descripcion)\n"
                + "VALUES('" + this.isbn + "','" + this.nombre + "'," + this.id_autor + "," + this.id_categoria + "," + this.id_ediorial + ",'" + this.fechapublicacion + "'," + this.Paginas + ""
                + ",'" + this.descripcion + "');";
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
    public boolean eliminarLibro() {
        boolean exito = false;
        String sql = "DELETE FROM libro\n"
                + "WHERE ISBN='" + this.isbn + "';";
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
    public boolean actualizarLibro() {
        boolean exito = false;
        String sql = "UPDATE Libro SET nombre ='" + this.nombre + "'"
                + ", autor =" + this.autor
                + "categoria=" + this.id_categoria
                + "id_editorial=" + this.id_ediorial
                + "fecha_publicacion='" + this.fechapublicacion + "',paginas=" + this.Paginas + ",descripcion='" + this.descripcion + "'"
                + "WHERE Isbn='" + this.isbn + "';";
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

    public Libro getLibro() {
        String sql = "SELECT * FROM libro WHERE ISBN='" + this.isbn + "';";
        ConexionBD conexion = new ConexionBD();

        ResultSet rs = conexion.consultarBD(sql);

        try {
            if (rs.next()) {
                this.isbn = rs.getString(isbn);
                this.nombre = rs.getString(nombre);
                this.id_autor = rs.getInt("autor");
                this.id_categoria = rs.getInt(id_categoria);
                this.id_ediorial = rs.getInt("editorial");
                this.fechapublicacion = rs.getNString(fechapublicacion);
                this.Paginas = rs.getInt(Paginas);
                this.descripcion = rs.getString(descripcion);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Libro.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }

    @Override
    public List<Libro> listarLibros() {
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM libro;";
        List<Libro> listaA = new ArrayList<>();

        try {
            ResultSet rs = conexion.consultarBD(sql);
            Libro l;
            while (rs.next()) {
                l = new Libro();
                l.setIsbn(rs.getString("isbn"));
                l.setNombre(rs.getString("nombre"));
                l.setId_autor(rs.getInt(id_autor));
                l.setId_categoria(rs.getInt(id_categoria));
                l.setId_ediorial(rs.getInt(id_ediorial));
                l.setFechapublicacion(rs.getString("fechapublicacion"));
                l.setPaginas(rs.getInt(Paginas));
                l.setDescripcion(rs.getString("descripcion"));
                Categoria c = new Categoria(l.getId_categoria());
                l.setCategoria(c.getCategoria());
                Editorial e = new Editorial();
                l.setEditorial(e.getEditorial());
                Autor a = new Autor();
                l.setAutor(a.getAutor());
                listaA.add(l);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Libro.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return listaA;
    }

    @Override
    public String toString() {
        return "Libro{" + "isbn=" + isbn + ", nombre=" + nombre + ", id_autor=" + id_autor + ", id_categoria=" + id_categoria + ", id_ediorial=" + id_ediorial + ", fechapublicacion=" + fechapublicacion + ", Paginas=" + Paginas + ", descripcion=" + descripcion + '}';
    }

    @Override
    public Libro searchLibro() {
        String sql = "SELECT * FROM libro WHERE nombre like '%" + this.nombre + "%'";
        ConexionBD conexion = new ConexionBD();

        ResultSet rs = conexion.consultarBD(sql);

        try {
            if (rs.next()) {
                this.isbn = rs.getString(isbn);
                this.nombre = rs.getString(nombre);
                this.id_autor = rs.getInt("autor");
                this.id_categoria = rs.getInt(id_categoria);
                this.id_ediorial = rs.getInt("editorial");
                this.fechapublicacion = rs.getNString(fechapublicacion);
                this.Paginas = rs.getInt(Paginas);
                this.descripcion = rs.getString(descripcion);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Libro.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }

        return this;
    }

}
