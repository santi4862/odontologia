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
            String id = request.getParameter("id");
            String id1 = request.getParameter("ni");
            conexion con = new conexion();
            con.consulta("UPDATE personas SET estpersona=true WHERE dni='" + id + "';");
            out.print("<script>");
            out.print("swal({title: 'Informaci�n del Sistema', text: 'Este Registro ha Vuelto a estar Activo', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
            out.print("if (isConfirm) {");
            out.print("window.location = '../administracion/listar.jsp?id=" + id1 + "';");
            out.print("}");
            out.print("});");
            out.print("</script>");
        %>
    </body>
</html>