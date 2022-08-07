<%-- 
    Document   : Archivo de peticiones
    Created on : 20/07/2022, 10:07: AM
    Author     : Daniel Perez
--%>

<%@page import="Logica.Autor"%>
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
        "listar",
        "buscar"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardar")) {

            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creación de objeto y llamado a método guardar 
            String id_autor = request.getParameter("id_autor");
            String nombre = request.getParameter("nombre");
            String alias = request.getParameter("alias");
            String nacionalidad = request.getParameter("nacionalidad");
            Autor a = new Autor(Integer.parseInt(id_autor), nombre, alias, nacionalidad);

            if (a.guardarAutor()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar

            String id_autor = request.getParameter("id_autor");
            Autor a = new Autor(Integer.parseInt(id_autor));
            if (a.eliminarAutor()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                Autor a = new Autor();
                List<Autor> lista = a.listarAutores();
                respuesta += "\"" + proceso + "\": true,\"Autores\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Autores\":[]";
                Logger.getLogger(Autor.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            String id_autor = request.getParameter("id_autor");
            String nombre = request.getParameter("nombre");
            String alias = request.getParameter("alias");
            String nacionalidad = request.getParameter("nacionalidad");
            Autor a = new Autor(Integer.parseInt(id_autor), nombre, alias, nacionalidad);
            if (a.actualizarAutor()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("buscar")) {
            String nombre = request.getParameter("nombre");
            Autor a = new Autor(nombre);
            a.searchAutor();
            respuesta += "\"" + proceso + "\": true,\"Autor\":" + new Gson().toJson(a);
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
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
