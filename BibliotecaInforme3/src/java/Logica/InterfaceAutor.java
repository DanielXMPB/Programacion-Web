package Logica;

import java.util.List;

/**
 *
 * @author Daniel Perez
 */
public interface InterfaceAutor {
    public boolean guardarAutor();
    public boolean eliminarAutor();
    public boolean actualizarAutor();
    public List<Autor> listarAutores();
    public Autor getAutor();
    public Autor searchAutor();
}
