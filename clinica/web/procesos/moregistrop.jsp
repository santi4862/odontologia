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
            String nivel = (String) session.getAttribute("nivel");
            conexion con = new conexion();
            String id = request.getParameter("id");
            String nombre = request.getParameter("nombres");
            String apellido = request.getParameter("apellidos");
            String telefono = request.getParameter("telefono");
            String celular = request.getParameter("celular");
            String direccion = request.getParameter("direccion");
            String sexo = request.getParameter("sexo");
            String fecha = request.getParameter("fnacimiento");
            con.consulta("UPDATE personas SET nombres='" + nombre + "', apellidos='" + apellido + "', telefono='" + telefono + "',celular='" + celular + "', direccion='" + direccion + "', fnacimiento='" + fecha + "', sexo='" + sexo + "' WHERE dni='" + id + "';");
            out.print("<script>");
            out.print("swal({title: 'Información del Sistema', text: 'Información Actualizada Correctamente', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
            out.print("if (isConfirm) {");
            out.print("window.location = '../administracion/perfil.jsp';");
            out.print("}");
            out.print("});");
            out.print("</script>");

        %>
    </body>
</html>