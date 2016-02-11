<%@page import="clases.reporte"%>
<%
    reporte rp = new reporte();
    String ruta = request.getParameter("id");
    rp.abrirpdf(request, response, application, ruta);
%>