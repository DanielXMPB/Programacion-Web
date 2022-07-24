package Logica;

import java.util.List;

/**
 *
 * @author Daniel Perez
 */
public interface InterfaceEditorial {
    public boolean guardarEditorial();
    public boolean elimnarEditorial();
    public boolean actualizarEditorial();
    public List<Editorial> listarEditoriales();
    public Editorial getEditorial();
}
