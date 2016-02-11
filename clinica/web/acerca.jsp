<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Calendar fecha = Calendar.getInstance();
    int a = fecha.get(Calendar.YEAR);
    conexion con = new conexion();
    ResultSet rs = con.consulta("select * from empresa");
    String empresa = "", logo = "", telefonoi = "", correoi = "";
    while (rs.next()) {
        empresa = rs.getString("nombre");
        logo = rs.getString("logo");
        telefonoi = rs.getString("telefonoi");
        correoi = rs.getString("correoi");
    }
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%out.print(empresa);%></title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <script src="js/sweetalert.min.js"></script> 
        <link rel="stylesheet" type="text/css" href="css/sweetalert.css">
        <link rel="stylesheet" href="css/styles.css" />
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script src="js/jquery-1.9.1.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/login.js"></script>
    </head>
    <body class="contentpage">

        <!-- Navegacion del menu -->
        <div class="navbar navbar-default navbar-fixed-top affix inner-pages" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Menu Prinicpal</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <h1><a class="navbar-brand" href="#"><%out.print(empresa);%><img src="images/logo.png" alt="" width="50"/><br><br>
                            <h6><%out.print(logo);%></h6>
                        </a></h1>

                </div>	

                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="./index.jsp" title="Inicio"><span data-hover="Inicio">Inicio</span></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span data-hover="Nosotros">Nosotros</span> <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="./quienes.jsp" title="Quienes Somos"><span data-hover="Quienes Somos">Quienes Somos</span></a>
                                </li>
                                <li>
                                    <a href="./mision.jsp" title="Misión Visión"><span data-hover="Misión Visión">Misión Visión</span></a>
                                </li>
                                <li>
                                    <a href="./acerca.jsp" title="Acerca de"><span data-hover="Acerca de">Acerca de</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="./servicios.jsp" title="Servicios"><span data-hover="Servicios">Servicios</span></a>
                        </li>


                        <li>
                            <a href="./contactos.jsp" title="Contactenos"><span data-hover="Contactenos">Contactenos</span></a>
                        </li>

                        <%
                            String user = (String) session.getAttribute("varUsuario");
                            if (user != null) {%>

                        <li>
                            <a href = "./administracion/panela.jsp" title = "Ir al Sistema" >Ir al Sistema</a> 
                        </li>

                        <%  } else {
                        %>
                        <li>
                            <div id="loginContainer" class="navbar-collapse collapse">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="loginButton"><span data-hover="Accedder">Acceder</span> <b class="caret"></b></a>
                                <div id="loginBox">                
                                    <form id="loginForm" action="./procesos/logina.jsp" method="post">
                                        <fieldset id="body">
                                            <fieldset>
                                                <label for="email">Correo Electrónico</label>
                                                <input type="text"  id="email" name="usuario" />
                                            </fieldset>
                                            <fieldset>
                                                <label for="password">Contraseña</label>
                                                <input type="password"  id="password" name="clave"/>
                                            </fieldset>

                                            <input type="submit" id="login" value="Iniciar Sesión " />
                                        </fieldset>
                                        <span><a href="./registros/rnuevop.jsp">No Tienes Cuenta ! Registrate</a></span>
                                    </form>
                                </div>
                                <br><br><br><br><br><br><br>
                            </div>
                        </li>
                        <%  }
                        %>

                    </ul>
                </div>
            </div>
        </div>
        <!-- Fin del navegacion del menu -->

        <br><br><br>
        <!-- Contenido Inicio -->
        <div class="rehome">
            <div class="container">
                <div class="arow">
                    <div class="col-md-12 centered">
                        <h3 style="font-family: fantasy;color: green "><span>Informacion de los desarrolladores </span></h3>
                    </div>
                    <!--    <center>
                             <table BORDER spacing WIDTH="50%">
                                 <tr BORDER spacing WIDTH="50%">
                                     <td><img src="images/sani.jpg"/></td>  
                                     <td><img src="images/cris.jpg"/></td>
     
                                 </tr>
                                 <tr BORDER spacing WIDTH="50%">
     
     
                                     <td > <strong><span><p>Nombres: </p></span></strong><p>Wilson Santiago</p> 
                                         <strong><span><p>Apellidos </p></span></strong><p>Sanipatin Potosi</p> 
                                         <strong><span><p>Direccion: </p></span></strong><p>San Antonio</p> 
                                         <strong><span><p>Telefono: </p></span></strong><p>0936549144</p> 
                                         <strong><span><p>Correo: </p></span></strong><p>santi4862@gmail.com</p> 
                                         </td>  
                                     <td> <strong><span><p>Nombres: </p></span></strong><p>Cristian Javier</p> 
                                         <strong><span><p>Apellidos </p></span></strong><p>Cachipuendo Cacuango</p> 
                                         <strong><span><p>Direccion: </p></span></strong><p>Tabacuando</p> 
                                         <strong><span><p>Telefono: </p></span></strong><p>0959773991</p> 
                                         <strong><span><p>Correo: </p></span></strong><p>cuango64@gmail.com</p>
                                         </td>
     
                                 </tr>
                             </table>
                         </center>-->
                    <center>
                        <table>
                            <tr>
                                <td width=50%>
                                    <div id="alumno" >
                                        <div id="alumno" align="center">

                                            <img  src="images/sani.jpg"  width="250" height="250" style="border-radius: 50%;" >

                                        </div>
                                        <center>
                                            <strong><span><p>Nombres: Wilson Santiago </p></span></strong>
                                            <strong><span><p>Apellidos: Sanipatin Potosi </p></span></strong>
                                            <strong><span><p>Direccion: San Antonio </p></span></strong>
                                            <strong><span><p>Telefono: 0925411440</p></span></strong> 
                                            <strong><span><p>Correo: santi4862@gmail.com</p></span></strong>
                                        </center>
                                    </div>
                                </td>

                                <td width=50%>
                                    <div id="alumno">
                                        <div id="alumno" align=center>

                                            <img src="images/cris.jpg"  width="250" height="250" align=center style="border-radius: 50%;">

                                        </div>
                                        <center>
                                            <strong><span><p>Nombres: Cristian Javier </p></span></strong>
                                            <strong><span><p>Apellidos: Cachipuendo Cacuango </p></span></strong>
                                            <strong><span><p>Direccion: Tabacuando </p></span></strong>
                                            <strong><span><p>Telefono: 0959773991</p></span></strong> 
                                            <strong><span><p>Correo: cuango64@gmail.com</p></span></strong>
                                        </center>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </center>
                </div>
                <div class="arow">
                    <div class="col-md-12 centered">
                        <h3 style="font-family: fantasy;color: green "><span>Conosca Nuestras Instalaciones </span></h3>
                        <br>
                        <div id="c-carousel">
                            <div id="wrapper">
                                <div id="carousel">
                                    <div>
                                        <a href="./images/g1.jpg" title="<%out.print(empresa);%>" data-hover="Consultorio" data-toggle="lightbox" class="lightbox">
                                            <img src="./images/g1.jpg" alt="<%out.print(empresa);%>" />
                                        </a>
                                    </div>
                                    <div>
                                        <a href="./images/g2.jpg" title="<%out.print(empresa);%>" data-hover="Equipos Medicos" data-toggle="lightbox" class="lightbox">
                                            <img src="./images/g2.jpg" alt="<%out.print(empresa);%>" />
                                        </a>
                                    </div>
                                    <div>
                                        <a href="./images/g3.jpg" title="<%out.print(empresa);%>" data-hover="Nuestros Doctores" data-toggle="lightbox" class="lightbox">
                                            <img src="./images/g3.jpg" alt="<%out.print(empresa);%>" />
                                        </a>
                                    </div>
                                    <div>
                                        <a href="./images/g4.jpg" title="<%out.print(empresa);%>" data-hover="Nuestros Clientes" data-toggle="lightbox" class="lightbox">
                                            <img src="./images/g4.jpg" alt="<%out.print(empresa);%>" />
                                        </a>
                                    </div>
                                    <div>
                                        <a href="./images/g5.jpg" title="<%out.print(empresa);%>" data-hover="La Empresa" data-toggle="lightbox" class="lightbox">
                                            <img src="./images/g5.jpg" alt="<%out.print(empresa);%>" />
                                        </a>
                                    </div>
                                </div>
                                <div id="pager" class="pager"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Pie de pagina inicio -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <h6>Acerca de Nosotros</h6>
                        <p>Estamos comprometidos con la excelencia en todas las facetas de este arte y ciencia. Estamosn orgullosos de la calidad de nuestro trabajo, utilizando los mejores materiales disponibles. Trabajamos con técnicos protésicos y artistas dentales altamente preparados, que siguen nuestro compromiso por la excelencia.</p>
                    </div>
                    <div class="col-md-3">
                        <h6>Objetivo Asistencial</h6>
                        <p>Somos un centro de referencia para nuestros pacientes actuales y futuros, fundamentalmente por nuestra seriedad y rigor profesional. Nuestro objetivo es acercarnos con tratamientos odontológicos de calidad a la sociedad. </p>
                    </div>

                    <div class="col-md-3 contact-info">
                        <h6>Información  de la Institucion</h6>
                        <p>Toda la informacion se entrega para contactos a la institución por parte de la Dra. Gulnara Obando V.</p>
                        <p class="social">
                            <a href="https://www.facebook.com" class="facebook"></a> <a href="https://es.pinterest.com" class="pinterest"></a> <a href="https://www.twitter.com" class="twitter"></a>
                        </p>
                        <p class="c-details">
                            <span>Email: </span><%out.print(correoi);%><br >
                            <span>Teléf: </span> <%out.print(telefonoi);%></p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 copyright">
                        <p>&copy;  Copyright <%out.print(a);%> <%out.print(empresa);%> Todos lo derechos Reservados. <a href="index.jsp">Diseñado: Grupo <%out.print(empresa);%></a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- termina pie de pagina -->

        <!-- Javascript plugins -->
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/carouFredSel.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/ekkoLightbox.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>