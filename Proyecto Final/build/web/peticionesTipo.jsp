<%-- 
    Document   : peticionesTipo
    Created on : 10/09/2022, 9:38:11 p.�m.
    Author     : USUARIO
--%>

<%@page import="Logica.Tipo"%>
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
        "listar"
    });

    String proceso = "" + request.getParameter("proceso");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        if (proceso.equals("listar")) {
            try {
                List<Tipo> lista = new Tipo().listarTipo();
                respuesta += "\"" + proceso + "\": true,\"Tipos\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Tipos\":[]";
                Logger.getLogger(Tipo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inv�lidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>
