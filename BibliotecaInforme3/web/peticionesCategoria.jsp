<%-- 
    Document   : peticionesCategoria
    Created on : 29/07/2022, 10:33:27 p. m.
    Author     : Eduar Ortiz
--%>
<%@page import="Logica.Categoria"%>
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

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("guardar")) {
            String id_categoria = request.getParameter("id_categoria");
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            Categoria c = new Categoria(Integer.parseInt(id_categoria), nombre, descripcion);

            if (c.guardarCategoria()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
            String id_categoria = request.getParameter("id_categoria");
            Categoria c = new Categoria(Integer.parseInt(id_categoria));
            if (c.eliminarCategoria()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("actualizar")) {
            String id_categoria = request.getParameter("id_categoria");
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            Categoria e = new Categoria(Integer.parseInt(id_categoria), nombre, descripcion);
            if (e.actualizarCategoria()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {

            try {
                Categoria c = new Categoria();
                List<Categoria> lista = c.listarCategorias();
                respuesta += "\"" + proceso + "\": true,\"Categorias\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Categorias\":[]";
                Logger.getLogger(Categoria.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
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
