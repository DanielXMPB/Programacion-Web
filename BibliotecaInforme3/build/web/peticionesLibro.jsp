<%-- 
    Document   : Archivo de peticiones
    Created on : 06/08/2022, 12:36: PM
    Author     : Miguel Henao
--%>

<%@page import="Logica.Libro"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%    // Iniciando respuesta JSON.
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "guardar",
        "eliminar",
        "actualizar",
        "listar"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardar")) {
            String isbn = request.getParameter("isbn");
            String nombre = request.getParameter("nombre");
            int id_autor = Integer.parseInt(request.getParameter("id_autor"));
            int id_categoria = Integer.parseInt(request.getParameter("id_categoria"));
            int id_ediorial = Integer.parseInt(request.getParameter("id_editorial"));
            String fechapublicacion = request.getParameter("fecha_de_publicacion");
            int Paginas = Integer.parseInt(request.getParameter("paginas"));
            String descripcion = request.getParameter("descripcion");

            Libro lib = new Libro(isbn, nombre, id_autor, id_categoria, id_ediorial, fechapublicacion, Paginas, descripcion);

            if (lib.guardarLibro()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("eliminar")) {
            String isbn = request.getParameter("isbn");
            Libro lib = new Libro(isbn);

            if (lib.eliminarLibro()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("listar")) {
            try {
                Libro l = new Libro();
                List<Libro> lista = l.listarLibros();
                respuesta += "\"" + proceso + "\": true,\"Libros\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Libros\":[]";
                Logger.getLogger(Libro.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            String isbn = request.getParameter("isbn");
            String nombre = request.getParameter("nombre");
            int id_autor = Integer.parseInt(request.getParameter("id_autor"));
            int id_categoria = Integer.parseInt(request.getParameter("id_categoria"));
            int id_ediorial = Integer.parseInt(request.getParameter("id_editorial"));
            String fechapublicacion = request.getParameter("fecha_de_publicacion");
            int Paginas = Integer.parseInt(request.getParameter("paginas"));
            String descripcion = request.getParameter("descripcion");

            Libro lib = new Libro(isbn, nombre, id_autor, id_categoria, id_ediorial, fechapublicacion, Paginas, descripcion);

            if (lib.actualizarLibro()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }
    } // ------------------------------------------------------------------------------------- //
    // -----------------------------------FIN PROCESOS-------------------------------------- //
    // ------------------------------------------------------------------------------------- //
    // Proceso desconocido.
    else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>
