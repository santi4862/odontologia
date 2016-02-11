<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    conexion con = new conexion();
    ResultSet rs = null;
    String nom = "", apel = "", foto = "", id = "";
    String user = (String) session.getAttribute("varUsuario");
    if (user == null) {
        response.sendRedirect("../administracion/logina.jsp");
    } else {

    }
%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administracion</title>
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="../assets/css/zabuto_calendar.css">
        <link rel="stylesheet" type="text/css" href="../assets/js/gritter/css/jquery.gritter.css" />
        <link rel="stylesheet" type="text/css" href="../assets/lineicons/style.css">   
        <link href="../assets/css/style.css" rel="stylesheet">
        <link href="../assets/css/style-responsive.css" rel="stylesheet">
        <script src="../assets/js/chart-master/Chart.js"></script>

        <script type="text/javascript" src="../js/validar.js"></script>
    </head>

    <body>

        <section id="container" >


            <!--inicio de contenido-->

            <center> <h4><i class='fa fa-list'></i> Listado de registros </h4></center>
            <div class="row mt">

                <div class="col-lg-12">
                    <div class="form-panel">

                        <br> <br>
                        <form  id="listares" name="listarser" action="datos.jsp" method="POST">
                            <div class="form-group">
                                <select autofocus required class="form-control" name="tbuscar" id="tbuscar">
                                    <option value="">Seleccione la Especilidad a Atenderse</option>
                                    <%
                                        rs = con.consulta("select * from especialidad where estesp='true'");
                                        while (rs.next()) {
                                            out.print(" <option value='" + rs.getString("codesp") + "'>" + rs.getString("nomesp") + "</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <input type="text"  class="form-control" id="busqueda" name="busqueda" placeholder="Realice su busqueda por codigo de doctor si es nesesario" title="Realice su busqueda por codigo de doctor si es nesesario">
                            </div>

                            <button type="submit" class="btn btn-default btn-green" id="buscar" name="buscar">Buscar Registro</button>
                        </form>
                        <br>
                        <div class="form-group">

                            <%
                                if (request.getParameter("buscar") != null) {
                                    String valor = request.getParameter("tbuscar");
                                    String buscar = request.getParameter("busqueda");
                                    String consulta = "";
                                    consulta = "select d.*, e.*,p.* from doctores d,especialidad e,personas p where p.dni=d.dnidoctor and e.codesp=d.espdoctor and d.estdoctor='true' and e.estesp='true' and  d.espdoctor='" + valor + "' or d.dnidoctor='" + buscar + "'";
                                    rs = con.consulta(consulta);
                                    int contador = 0;
                                    while (rs.next()) {
                                        contador++;
                                    }
                                    rs = con.consulta(consulta);
                                    if (contador > 0) {
                                        out.print("<table class='table table-striped table-advance table-hover'>");
                                        out.print("  <hr>");
                                        out.print(" <thead>");
                                        out.print("  <tr>");
                                        out.print("    <th><i class='fa fa-barcode'></i> Codigo Doctor</th>");
                                        out.print("    <th class='hidden-phone'><i class='fa fa-list-alt'></i>Nombres</th>");
                                        out.print("    <th class='hidden-phone'><i class='fa fa-list'></i>Apellidos</th>");
                                        out.print("    <th class='hidden-phone'><i class='fa fa-check-square-o'></i>Especilidad</th>");

                                        out.print("    <th></th>");
                                        out.print("</tr>");
                                        out.print(" </thead>");
                                        out.print("  <tbody>");
                                        while (rs.next()) {
                                            out.print("   <tr onclick=enviar('" + rs.getString("dni") + "','" + rs.getString("iddoctor") + "')>");
                                            out.print("  <td>" + rs.getString("dni") + "</td>");
                                            out.print("    <td class='hidden-phone'>" + rs.getString("nombres") + "</td>");
                                            out.print("    <td class='hidden-phone'>" + rs.getString("apellidos") + "</td>");
                                            out.print("    <td class='hidden-phone'>" + rs.getString("nomesp") + "</td>");
                                            out.print(" </tr>");
                                        }
                                        out.print("  </tbody>");
                                        out.print(" </table>");
                                    } else {
                                        out.print("No Existen Registros");
                                    }
                                }
                            %>

                        </div>
                    </div>
                </div>  

        </section>

        <!-- Plugin utilizados a iniciar -->
        <script src="../assets/js/jquery.js"></script>
        <script src="../assets/js/jquery-1.8.3.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="../assets/js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="../assets/js/jquery.scrollTo.min.js"></script>
        <script src="../assets/js/jquery.nicescroll.js" type="text/javascript"></script>
        <script src="../assets/js/jquery.sparkline.js"></script>
        <script src="../assets/js/common-scripts.js"></script>
        <script type="text/javascript" src="../assets/js/gritter/js/jquery.gritter.js"></script>
        <script type="text/javascript" src="../assets/js/gritter-conf.js"></script>
        <script src="../assets/js/sparkline-chart.js"></script>    
        <script src="../assets/js/zabuto_calendar.js"></script>	
    </body>
</html>
