<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
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
            DateFormat formatosf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar fechaa = Calendar.getInstance();
            String ahoran = formatosf.format(fechaa.getTime());
            String id = request.getParameter("id");
            conexion con = new conexion();
            ResultSet rs = con.consulta("select * from citas where  estcita!='Aplicada' and idcita='" + id + "'");
            Date ver = null;
            Date actual = formatosf.parse(ahoran);
            while (rs.next()) {
                ver = formatosf.parse(rs.getString("fecha"));
            }
            if (ver.compareTo(actual)==0) {
                con.consulta("UPDATE citas SET estcita='Cancelado' WHERE idcita='" + id + "';");
                out.print("<script>");
                out.print("swal({title: 'Información del Sistema', text: 'La Reservacion a sido Cancelada', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                out.print("if (isConfirm) {");
                out.print("window.location = '../administracion/listarcitas.jsp';");
                out.print("}");
                out.print("});");
                out.print("</script>");

            } else {
                out.print("<script>");
                out.print("swal({title: 'Información del Sistema', text: 'No Puede Cancelar esta Reservacion Fecha Caducada', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                out.print("if (isConfirm) {");
                out.print("window.location = '../administracion/listarcitas.jsp';");
                out.print("}");
                out.print("});");
                out.print("</script>");
            }
        %>
    </body>
</html>