<%@page import="java.util.Date"%>
<%@page import="clases.MailSender"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    conexion con = new conexion();
    ResultSet rs = null;
    String nom = "", apel = "", foto = "", id = "", pri = "", idno = "";//variables de usuario
    String empresa = "";//variable de empresa
    String dni = "", fecha = "", hora = "", idp = "", idm = "";

    String user = (String) session.getAttribute("varUsuario");//variable que contiene la sesion activa
    String url = request.getRequestURI();//varible que extrae url de pagina
    int acceso = 0;//varible de acceso a pagina
    if (user == null) {
        response.sendRedirect("../administracion/logina.jsp");
    } else {
        dni = request.getParameter("idc");
        idm = request.getParameter("idd");
        idp = request.getParameter("idp");
        fecha = request.getParameter("fecha");
        hora = request.getParameter("hora");
        //DATOS DEL USUARIO
        rs = con.consulta("select * from personas where correo='" + user + "'");
        while (rs.next()) {
            pri = rs.getString("tpersona");
            idno = rs.getString("dni");
            nom = rs.getString("nombres");
            apel = rs.getString("apellidos");
            foto = rs.getString("fotpersona");
        }
        //DATOS PARA CONTROLAR EN ACCESO A LA PAGINA
        rs = con.consulta("select count(*) from menup m,privilegios p where p.idmenu=m.idmenu and m.estado='true' and p.idperfil='" + pri + "' and p.estado='true' and m.referencia='" + url + "'");
        while (rs.next()) {
            acceso = rs.getInt("count");
        }
        if (acceso == 0) {
            out.print("<script>alert('No Tienes Privilegios para Acceder');</script>");
            out.println("<script language='javascript'>window.location='../administracion/panela.jsp'</script>;");
        }
        //DATOS DE LA EMPRESA
        rs = con.consulta("select * from empresa");
        while (rs.next()) {
            empresa = rs.getString("nombre");
        }
    }
%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><%out.print(empresa);%></title>
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="../assets/css/zabuto_calendar.css">
        <link rel="stylesheet" type="text/css" href="../assets/js/gritter/css/jquery.gritter.css" />
        <link rel="stylesheet" type="text/css" href="../assets/lineicons/style.css">   
        <link href="../assets/css/style.css" rel="stylesheet">
        <link href="../assets/css/style-responsive.css" rel="stylesheet">
        <script src="../assets/js/chart-master/Chart.js"></script>
        <script type="text/javascript" src="../js/validar.js"></script>
        <script src="../js/sweetalert.min.js"></script> 
        <link rel="stylesheet" type="text/css" href="../css/sweetalert.css">
    </head>

    <body>

        <section id="container" >
            <!--cabecera inicio-->
            <header class="header black-bg">
                <div class="sidebar-toggle-box">
                    <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Menú de deslizamiento"></div>
                </div>
                <a href="#" class="logo"><b><%out.print(empresa);%></b></a>
                <div class="nav notify-row" id="top_menu">
                    <!--  inicio de notificaciones -->
                    <ul class="nav top-menu">

                        <!-- inicio de atras -->
                        <li   id="header_inbox_bar" class="dropdown">
                            <a class="dropdown-toggle" href="javascript:history.go(-1)">
                                <i title="Atras" class="fa fa-arrow-left"></i>
                            </a>
                        </li>
                        <!-- fin de atras -->
                        <!-- inicio de adelante -->
                        <li id="header_inbox_bar" class="dropdown">
                            <a  class="dropdown-toggle" href="javascript:history.go(1)">
                                <i title="Siguiente" class="fa fa-arrow-right"></i>
                            </a>
                        </li>
                        <!-- fin de adelante -->
                        <!-- inicio notificaciones -->
                        <li class="dropdown">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <i  title="Notificaciones" class="fa fa-tasks"></i>
                                <%rs = con.consulta("select count(*) from notas where estnota='true' and estvisto='false' and idpersona='" + idno + "'");
                                    while (rs.next()) {
                                %>
                                <span class="badge bg-theme"><%out.print(rs.getString("count"));%></span>
                            </a>
                            <ul class="dropdown-menu extended tasks-bar">
                                <div class="notify-arrow notify-arrow-green"></div>
                                <li>

                                    <p class="green">Tiene <%out.print(rs.getString("count"));%> Notificaciones</p>
                                    <%}%>
                                </li>
                                <li>
                                    <%rs = con.consulta("select * from notas where estnota='true' and estvisto='false' and idpersona='" + idno + "' order by idnota desc limit 5");
                                        while (rs.next()) {
                                    %>
                                    <a href="../notificacion/nota.jsp?id=<%out.print(rs.getString("idnota"));%>">
                                        <div class='task-info'>
                                            <div class="desc">Notidicacion <%out.print(rs.getString("idnota"));%></div>
                                            <h7 class="green"><%out.print(rs.getString("asunto"));%></h7>

                                        </div>
                                    </a>
                                    <%}%>  
                                </li>
                                <li class="external">
                                    <a href="../notificacion/notificaciones.jsp">Mostrar las Demas</a>
                                </li>
                            </ul>
                        </li>
                        <!-- Fin de notificaciones -->
                        <!-- inicio de mensajes-->
                        <li id="header_inbox_bar" class="dropdown">
                            <a  data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                                <i title="Noticias" class="fa fa-envelope-o"></i>
                                <%
                                    Date actual = new Date();
                                    rs = con.consulta("select count(*) from noticias where estado='true' and fecha='" + actual + "'");
                                    while (rs.next()) {
                                %>
                                <span class="badge bg-theme"><%out.print(rs.getString("count"));%></span>
                            </a>
                            <ul class="dropdown-menu extended inbox">
                                <div class="notify-arrow notify-arrow-green"></div>
                                <li>
                                    <p class="green">Tiene <%out.print(rs.getString("count"));%> Noticias</p>
                                </li>
                                <%}%>
                                <li>
                                    <%
                                        rs = con.consulta("select * from noticias where estado='true' and fecha='" + actual + "' limit 5");
                                        while (rs.next()) {
                                    %>
                                    <a href="../notificacion/noticia.jsp?id=<%out.print(rs.getString("id_noticia"));%>">
                                        <span class="photo"><img  src="..<%out.print(rs.getString("imagen"));%>"></span>
                                        <span class="subject">
                                            <span class="from"><%out.print(rs.getString("titulo").substring(0, 28));%></span>

                                        </span>
                                        <span class="message">
                                            <%out.print(rs.getString("encabezado").substring(0, 33));%>
                                        </span>
                                        <span class="time">Leer Noticia</span>
                                    </a>
                                    <%}%>
                                </li>
                                <li>
                                    <a href="../notificacion/noticias.jsp">Mostrar las Demas</a>
                                </li>
                            </ul>
                        </li>
                        <!-- fin de mensajes -->
                        <!-- inicio de ayuda -->
                        <li id="header_inbox_bar" class="dropdown">
                            <a class="dropdown-toggle" href="../reportes/ayuda.jsp?id=/pdf/manual_admin.pdf">
                                <i title="Ayuda" class="fa fa-question"></i>
                            </a>
                        </li>
                        <!-- fin de ayuda -->
                    </ul>
                </div>
                <div class="top-menu">
                    <ul class="nav pull-right top-menu">
                        <li><a class="logout" href="../procesos/cerrar.jsp">Salir del Sistema</a></li>
                    </ul>
                </div>
            </header>
            <!--fin de cabecera-->


            <!--Informacion del usuario y menu-->
            <aside>
                <div id="sidebar"  class="nav-collapse ">
                    <ul class="sidebar-menu" id="nav-accordion">

                        <p class="centered"><a href="../administracion/foto.jsp"><img src="..<% out.print(foto); %>" class="img-circle" width="60"></a></p>
                        <h5 class="centered">Usuario: <% out.print(nom + " " + apel);%></h5>
                        <h5 class="centered"><%
                            ResultSet tipo = con.consulta("select * from perfiles where idperfil='" + pri + "'");
                            while (tipo.next()) {
                                out.print(tipo.getString("nomperfil"));
                            }%></h5>
                        <li class="mt">
                            <a  href="panela.jsp">
                                <i class="fa fa-home"></i>
                                <span>Inicio</span>
                            </a>
                        </li>
                        <li class="sub-menu">
                            <a  href="../index.jsp">
                                <i class="fa fa-inbox"></i>
                                <span>Página Principal</span>
                            </a>
                        </li>
                        <%
                            ResultSet me = con.consulta("select * from menup m,privilegios p where p.idmenu=m.idmenu and m.estado='true' and m.relacion='0' and m.visible='true' and p.idperfil='" + pri + "' and p.estado='true'");
                            while (me.next()) {
                                out.print(" <li class='sub-menu'>");
                                out.print("<a href='" + me.getString("referencia") + "' >");
                                out.print("<i class='" + me.getString("clase") + "'></i>");
                                out.print("<span>" + me.getString("nombre") + "</span>");
                                out.print(" </a>");
                                ResultSet mes = con.consulta("select * from menup m,privilegios p where p.idmenu=m.idmenu and m.estado='true' and m.relacion='" + me.getString("idmenu") + "' and m.visible='true' and p.idperfil='" + pri + "' and p.estado='true'");
                                while (mes.next()) {
                                    out.print(" <ul class='sub'>");
                                    out.print(" <li><a  href='" + mes.getString("referencia") + "'>" + mes.getString("nombre") + "</a></li>");
                                    out.print(" </ul>");
                                }
                                out.print("</li>");
                            }
                        %>
                    </ul>
                </div>
            </aside>
            <!--fin de usuario y menu-->

            <!--inicio de contenido-->
            <section id="main-content">
                <section class="wrapper">
                    <div class="row mt">

                        <div class="col-lg-12">
                            <div class="form-panel">
                                <form  id="listarei" name="listarei" action="" method="POST">

                                    <div class="form-group">
                                        <h5><span class='help-block'> Número de Identificación del Especialista </span></h5>
                                        <input type="text" value="<%out.print(idm);%>" required class="form-control" id="especialista"  readonly=”readonly”name="especialista" placeholder="Especialista">
                                    </div>
                                    <% ResultSet v = con.consulta("select * from personas where dni='" + idm + "'");
                                        while (v.next()) {
                                    %>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Nombres del Especialista </span></h5>
                                        <input type="text" value="<%out.print(v.getString("nombres")); %>" required class="form-control" readonly=”readonly” id="nespecialista" name="nespecialista" placeholder="Especialista">
                                    </div>
                                    <%}%>
                                    <%  v = con.consulta("select * from especialidad e, doctores d where d.espdoctor=e.codesp and iddoctor='" + idp + "'");
                                        String servicios = "";
                                        while (v.next()) {
                                            servicios = v.getString("codesp");
                                    %>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Especialidad del Servicio </span></h5>
                                        <input type="text" value="<%out.print(v.getString("nomesp")); %>" required class="form-control" readonly=”readonly” name="especial" placeholder="Paciente">
                                    </div>
                                    <%}%>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Número de Identificación del Paciente </span></h5>
                                        <input type="text" value="<%out.print(dni);%>" required class="form-control" id="paciente" readonly=”readonly” name="paciente" placeholder="Paciente">
                                    </div>
                                    <%  v = con.consulta("select * from personas where dni='" + dni + "'");
                                        while (v.next()) {
                                    %>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Nombres del Paciente </span></h5>
                                        <input type="text" value="<%out.print(v.getString("nombres")); %>" required class="form-control" readonly=”readonly” name="npaciente" placeholder="Paciente">
                                    </div>
                                    <%}%>

                                    <div class="form-group">
                                        <h5><span class='help-block'> Fecha elegida de la Reserva </span></h5>
                                        <input type="text" value="<%out.print(fecha);%>" required class="form-control" id="fecha" readonly=”readonly” name="fecha" placeholder="Fecha">
                                    </div>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Hora Elegida de la Reserva </span></h5>
                                        <input type="text" value="<%out.print(hora);%>" required class="form-control" id="hora" readonly=”readonly” name="hora" placeholder="Hora">
                                    </div>
                                    <div class="form-group">
                                        <center><h5><span class='help-block'> Tipo de Servicio a Elegir </span></h5></center>
                                    </div>
                                    <div class="form-group">
                                        <select name="servicio" required class="form-control" id="servicio">
                                            <option value="">Seleccione el servicio que requiere</option>
                                            <%
                                                rs = con.consulta("select *,round((valservicio)::decimal,2)as precio from servicios where estservicio='true' and especialidad='" + servicios + "'");
                                                while (rs.next()) {
                                                    out.print("<option value='" + rs.getString("idservicio") + "'>" + "Servicio " + rs.getString("nomservicio") + " Tiene un costo de: " + rs.getString("precio") + "</option>");
                                                }
                                            %>

                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <input type="text"  required class="form-control" id="asunto" name="asunto" placeholder="Asunto">
                                    </div>    
                                    <button type="submit" class="btn btn-default btn-green" id="enviar" name="enviar">Guardar Registro</button>
                                </form>
                                <%
                                    if (request.getParameter("enviar") != null) {
                                        String asunto = request.getParameter("asunto");
                                        String especial = request.getParameter("servicio");
                                        rs = con.consulta("select count(*) from citas where hora='" + hora + "' and fecha='" + fecha + "' and (estcita='Pendiente' or estcita='Aplicada' or estcita='No asistio')");
                                        String contador = "";
                                        while (rs.next()) {
                                            contador = rs.getString("count");
                                        }
                                        if (contador.equals("0")) {
                                            con.consulta("INSERT INTO citas( asunto, fecha, hora, medico, paciente,estcita,estpago,especialidad,servicio) VALUES ('" + asunto + "', '" + fecha + "','" + hora + "', '" + idm + "', '" + dni + "', 'Pendiente','Pendiente', '" + servicios + "', '" + especial + "');");
                                            out.print("<script>");
                                            out.print("swal({title: 'Información del Sistema', text: 'Información Guardada Correctamente', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                                            out.print("if (isConfirm) {");
                                            out.print("window.location = '../reportes/proforma.jsp?hora=" + hora + "&&fecha=" + fecha + "&&idd=" + dni + "';");
                                            out.print("}");
                                            out.print("});");
                                            out.print("</script>");
                                        } else {
                                            out.print("sweetAlert('Información del Sistema', 'Hora y Fecha ya reservadas', 'warning'');");
                                        }

                                    }
                                %>
                            </div>
                        </div>
                    </div>  
                </section>
            </section>

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
