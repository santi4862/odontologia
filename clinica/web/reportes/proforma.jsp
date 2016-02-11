<%@page import="java.sql.ResultSet"%>
<%@page import="clases.MailSender"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="clases.conexion"%>
<%
    conexion con = new conexion();
    ResultSet rs = null;
    String pri = "", nom = "", apel = "";//variables de usuario
    String user = request.getParameter("idd");//variable que contiene la sesion activa
    rs = con.consulta("select * from personas where dni='" + user + "'");
    while (rs.next()) {
        pri = rs.getString("correo");
        nom = rs.getString("nombres");
        apel = rs.getString("apellidos");
    }

%>
<%    con.conectar();
    File archivo = new File(application.getRealPath("pdf/proforma.jasper"));
    Map parameters = new HashMap();
    String rutapdf = archivo.getParent() + "/proforma_" + user + ".pdf";
    String hora = request.getParameter("hora");
    String fecha = request.getParameter("fecha");
    parameters.put("paciente", user);
    parameters.put("hora", hora);
    parameters.put("fecha", fecha);
    byte[] bytes = JasperRunManager.runReportToPdf(archivo.getPath(), parameters, con.conexionget());
    JasperPrint reporte = JasperFillManager.fillReport(archivo.getPath(), parameters, con.conexionget());
    JasperExportManager.exportReportToPdfFile(reporte, rutapdf);
    MailSender ms = new MailSender();
    ms.para(pri);
    ms.asunto("Has recibido una Factura Proforma Electrónica Codigo: " + user);
    ms.enviarpdf(rutapdf, "proforma.pdf", "Estimado(a): " + nom + " " + apel + " ha recibido un documento que certifica la solicitacion de un servicio obtenido");
    File borro = new File(rutapdf);
    borro.delete();
    con.desconectar();
    out.println("<script language='javascript'>window.location='../administracion/listaresp.jsp?id=" + user + "'</script>;");
%>
