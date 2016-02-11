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
            String id1 = request.getParameter("ni");
            String nombre = request.getParameter("nombres");
            String especialidad = request.getParameter("especialidad");

            String apellido = request.getParameter("apellidos");
            String telefono = request.getParameter("telefono");
            String celular = request.getParameter("celular");
            String direccion = request.getParameter("direccion");
            String sexo = request.getParameter("sexo");
            String fecha = request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day");
            con.consulta("UPDATE personas SET nombres='" + nombre + "', apellidos='" + apellido + "', telefono='" + telefono + "',celular='" + celular + "', direccion='" + direccion + "', fnacimiento='" + fecha + "', sexo='" + sexo + "' WHERE dni='" + id + "';");
            con.consulta("update doctores set espdoctor='especialidad' where dnidoctor='" + id + "'");
            out.print("<script>");
            out.print("swal({title: 'Información del Sistema', text: 'Información Actualizada Correctamente', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
            out.print("if (isConfirm) {");
            out.print("window.location = '../administracion/listares.jsp?id=" + id1 + "';");
            out.print("}");
            out.print("});");
            out.print("</script>");
        %>
    </body>
</html>