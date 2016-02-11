<%
    String user = (String) session.getAttribute("varUsuario");

    if (user == null) {
        response.sendRedirect("../administracion/logina.jsp");
    }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Odontologia</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/style.css" rel="stylesheet">
        <script type="text/javascript" src="../js/validar.js"></script>
        <script src="../js/sweetalert.min.js"></script> 
        <link rel="stylesheet" type="text/css" href="../css/sweetalert.css">
    </head>
    <body class="contentpage">
        <!-- Navigacion del menu inicio -->
        <div class="navbar navbar-default navbar-fixed-top affix inner-pages" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <h1><a class="navbar-brand" href="index.html">Odontologia Dental <img src="../images/logo.jpg" alt="" width="50"/><br><br>
                            <h6>Cuidamos tu sonrisa odontologos con la mas alta capacidad profesional</h6>
                        </a></h1>
                </div>	
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="../index.html" title="Inicio"><span data-hover="Inicio">Inicio</span></a>
                        </li>
                        <li>
                            <a href="../quienes.html" title="Quienes Somos"><span data-hover="Quienes Somos">Quienes Somos</span></a>
                        </li>
                        <li>
                            <a href="../mision.html" title="Misión Visión"><span data-hover="Misión Visión">Misión Visión</span></a>
                        </li>

                        <li>
                            <a href="../contactos.html" title="Contactos"><span data-hover="Contactos">Contactos</span></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span data-hover="Servicios">Servicios</span> <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="../acceso.html" title="Acesso al sistema">Acesso al sistema</a>
                                </li>
                                <%
                                    if (user != null) {

                                %>
                                <li>
                                    <a href="../procesos/cerrar.jsp" title="Cerrar Sistema">Cerrar Sistema</a>
                                </li>
                                <%    }
                                %>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Navigacion del menu final -->
        <br>
        <br>
        <br>
        <br>

        <!-- Inicio de informacion -->
        <div class="container">
            <div class="row">
                <div class="col-md-12 centered">
                    <h3><span>Listado de registros del paciente</span></h3>
                    <p>Por favor el sistema entregara toda la informacion correcta usela con cuidado</p>
                </div>
            </div>
        </div>
        <!-- fin de informacion -->
        <br>
        <br>
        <!-- inicio de formulario -->
        <div class="container content">
            <div class="row">
                <div class="col-md-9">
                    <form  id="mregistrop" name="mregistrop" action="../registros/mregistrop.jsp" method="POST">
                        <div class="form-group">
                            <select autofocus required class="form-control" name="tdocumento" id="tdocumento">
                                <option value="">Seleccione el tipo de busqueda que requiere</option>
                                <option value="0">DNI</option>
                                <option value="1">Apellidos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="text" required class="form-control" id="busqueda" name="busqueda" placeholder="Ingrese lo que desea buscar">
                        </div>

                        <button type="submit" class="btn btn-default btn-green" id="buscar" name="buscar">Buscar Registro</button>
                    </form>
                    <br>
                    <div class="form-group">


                        <%                            if (request.getParameter("buscar") != null) {
                                conexion con = new conexion();
                                String valor = request.getParameter("tdocumento");
                                String buscar = request.getParameter("busqueda");
                                String consulta = "";
                                if (valor.equals("0")) {
                                    consulta = "select * from personas where dni like'%" + buscar + "%'";
                                } else if (valor.equals("1")) {
                                    consulta = "select * from personas where apellidos like'%" + buscar + "%'";
                                }
                                ResultSet rs = con.consulta(consulta);
                                int contador = 0;
                                while (rs.next()) {
                                    contador++;
                                }
                                rs = con.consulta(consulta);
                                if (contador > 0) {
                                    out.print("<table border='1'");
                                    out.print("<tbody>");
                                    out.print(" <tr>");
                                    out.print("  <td>DNI </td>");
                                    out.print(" <td>Nombres</td>");
                                    out.print(" <td>Apellidos</td>");
                                    out.print(" <td>Estado</td>");
                                    out.print(" <td>Accion</td>");
                                    out.print("</tr>");
                                    while (rs.next()) {
                                        out.print("<tr>");
                                        out.print("  <td>" + rs.getString("dni") + "</td>");
                                        out.print("  <td>" + rs.getString("nombres") + "</td>");
                                        out.print("  <td>" + rs.getString("apellidos") + "</td>");
                                        out.print("  <td>" + rs.getString("estpersona") + "</td>");
                                        out.print("  <td>&nbsp;<a href=../registros/modregistrop.jsp?id=" + rs.getString("dni") + "><img src=../img/editar.png width=30px height=30px></a>"
                                                + "&nbsp;<a href=../procesos/eregistrop.jsp?id=" + rs.getString("dni") + "><img src=../img/borrar.png width=30px height=30px></a>"
                                                + "&nbsp;<a href=../procesos/aregistrop.jsp?id=" + rs.getString("dni") + "><img src=../img/activar.png width=30px height=30px></a>"
                                                + "&nbsp;<a href=../procesos/elregistrop.jsp?id=" + rs.getString("dni") + "><img src=../img/eliminar.png width=30px height=30px></a></td>");
                                        out.print(" </tr>");
                                    }
                                    out.print("</tbody>");
                                    out.print("</table>");
                                } else {

                                }
                            }
                        %>

                    </div>

                </div>

            </div>
        </div>
        <br>
        <br>
        <!-- fin del formulario -->

        <!-- Pie de pagina inicio -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <h6>Acerca de Nosotros</h6>
                        <p>Estamos comprometidos con la excelencia en todas las facetas de este arte y ciencia. Estamosn orgullosos de la calidad de nuestro trabajo, utilizando los mejores materiales disponibles. Trabajamos con técnicos protésicos y artistas dentales altamente preparados, que siguen nuestro compromiso por la excelencia.</p>
                    </div>
                    <div class="col-md-3">
                        <h6>Valores de la Institución</h6>
                        <p>Trabajo en equipo ágil y multidisciplinar</p>
                        <p>Trato humano y personalizado</p>
                        <p>Atención global de la persona</p>
                        <p>Compromiso con la sociedad</p>
                    </div>
                    <div class="col-md-3">
                        <h6>Mapa de sitio:</h6>
                        <ul>
                            <li><a href="index.html" title="">Inicio</a></li>
                            <li><a href="contactos.html" title="">Contactos</a></li>
                            <li><a href="quienes.html" title="">Terminos y condiciones</a></li>
                            <li><a href="politicas.html" title="">Politicas de Privacidad</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3 contact-info">
                        <h6>Información  de la Institucion</h6>
                        <p>Toda la informacion se entrega para contactos a la institución por parte de la Dra. Gulnara Obando V.</p>
                        <p class="social">
                            <a href="#" class="facebook"></a> <a href="#" class="pinterest"></a> <a href="#" class="twitter"></a>
                        </p>
                        <p class="c-details">
                            <span>Email </span>odontologiadental@hotmail.com<br >
                            <span>Teléf</span> 2 365-069</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 copyright">
                        <p>&copy;  Copyright 2015 Odontologia Dental Todos lo derechos Reservados. <a href="index.html">Diseñado: Grupo Odontologia Dental</a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- termina pie de pagina -->



        <!-- Javascript plugins -->
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/carouFredSel.js"></script>
        <script src="../js/jquery.stellar.min.js"></script>
        <script src="../js/custom.js"></script>
        <script src="../js/jquery-ui.min.js"></script>


    </body>
</html>
<%
    if (session.getAttribute("usuario") != null) {
        out.print("si");
    } else {
        out.print("no");
    }

%>