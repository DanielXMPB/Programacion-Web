package Logica;

/**
 *
 * @author USUARIO
 */
public class Demo {

    public static void main(String[] args) {
        //Prueba de busqueda para la clase autor que se encuetre en la base de datos
        //Autor a = new Autor("J");
        //a.searchAutor();
        //System.out.print(a);
        //Prueba Agregar Editorial
        //Editorial e = new Editorial(1,"Alianza");
        //e.guardarEditorial();
        //Prueba para agregar una categoria
        //Categoria c = new Categoria(1,"terror","Da miedo");
        //c.guardarCategoria();
        Libro l = new Libro("ISBN 970-686-487-3","Calculo Trascendentes Tempranas Zill 4th",1,1,1,"2006",736,"");
        l.guardarLibro();
    }
}
