<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../js/sweetalert.min.js"></script> 
        <link rel="stylesheet" type="text/css" href="../css/sweetalert.css">
    </head>
    <body>
        <%
            ResultSet rs = null;
            HttpSession op = request.getSession();
            String conteo = "", usuario = "", clave = "", correo = "";
            usuario = request.getParameter("usuario");
            clave = request.getParameter("clave");
            conexion con = new conexion();
            rs = con.consulta("select count(*),p.* from personas p where correo='" + usuario + "'  and clave=md5('" + clave + "') and estpersona='true' and estactivo='true' group by p.dni");
            while (rs.next()) {
                conteo = rs.getString("count");
                correo = rs.getString("correo");
            }
            if (conteo.equals("1")) {
                op.setAttribute("varUsuario", correo);
                op.setAttribute("mover", "0");
                op.setAttribute("contener", "");
                op.setAttribute("temporal", "");
        %> <script>
            swal({title: "Acceso Concedido", text: "Tus datos han sido Correctos", type: "success", showCancelButton: false, confirmButtonColor: "#01DF3A", confirmButtonText: "Acceder", cancelButtonText: "No, cancel plx!", closeOnConfirm: false, closeOnCancel: false}, function (isConfirm) {
                if (isConfirm) {
                    window.location = "../administracion/panela.jsp";
                }
            });

        </script><%
        } else {
        %><script>
            swal({title: "Acceso Denegado", text: "Tus datos han sido Incorrectos", type: "error", showCancelButton: false, confirmButtonColor: "#DD6B55", confirmButtonText: "Volver a Intentar", cancelButtonText: "No, cancel plx!", closeOnConfirm: false, closeOnCancel: false}, function (isConfirm) {
                if (isConfirm) {
                    window.location = "../administracion/logina.jsp";
                }
            });

        </script><%
            }
        %>
    </body>
</html>


