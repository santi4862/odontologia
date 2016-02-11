<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    conexion con = new conexion();
    ResultSet rs = null;
    String nom = "", apel = "", foto = "", id = "", pri = "", idno = "";//variables de usuario
    String empresa = "";//variable de empresa
    String user = (String) session.getAttribute("varUsuario");//variable que contiene la sesion activa
    String url = request.getRequestURI();//varible que extrae url de pagina
    int acceso = 0;//varible de acceso a pagina
    if (user == null) {
        response.sendRedirect("../administracion/logina.jsp");
    } else {
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
                    <center><h4><i class="fa fa-plus"></i>Crear un Nuevo Registro</h4></center>
                    <div class="row mt">

                        <div class="col-lg-12">
                            <div class="form-panel">
                                <form  id="listarei" name="listarei" action="listare.jsp" method="POST">
                                    <div class="form-group">
                                        <input name="codigoe" type="text" required class="form-control" id="codigoe" placeholder="Ingrese codigo unico de Especialidad" title="Ingrese codigo unico de Especialidad" maxlength="3">
                                    </div>
                                    <div class="form-group">
                                        <input type="text" required class="form-control" id="nombree" name="nombree" placeholder="Ingrese la Especialidad" title="Ingrese la Especialidad">
                                    </div>

                                    <button type="submit" class="btn btn-default btn-green" id="enviar" name="enviar">Registrar Especialidad</button>
                                </form>
                                <%
                                    if (request.getParameter("enviar") != null) {
                                        String codigo = request.getParameter("codigoe");
                                        String nombre = request.getParameter("nombree");
                                        rs = con.consulta("select count(*) from especialidad where codesp='" + codigo + "' or nomesp='" + nombre + "'");
                                        String contador = "";
                                        while (rs.next()) {
                                            contador = rs.getString("count");
                                        }
                                        if (contador.equals("0")) {
                                            con.consulta("INSERT INTO especialidad(nomesp, codesp)VALUES ('" + nombre + "', '" + codigo + "');");
                                        } else {
                                            out.print("<script>");
                                            out.print("swal({title: 'Información del Sistema', text: 'Este Codigo esta Duplicado', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                                            out.print("if (isConfirm) {");
                                            out.print("window.location = 'listare.jsp';");
                                            out.print("}");
                                            out.print("});");
                                            out.print("</script>");
                                        }

                                    }
                                %>
                                <br>
                                <center><h3><i class="fa fa-list-alt"></i>Lista de registros</h3></center>
                                <br>
                                <form  id="listares" name="listares" action="listare.jsp" method="POST">
                                    <div class="form-group">
                                        <select autofocus required class="form-control" name="tbuscar" id="tbuscar">
                                            <option value="">Seleccione el tipo de busqueda que requiere</option>
                                            <option value="0">Código</option>
                                            <option value="1">Nombre</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" required class="form-control" id="busqueda" name="busqueda" placeholder="Ingrese lo que desea buscar" title="Ingrese lo que desea buscar">
                                    </div>

                                    <button type="submit" class="btn btn-default btn-green" id="buscar" name="buscar">Buscar Registro</button>
                                </form>
                                <br>
                                <div class="form-group">

                                    <%String consulta = "select * from especialidad limit 100";

                                        if (request.getParameter("buscar") != null) {
                                            String valor = request.getParameter("tbuscar");
                                            String buscar = request.getParameter("buscar");
                                            if (valor.equals("0")) {
                                                consulta = "select * from especialidad where codesp like'%" + buscar + "%'";
                                            } else if (valor.equals("1")) {
                                                consulta = "select * from especialidad where nomesp like'%" + buscar + "%'";
                                            }

                                        }
                                        rs = con.consulta(consulta);
                                        out.print("<table class='table table-striped table-advance table-hover'>");
                                        out.print("   <center> <h4><i class='fa fa-list'></i> Listado de registros </h4></center>");
                                        out.print("  <hr>");
                                        out.print(" <thead>");
                                        out.print("  <tr>");
                                        out.print("    <th class='hidden-phone'><i class='fa fa-barcode'></i> Codigo</th>");
                                        out.print("    <th><i class='fa fa-list-alt'></i> Nombre</th>");
                                        out.print(" <th><i class='fa fa-check-square-o'></i> Estado</th>");
                                        out.print("    <th><i class='fa fa-cog'></i>Acciones</th>");
                                        out.print("</tr>");
                                        out.print(" </thead>");
                                        out.print("  <tbody>");
                                        while (rs.next()) {
                                            out.print("   <tr>");
                                            out.print("  <td class='hidden-phone'>" + rs.getString("codesp") + "</td>");
                                            out.print("    <td >" + rs.getString("nomesp") + "</td>");
                                            if (rs.getString("estesp").equals("t")) {
                                                out.print("   <td><span class='label label-info label-mini'>Activo</span></td>");

                                            } else {
                                                out.print("   <td><span class='label label-info label-mini'>Desactivado</span></td>");

                                            }
                                            out.print("    <td>");
                                            out.print("  <a href = '../administracion/mespecialidad.jsp?id=" + rs.getString("codesp") + "' <button class='btn btn-primary btn-xs'><i class='fa fa-pencil'></i></button> </a>");
                                            out.print("  <a href = '../procesos/aespecialidad.jsp?id=" + rs.getString("codesp") + "' <button class='btn btn-success btn-xs'><i class='fa fa-play'></i></button></a>");
                                            out.print("   <a href = '../procesos/eespecialidad.jsp?id=" + rs.getString("codesp") + "' <button class='btn btn-warning btn-xs'><i class='fa fa-stop'></i></button></a>");
                                            out.print("   <a href = '../procesos/elespecialidad.jsp?id=" + rs.getString("codesp") + "' <button class='btn btn-danger btn-xs'><i class='fa fa-eraser'></i></button></a>");
                                            out.print("   </td>");
                                            out.print(" </tr>");
                                        }
                                        out.print("  </tbody>");
                                        out.print(" </table>");
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
