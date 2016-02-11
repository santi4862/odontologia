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
    <body class="homepage">

        <!-- Navegacion del menu -->
        <div class="navbar navbar-default navbar-fixed-top" role="navigation">
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
                                        <span><a style="color: green" href="./registros/rnuevop.jsp">No Tienes Cuenta ! Registrate</a></span>
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

        <!-- Inicio de galeria -->
        <div id="home_carousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#home_carousel" data-slide-to="0" class="active">
                </li>
                <li data-target="#home_carousel" data-slide-to="1"></li>
                <li data-target="#home_carousel" data-slide-to="2"></li>
            </ol>

            <!-- Inicio de Imagenes -->
            <div class="carousel-inner">
                <div class="item active">
                    <img src="images/3.jpg" alt="" />
                    <div class="carousel-caption">
                        <h2>Tecnología de Blanqueamiento</h2>
                        <p>Estas se  realizan aplicando substancias oxidantes que se pueden activar mediante luz o calor, originando el efecto blanqueador, gracias a la reacción química de oxidación que se produce durante el blanqueamiento de los dientes.</p>
                    </div>
                </div>
                <div class="item">
                    <img src="images/1.jpg" alt="" />
                    <div class="carousel-caption">

                        <h2>Infraestructura de una Clínica Dental </h2>
                        <p>Ambientes amplios, cómodos y modernos,  amplias salas de espera, 
                            SSHH independientes para pacientes tanto para hombres como para mujeres </p>
                    </div>
                </div>
                <div class="item">
                    <img src="images/2.jpg" alt="" />
                    <div class="carousel-caption">
                        <h2>Tu Clínica Dental</h2>
                        <p>Tres Modernas Unidades Dentales, 
                            Equipo Radiográfico Dental, 
                            Ultrasonido para Profilaxis, 
                            Estelirización por agentes químicos.
                            Equipo de ultima generación para implantología</p>
                        <h2></h2>
                    </div>
                </div>
            </div>

            <!-- Controles -->
            <a class="left carousel-control" href="#home_carousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#home_carousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
        <!-- galeria final -->

        <!-- Contenido Inicio -->
        <div class="rehome">
            <div class="container">
                <div class="arow">
                    <div class="col-md-12 centered">
                        <h3 style="font-family: fantasy; color: green "><span>BIENVENIDOS </span></h3>
                    </div>
                    <p style="font-size:15px; text-align:justify;">Queremos darle la bienvenida a nuestra web e invitarle a conocer la Clinica y descubrir los servicios odontológicos integrales que brindamos, cuidando al máximo su salud con profesionalismo, calidad, garantía y brindando las mejores facilidades de pago.
                        No defraudamos a nuestros pacientes, les escuchamos, entendemos y realizamos el tratamiento más adecuado para cada uno, nuestro trabajo no acaba hasta que el paciente esté satisfecho, logrando excelentes resultados.
                        Sonrisas y Detalles su Clinica Dental de Confianza.</p>
                </div>
                <div class="arow">
                    <div class="col-md-12 centered">
                        <h3 style="font-family: fantasy; color: green "><span>Noticias de la <%out.print(empresa);%> </span></h3>
                        <div id="c-carousel">
                            <div id="wrapper">
                                <div id="carousel">
                                    <%
                                        rs = con.consulta("select * from noticias where estado=true order by fecha desc");
                                        while (rs.next()) {

                                            out.print("<div>");
                                            out.print("<a href='noticia.jsp?id=" + rs.getString("id_noticia") + "' title='" + rs.getString("titulo") + "' data-hover='" + rs.getString("encabezado") + "'>");
                                            out.print("<img src='." + rs.getString("imagen") + "' alt='" + rs.getString("titulo") + "'/>");
                                            out.print("</a>");
                                            out.print("</div>");
                                        }%>
                                    <div>
                                        <a href="#" title="Noticias" data-hover="Ultimas Noticias">
                                            <img src="./imgn/logoni.jpg" alt="Noticias" />
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
    </div>
    <!-- Fin de contenido -->
    <!-- inicio de noticias -->



    <div class="row">      
    </div>
    <!-- fin de noticias-->

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
                    <p>&copy;  Copyright <%out.print(a);%> <%out.print(empresa);%> Todos lo derechos Reservados. <a href="#">Diseñado: Grupo <%out.print(empresa);%></a></p>
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