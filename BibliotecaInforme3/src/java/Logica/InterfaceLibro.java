/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Logica;

import java.util.List;

/**
 *
 * @author MIGUEL HENAO
 */
public interface InterfaceLibro {

    public boolean guardarLibro();

    public boolean eliminarLibro();

    public boolean actualizarLibro();

    public List<Libro> listarLibros();

    public Libro getLibro();

    public Libro searchLibro();
}
