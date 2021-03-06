<%@page import="clases.MailSender"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Calendar fecha = Calendar.getInstance();
    int a = fecha.get(Calendar.YEAR);
    conexion con = new conexion();
    ResultSet rs = con.consulta("select * from empresa");
    String empresa = "", logo = "", telefonoi = "", correoi = "", celulari = "", direccion = "", horario = "";
    while (rs.next()) {
        empresa = rs.getString("nombre");
        logo = rs.getString("logo");
        telefonoi = rs.getString("telefonoi");
        correoi = rs.getString("correoi");
        celulari = rs.getString("celulari");
        direccion = rs.getString("direccion");
        horario = rs.getString("horarioa");

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

        <br>
        <br>
        <br>
        <br>
        <!-- Informacion -->
        <div class="container">
            <div class="row">
                <div class="col-md-12 centered">
                    <h3 style="font-family: fantasy;color: green "><span><strong>Contáctenos hoy mismo a <%out.print(empresa);%><strong></span></h3>
                                    <p style="text-align:justify;">Para enviar sus comentarios y/o sugerencias complete y envíe el formulario que se encuentra a continuación. Asegúrese de proporcionar una dirección de e-mail válida para recibir una respuesta de nuestra parte. Atención: La información de los campos marcados con * es obligatoria.</p>
                                    </div>
                                    </div>
                                    </div>
                                    <!-- fin de informacion -->
                                    <br>
                                    <br>
                                    <!-- Inicio de Contacto -->
                                    <div class="container content">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <form role="form" id="contact_form" name="contacto" action="contactos.jsp" method="post">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" id="InputName" placeholder="Ingrese sus Nombre" name="nombre" required="">
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="email" class="form-control" id="InputEmail" placeholder="Ingrese su Correo" name="correo" required="">
                                                    </div>
                                                    <div class="form-group">
                                                        <textarea class="form-control" id="Message" placeholder="Ingrese su Mensaje" rows="8" name="mensaje" required=""></textarea>
                                                    </div>
                                                    <button type="submit" class="btn btn-default btn-green" name="enviar">Enviar Mensaje</button>
                                                </form>
                                                <%
                                                    if (request.getParameter("enviar") != null) {
                                                        String nombre = request.getParameter("nombre");
                                                        String correomsm = request.getParameter("correo");
                                                        String mensaje = request.getParameter("mensaje");
                                                        MailSender sms = new MailSender();
                                                        sms.asunto("Contacto de Informacion de: " + nombre);
                                                        sms.para(correoi);
                                                        sms.mensaje("Usuario: " + nombre + " \n Mensaje: " + mensaje + " \n Correo de Usuario: " + correomsm);
                                                        sms.SendMail();
                                                    }
                                                %>
                                            </div>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-md-12 centered">
                                                        <h3 style="font-family: fantasy; color: green"><span><strong>Contactos de la <%out.print(empresa);%><strong></span></h3>
                                                                        </div>
                                                                        </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <ul class="contact-info">
                                                                                <br>
                                                                                <br>

                                                                                <li class="telephone">
                                                                                    <%out.print(telefonoi);%>
                                                                                </li>

                                                                                <li class="address">
                                                                                    <%out.print(direccion);%>
                                                                                </li>
                                                                                <li class="mail">
                                                                                    <%out.print(correoi);%>
                                                                                </li>
                                                                                <li class="celular">
                                                                                    <%out.print(celulari);%>
                                                                                </li>
                                                                                <li class="horario">
                                                                                    <%out.print(horario);%>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                        </div>
                                                                        </div>
                                                                        <!-- fin de Formulario de contacto -->
                                                                        <div class="container">
                                                                            <div class="row">
                                                                                <div class="col-md-12 centered">
                                                                                    <h3 style="font-family: fantasy; color: green"><span><strong>Ubicacion de la <%out.print(empresa);%><strong></span></h3>
                                                                                                    </div>
                                                                                                    </div>
                                                                                                    </div>
                                                                                                    <!-- Contenido Inicio -->
                                                                                                    <div class="rehome">
                                                                                                        <div class="container">
                                                                                                            <div class="row">
                                                                                                                <div class="col-md-12 centered">

                                                                                                                    <p><iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d3989.749034057745!2d-78.16639388781438!3d0.33766444861991357!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses!2ses!4v1450731741988" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe></p>

                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <!-- Fin de contenido -->



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