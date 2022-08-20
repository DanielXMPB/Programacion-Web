<%-- 
    Document   : Archivo de peticiones
    Created on : 20/07/2022, 10:07: AM
    Author     : Daniel Perez
--%>

<%@page import="Logica.Editorial"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%
    String respuesta = "{";

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
            String id_editorial = request.getParameter("id_editorial");
            String nombre = request.getParameter("nombre");
            Editorial e = new Editorial(Integer.parseInt(id_editorial),nombre);
            
            if (e.guardarEditorial()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";  
            }
            
        } else if (proceso.equals("eliminar")) {
            String id_editorial=request.getParameter("id_editorial");        
            Editorial e = new Editorial(Integer.parseInt(id_editorial));
            if (e.elimnarEditorial()) {
                respuesta += "\"" + proceso + "\": ture";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
            
        } else if (proceso.equals("actualizar")) {
            String id_editorial=request.getParameter("id_editorial");
            String nombre=request.getParameter("nombre");
            Editorial e = new Editorial(Integer.parseInt(id_editorial),nombre);
            if (e.actualizarEditorial()) {                     
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
            
        } else if (proceso.equals("listar")) {
            try {
                Editorial e= new Editorial();
                List<Editorial> lista =e.listarEditoriales();
                respuesta += "\"" + proceso + "\": true,\"Editoriales\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Editoriales\":[]";
                Logger.getLogger(Editorial.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("listarporid")) {
            String id_editorial = request.getParameter("id_editorial");
            Editorial e =null;
            try {
                 e = new Editorial(Integer.parseInt(id_editorial)).getEditorial();
                respuesta += "\"" + proceso + "\": true,\"Libro\":" + new Gson().toJson(e);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": false,\"Libro\":"+new Gson().toJson(e);
                Logger.getLogger(Editorial.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
            + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>