/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import java.util.List;
/**
 *
 * @author Eduar Ortiz
 */
public interface InterfaceCategoria {

    public boolean guardarCategoria();

    public boolean eliminarCategoria();

    public boolean actualizarCategoria();

    public List<Categoria> listarCategorias();
    public Categoria getCategoria();
}
