<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="clases.fechas"%>
<%@page import="clases.conexion"%>
<%
    conexion con = new conexion();
    fechas fr = new fechas();
    con.conectar();
    String tipor = request.getParameter("tipor");
    File archivo = new File(application.getRealPath(tipor));
    Map parameters = new HashMap();
    String iniciar = request.getParameter("from");
    String finalizar = request.getParameter("to");
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    parameters.put("inicio", iniciar);
    parameters.put("fin", finalizar);
    parameters.put("cantidad", cantidad);
    byte[] bytes = JasperRunManager.runReportToPdf(archivo.getPath(), parameters, con.conexionget());
    response.setContentType("application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream ouputStream = response.getOutputStream();
    ouputStream.write(bytes, 0, bytes.length);
    ouputStream.flush();
    ouputStream.close();
    con.desconectar();

%>
