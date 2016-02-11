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
        <script src="../js/sweetalert.min.js"></script> 
        <link rel="stylesheet" type="text/css" href="../css/sweetalert.css">
        <script>
            function fecha() {
                var lista = document.getElementById("day");
                var lista1 = document.getElementById("year");
                var today = new Date();
                var año = today.getFullYear();
                for (i = 1; i < 32; i++) {
                    lista.options.add(new Option(i, i));
                }
                for (i = 0; i < 150; i++) {
                    lista1.options.add(new Option(año, año));
                    año--;
                }

            }
        </script>
    </head>
    <body class="contentpage" onload="fecha();">
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
                                    <a href="../acesso.html" title="Acesso al sistema">Acesso al sistema</a>
                                </li>
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
                    <h3><span>Nuevo Registro De Paciente</span></h3>
                    <p>Por favor entrege toda la información correcta para que pueda ser validada en el sistema caso contrario noo podra acceder a un cuenta.</p>
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
                    <%
                        String id = request.getParameter("id");
                        conexion con = new conexion();
                        ResultSet rs = con.consulta("select * from personas where dni='" + id + "'");
                        while (rs.next()) {
                            out.print("<form  id='registro' name='registro' action='../procesos/moregistrop.jsp?id="+rs.getString("dni")+"' method='POST'>");
                             out.print(" <div class='form-group'>");
                            out.print("    <input type='text' disabled  class='form-control' id='dni' name='dni' placeholder='Ingrese su DNI' value='" + rs.getString("dni") + "'>");
                            out.print("   </div>");
                            out.print(" <div class='form-group'>");
                            out.print("    <input type='text' required class='form-control' id='nombres' name='nombres' placeholder='Ingrese sus nombres' value='" + rs.getString("nombres") + "'>");
                            out.print("   </div>");
                            out.print("   <div class='form-group'>");
                            out.print("      <input type='text' required class='form-control' id='apellidos' name='apellidos' placeholder='Ingrese sus apellidos' value='" + rs.getString("apellidos") + "'>");
                            out.print("   </div>");
                            out.print("  <div class='form-group'>");
                            out.print("      <input type='email' class='form-control' id='correo' name='correo' placeholder='Ingrese su correo electronico' onchange='validare(registro);' value='" + rs.getString("correo") + "'>");
                            out.print("   </div>");
                            out.print("   <div class='form-group'>");
                            out.print("      <input name='telefono' type='text' class='form-control' id='telefono' placeholder='Ingrese su  numero de telefono' onkeydown='return numeros(event)' maxlength='15' value='" + rs.getString("telefono") + "'>");
                            out.print(" </div>");
                            out.print("  <div class='form-group'>");
                            out.print("<input name='celular' type='text' class='form-control' id='celular' placeholder='Ingrese su numero de celular' onkeydown='return numeros(event)' maxlength='15' value='" + rs.getString("celular") + "'>");
                            out.print("</div>");
                            out.print("  <div class='form-group'>");
                            out.print(" <input type='text' required class='form-control' id='direccion' name='direccion' placeholder='Ingrese su direccion donde vive actualmente' value='" + rs.getString("direccion") + "'>");
                            out.print("</div>");
                            out.print("<div class='form-group'>");
                            out.print("   <select name='sexo' required class='form-control' id='sexo'>");
                            if (rs.getString("sexo").equals("t")) {
                                out.print("     <option value='true'>Masculino</option>");

                            } else {
                                out.print("     <option value='false'>Femenino</option>");

                            }
                            out.print("    <option value='true'>Masculino</option>");
                            out.print("    <option value='false'>Femenino</option>");
                            out.print(" </select>");
                            out.print(" </div>");
                            String leer = "", ano = "", mes = "", dia = "", mes1 = "";
                            for (int i = 0; i < rs.getString("fnacimiento").length(); i++) {
                                leer = leer + rs.getString("fnacimiento").substring(i, i + 1);
                                if (i == 3) {
                                    i++;
                                    ano = leer;
                                    leer = "";

                                }
                                if (i == 6) {
                                    i++;
                                    mes = leer;
                                    if (mes.equals("01")) {
                                        mes1 = "Enero";
                                    }
                                    if (mes.equals("02")) {
                                        mes1 = "Febrero";
                                    }
                                    if (mes.equals("03")) {
                                        mes1 = "Marzo";
                                    }
                                    if (mes.equals("04")) {
                                        mes1 = "Abril";
                                    }
                                    if (mes.equals("05")) {
                                        mes1 = "Mayo";
                                    }
                                    if (mes.equals("06")) {
                                        mes1 = "Junio";
                                    }
                                    if (mes.equals("07")) {
                                        mes1 = "Julio";
                                    }
                                    if (mes.equals("08")) {
                                        mes1 = "Agosto";
                                    }
                                    if (mes.equals("09")) {
                                        mes1 = "Septiembre";
                                    }
                                    if (mes.equals("10")) {
                                        mes1 = "Octubre";
                                    }
                                    if (mes.equals("11")) {
                                        mes1 = "Noviembre";
                                    }
                                    if (mes.equals("12")) {
                                        mes1 = "Diciembre";
                                    }
                                    leer = "";

                                }
                                if (i == 9) {
                                    i++;
                                    dia = leer;
                                    leer = "";

                                }
                            }
                            out.print("  <div class='form-group'>");
                            out.print(" <select name='year' required class='form-control' id='year'>");
                            out.print("     <option value='" + ano + "'>" + ano + "</option>");
                            out.print(" </select>");
                            out.print("  </div>");
                            out.print(" <div class='form-group'>");
                            out.print("   <select name='month' required class='form-control' id='month'>");
                            out.print("    <option value='" + mes + "'>" + mes1 + "</option>");
                            out.print("    <option value='1'>Enero</option>");
                            out.print("    <option value='2'>Febrero</option>");
                            out.print("    <option value='3'>Marzo</option>");
                            out.print("   <option value='4'>Abril</option>");
                            out.print("  <option value='5'>Mayo</option>");
                            out.print("  <option value='6'>Junio</option>");
                            out.print(" <option value='7'>Julio</option>");
                            out.print("   <option value='8'>Agosto</option>");
                            out.print("  <option value='9'>Septiembre</option>");
                            out.print("   <option value='10'>Octubre</option>");
                            out.print("   <option value='11'>Noviembre</option>");
                            out.print("    <option value='12'>Diciembre</option>");
                            out.print("  </select>");
                            out.print(" </div>");
                            out.print(" <div class='form-group'>");
                            out.print("   <select name='day' required class='form-control' id='day'>");
                            out.print("   <option value='" + dia + "'>" + dia + "</option>");
                            out.print("   </select>");
                            out.print(" </div>");
                            out.print("  <button type='submit' class='btn btn-default btn-green'>Actualizar Registro</button>");
                            out.print(" </form>");
                        }
                    %>
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