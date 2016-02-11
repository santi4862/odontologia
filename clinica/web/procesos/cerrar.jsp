<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../js/sweetalert.min.js"></script> 
        <link rel="stylesheet" type="text/css" href="../css/sweetalert.css">
    </head>
    <body>
        <%
            session.invalidate();
            out.print("<script>");
            out.print("window.location = '../administracion/logina.jsp';");
            out.print("</script>");
        %>
    </body>
</html>

