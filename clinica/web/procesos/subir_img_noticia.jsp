<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../js/sweetalert.min.js"></script> 
        <link rel="stylesheet" type="text/css" href="../css/sweetalert.css">
    </head>
    <body>
        <%
            conexion con = new conexion();
            String user = (String) session.getAttribute("varUsuario");
            String id = request.getParameter("id");
            String destination = "/imgn/";
            String destinationRealPath = application.getRealPath(destination);

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(1024);

            factory.setRepository(new File(destinationRealPath));

            ServletFileUpload uploader = new ServletFileUpload(factory);

            try {
                List items = uploader.parseRequest(request);
                Iterator iterator = items.iterator();

                while (iterator.hasNext()) {
                    FileItem item = (FileItem) iterator.next();
                    File file = new File(destinationRealPath, item.getName());
                    item.write(file);
                    con.consulta("update noticias set imagen='" + destination + "" + item.getName() + "' where id_noticia='" + id + "'");
                    out.print("<script>");
                    out.print("swal({title: 'Información del Sistema', text: 'Noticia Publicada Correctamente', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                    out.print("if (isConfirm) {");
                    out.print("window.location = '../notificacion/lnoticias.jsp';");
                    out.print("}");
                    out.print("});");
                    out.print("</script>");
                }
            } catch (FileUploadException e) {
                out.print("<script>");
                out.print("swal({title: 'Información del Sistema', text: 'Se ha producido un error Interno', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                out.print("if (isConfirm) {");
                out.print("window.location = '../notificacion/lnoticias.jsp';");
                out.print("}");
                out.print("});");
                out.print("</script>");
            } catch (FileNotFoundException f) {
                out.print("<script>");
                out.print("swal({title: 'Información del Sistema', text: 'Se ha producido un error Interno', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                out.print("if (isConfirm) {");
                out.print("window.location = '../notificacion/lnoticias.jsp';");
                out.print("}");
                out.print("});");
                out.print("</script>");
            }


        %>
    </body>
</html>

