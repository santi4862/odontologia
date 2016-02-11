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
        String user = (String) session.getAttribute("varUsuario");//variable que contiene la sesion activa
        String url = request.getRequestURI();//varible que extrae url de pagina
        rs = con.consulta("select * from personas where correo='" + user + "'");
        while (rs.next()) {
            pri = rs.getString("tpersona");
            nom = rs.getString("nombres");
            apel = rs.getString("apellidos");
        }
%>
<%
    con.conectar();
    File archivo = new File(application.getRealPath("pdf/factura.jasper"));
    Map parameters = new HashMap();
    int idfactura = Integer.parseInt(request.getParameter("id"));
    String rutapdf = archivo.getParent() + "/factura_" + idfactura + ".pdf";
    String rutaxml = archivo.getParent() + "/factura_" + idfactura + ".xml";
    parameters.put("codigo", idfactura);
    byte[] bytes = JasperRunManager.runReportToPdf(archivo.getPath(), parameters, con.conexionget());
    JasperPrint reporte = JasperFillManager.fillReport(archivo.getPath(), parameters, con.conexionget());
    JasperExportManager.exportReportToPdfFile(reporte, rutapdf);
    JasperExportManager.exportReportToXmlFile(reporte, rutaxml, false);
    MailSender ms = new MailSender();
    ms.para(user);
    ms.asunto("Has recibido una Factura Electrónica Codigo: " + idfactura);
    ms.enviarpdfxml(rutapdf, "Factura.pdf", rutaxml, "Factura.xml", "Estimado(a): " + nom + " " + apel + " ha recibido un documento que certifica el pago de su servicio obtenido");
    File borro = new File(rutapdf);
    borro.delete();
    borro = new File(rutaxml);
    borro.delete();
    con.desconectar();
    out.println("<script language='javascript'>window.location='../administracion/facturas.jsp'</script>;");
%>
