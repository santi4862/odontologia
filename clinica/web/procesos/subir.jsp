<%@page import="java.io.FileNotFoundException"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
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
            String destination = "/img/";
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
                    con.consulta("update personas set fotpersona='" + destination + "" + item.getName() + "' where correo='" + user + "'");
                    out.print("<script>");
                    out.print("swal({title: 'Información del Sistema', text: 'Se ha Subido Exitosamente', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                    out.print("if (isConfirm) {");
                    out.print("window.location = '../administracion/foto.jsp';");
                    out.print("}");
                    out.print("});");
                    out.print("</script>");
                }
            } catch (FileUploadException e) {
                out.print("<script>");
                out.print("swal({title: 'Información del Sistema', text: 'Se ha producido un error Interno', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                out.print("if (isConfirm) {");
                out.print("window.location = '../administracion/foto.jsp';");
                out.print("}");
                out.print("});");
                out.print("</script>");
            } catch (FileNotFoundException f) {
                out.print("<script>");
                out.print("swal({title: 'Información del Sistema', text: 'Se ha producido un error Interno', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                out.print("if (isConfirm) {");
                out.print("window.location = '../administracion/foto.jsp';");
                out.print("}");
                out.print("});");
                out.print("</script>");
            }


        %>
    </body>
</html>
