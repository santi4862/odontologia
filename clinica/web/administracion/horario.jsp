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
            id = rs.getString("dni");
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
        <link rel="stylesheet" type="text/css" href="../assets/js/gritter/css/jquery.gritter.css" />
        <link rel="stylesheet" type="text/css" href="../assets/lineicons/style.css">   
        <link href="../assets/css/style.css" rel="stylesheet">
        <link href="../assets/css/style-responsive.css" rel="stylesheet">
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
                    <center><h4><i class="fa fa-refresh"></i>Generando Horario de Trabajo</h4></center>
                    <div class="row mt">

                        <div class="col-lg-12">
                            <div class="form-panel">

                                <div class="form-group">
                                    <%
                                        if (request.getParameter("btnenviar") != null) {
                                            String dias[] = {"lunes", "martes", "miercoles", "jueves", "viernes", "sabado", "domingo"};
                                            int fil = Integer.parseInt(request.getParameter("horas"));
                                            String diaie = request.getParameter("diai");
                                            String diafe = request.getParameter("diaf");
                                            String tardeie = request.getParameter("tardei");
                                            String tardefe = request.getParameter("tardef");
                                            String tiempo = request.getParameter("tiempo");
                                            con.consulta("INSERT INTO horario( iddoctor, diai, diaf, tardei, tardef, tiempo) VALUES ( '" + id + "', '" + diaie + "', '" + diafe + "', '" + tardeie + "', '" + tardefe + "', '" + tiempo + "');");
                                            for (int i = 1; i <= fil; i++) {
                                                String hora = request.getParameter("hora_" + i);
                                                String l = request.getParameter(dias[0] + "_" + i);
                                                if (l != null) {
                                                    l = "true";
                                                } else {
                                                    l = "false";
                                                }
                                                String m = request.getParameter(dias[1] + "_" + i);
                                                if (m != null) {
                                                    m = "true";
                                                } else {
                                                    m = "false";
                                                }
                                                String mi = request.getParameter(dias[2] + "_" + i);
                                                if (mi != null) {
                                                    mi = "true";
                                                } else {
                                                    mi = "false";
                                                }
                                                String ju = request.getParameter(dias[3] + "_" + i);
                                                if (ju != null) {
                                                    ju = "true";
                                                } else {
                                                    ju = "false";
                                                }
                                                String v = request.getParameter(dias[4] + "_" + i);
                                                if (v != null) {
                                                    v = "true";
                                                } else {
                                                    v = "false";
                                                }
                                                String s = request.getParameter(dias[5] + "_" + i);
                                                if (s != null) {
                                                    s = "true";
                                                } else {
                                                    s = "false";
                                                }
                                                String d = request.getParameter(dias[6] + "_" + i);
                                                if (d != null) {
                                                    d = "true";
                                                } else {
                                                    d = "false";
                                                }

                                                con.consulta("INSERT INTO horarios( horahor, iddoctor, lunes, martes, miercoles, jueves,viernes, sabado, domingo,idhorarios)    VALUES ( '" + hora + "', '" + id + "', '" + l + "', '" + m + "', '" + mi + "', '" + ju + "',  '" + v + "', '" + s + "','" + d + "',(select idhorario from horario order by idhorario desc limit 1));");

                                            }
                                            out.print("<script>");
                                            out.print("swal({title: 'Información del Sistema', text: 'Información Guardada Correctamente', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                                            out.print("if (isConfirm) {");
                                            out.print("window.location = '../administracion/horario.jsp';");
                                            out.print("}");
                                            out.print("});");
                                            out.print("</script>");
                                        }
                                    %>


                                    <%
                                        rs = con.consulta("select count(*) from horarios where iddoctor='" + id + "'");
                                        String conte = "";
                                        while (rs.next()) {
                                            conte = rs.getString("count");
                                        }
                                        if (!conte.equals("0")) {

                                            out.print("  <form id='horas' name='horas' action='' method='POST'>");
                                            ResultSet rsh = con.consulta("select * from horario where iddoctor='" + id + "'");
                                            while (rsh.next()) {
                                    %>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Hora Inicio en la Mañana </span></h5>
                                        <input type="text" required class="form-control" readonly=”readonly” id="diai" name="diai" value="<%out.print(rsh.getString("diai")); %>"/>
                                    </div>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Hora Final de la Mañana </span></h5>
                                        <input type="text" required class="form-control" readonly=”readonly” id="diaf" name="diaf" value="<%out.print(rsh.getString("diaf")); %>"/>
                                    </div>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Hora Inicio en la Tarde </span></h5>
                                        <input type="text" required class="form-control" readonly=”readonly” id="tardei" name="tardei" value="<%out.print(rsh.getString("tardei")); %>"/>
                                    </div>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Hora Final en la Tarde </span></h5>
                                        <input type="text" required class="form-control" readonly=”readonly” id="tardef" name="tardef" value="<%out.print(rsh.getString("tardef")); %>"/>
                                    </div>
                                    <div class="form-group">
                                        <h5><span class='help-block'> Tiempo Estimado por Reservación </span></h5>
                                        <input type="text" required class="form-control" id="tiempo" name="tiempo" value="<%out.print(rsh.getString("tiempo")); %>"/>
                                    </div>
                                    <input type="button" class="btn btn-default btn-lg btn-block" value="Generar Horario " onClick="limpiar('tabla');
                                            genera();">
                                    <input type="button" class="btn btn-default btn-lg btn-block" value="Eliminar Horas Seleccionadas" onClick="borrar('tabla');">

                                    <%
                                        }
                                        out.print("   <table class='table table-striped table-advance table-hover' id='tabla'>");
                                        out.print("    <tbody>");
                                        out.print("       <tr>");
                                        out.print("       <th colspan='9' scope='col'><center><h><i class='fa fa-refresh'></i>Mostrando Horario Generado <input type='text' value='" + conte + "' name='horas' id='horas' size='1' style='display: none'></h5></center></th>");
                                        out.print("    </tr>");
                                        out.print("     <tr>");
                                        out.print("        <th scope='col'>Acción</th>");
                                        out.print("        <th scope='col'>Hora</th>");
                                        out.print("        <th scope='col'>Lun</th>");
                                        out.print("       <th scope='col'>Mar</th>");
                                        out.print("        <th scope='col'>Mié</th>");
                                        out.print("       <th scope='col'>Jue</th>");
                                        out.print("       <th scope='col'>Vie</th>");
                                        out.print("       <th scope='col'>Sáb</th>");
                                        out.print("       <th scope='col'>Dom</th>");
                                        out.print("    </tr>");
                                        out.print("     <tr>");
                                        out.print("        <th scope='col'>Eliminar Hora </th>");
                                        out.print("        <th scope='col'>Activar Dias </th>");
                                        out.print("        <th scope='col'><input type='checkbox'  name='lunes' onclick='activar(1);'/></th>");
                                        out.print("       <th scope='col'><input type='checkbox'  name='martes' onclick='activar(2);'/></th>");
                                        out.print("        <th scope='col'><input type='checkbox'  name='miercoles' onclick='activar(3);'/></th>");
                                        out.print("       <th scope='col'><input type='checkbox'  name='jueves' onclick='activar(4);'/></th>");
                                        out.print("       <th scope='col'><input type='checkbox'  name='viernes' onclick='activar(5);'/></th>");
                                        out.print("       <th scope='col'><input type='checkbox'  name='sabado' onclick='activar(6);'/></th>");
                                        out.print("       <th scope='col'><input type='checkbox'  name='domingo' onclick='activar(7);'/></th>");
                                        out.print("    </tr>");
                                        rs = con.consulta("select * from horarios h where iddoctor='" + id + "'");
                                        int subir = 0;
                                        while (rs.next()) {
                                            subir++;
                                            if (rs.getString("horahor").equals("")) {
                                                out.print("    <tr><td><input type='time'  size='5'  name='hora_" + subir + "' style='display: none'/><br></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
                                            } else {
                                                out.print("    <tr>");
                                                out.print(" <td><input type='checkbox'  name='codigos_" + subir + "'/></td>");
                                                out.print(" <td><input type='time'  size='5'  name='hora_" + subir + "' value='" + rs.getString("horahor") + "'/></td>");
                                                if (rs.getString("lunes").equals("t")) {
                                                    out.print("<td><input checked='checked' type='checkbox'  name='lunes_" + subir + "' /></td>");

                                                } else {
                                                    out.print("<td><input type='checkbox' name='lunes_" + subir + "' /></td>");

                                                }
                                                if (rs.getString("martes").equals("t")) {
                                                    out.print("<td><input checked='checked' type='checkbox' name='martes_" + subir + "'/></td>");

                                                } else {
                                                    out.print("<td><input type='checkbox' name='martes_" + subir + "'/></td>");

                                                }
                                                if (rs.getString("miercoles").equals("t")) {
                                                    out.print("<td> <input checked='checked' type='checkbox' name='miercoles_" + subir + "'/></td>");
                                                } else {
                                                    out.print("<td> <input type='checkbox'  name='miercoles_" + subir + "'/></td>");

                                                }
                                                if (rs.getString("jueves").equals("t")) {
                                                    out.print("<td> <input checked='checked' type='checkbox' name='jueves_" + subir + "'></td>");

                                                } else {
                                                    out.print("<td> <input type='checkbox' name='jueves_" + subir + "'></td>");

                                                }
                                                if (rs.getString("viernes").equals("t")) {
                                                    out.print(" <td> <input checked='checked' type='checkbox' name='viernes_" + subir + "'></td>");

                                                } else {
                                                    out.print(" <td> <input type='checkbox' name='viernes_" + subir + "'></td>");

                                                }
                                                if (rs.getString("sabado").equals("t")) {
                                                    out.print(" <td><input checked='checked'  type='checkbox' name='sabado_" + subir + "'></td>");

                                                } else {
                                                    out.print(" <td><input type='checkbox' name='sabado_" + subir + "'></td>");

                                                }
                                                if (rs.getString("domingo").equals("t")) {
                                                    out.print("<td> <input checked='checked' type='checkbox' name='domingo_" + subir + "'></td>");

                                                } else {
                                                    out.print("<td> <input type='checkbox' name='domingo_" + subir + "'></td>");

                                                }
                                                out.print("    </tr>");
                                            }
                                        }
                                        out.print("  </tbody>");
                                        out.print("     </table>");
                                        out.print("   <input type='submit' class='btn btn-default btn-lg btn-block' name='actualiza' id='actualiza' value='Actualizar horario'>");
                                        out.print("  </form>");
                                    } else {
                                    %>

                                    <form name="horas" id="horas" action="horario.jsp" method="POST">
                                        <div class="form-group">
                                            <h5><span class='help-block'> Hora Inicio en la Mañana </span></h5>
                                            <input type="text" required class="form-control" readonly=”readonly” id="diai" name="diai" value="12:00"/>
                                        </div>
                                        <div class="form-group">
                                            <h5><span class='help-block'> Hora Final de la Mañana </span></h5>
                                            <input type="text" required class="form-control" readonly=”readonly” id="diaf" name="diaf" value="13:00"/>
                                        </div>
                                        <div class="form-group">
                                            <h5><span class='help-block'> Hora Inicio en la Tarde </span></h5>
                                            <input type="text" required class="form-control" readonly=”readonly” id="tardei" name="tardei" value="17:00"/>
                                        </div>
                                        <div class="form-group">
                                            <h5><span class='help-block'> Hora Final en la Tarde </span></h5>
                                            <input type="text" required class="form-control" readonly=”readonly” id="tardef" name="tardef" value="18:00"/>
                                        </div>
                                        <div class="form-group">
                                            <h5><span class='help-block'> Tiempo Estimado por Reservación </span></h5>
                                            <input type="text" required class="form-control" id="tiempo" name="tiempo" value="15"/>
                                        </div>
                                        <input type="button" class="btn btn-default btn-lg btn-block" value="Generar Horario " onClick="limpiar('tabla');
                                                genera();">
                                        <input type="button" class="btn btn-default btn-lg btn-block" value="Eliminar Horas Seleccionadas" onClick="borrar('tabla');">
                                        <table  class="table table-striped table-advance table-hover" id="tabla">
                                            <tbody>
                                                <tr>
                                                    <th colspan="9" scope="col"><center><h5><i class="fa fa-refresh"></i>Mostrando Horario Generado <input type="text" value="0" name="horas" id="horas" size="1" style=""></h5></center></th>
                                            </tr>
                                            <tr>
                                                <th>Accion</th>
                                                <th>Hora</th>
                                                <th>Lun</th>
                                                <th>Mar</th>
                                                <th>Mié</th>
                                                <th>Jue</th>
                                                <th>Vie</th>
                                                <th>Sáb</th>
                                                <th>Dom</th>
                                            </tr>
                                            </tbody>
                                        </table>
                                        <input type="submit" class="btn btn-default btn-lg btn-block" name="btnenviar" id="btnenviar" value="Guardar Horario">
                                    </form>                                   
                                    <%
                                        }

                                    %>

                                    <%    if (request.getParameter("actualiza") != null) {
                                            con.consulta("delete from horario where iddoctor='" + id + "'");
                                            con.consulta("delete from horarios where iddoctor='" + id + "'");
                                            String dias[] = {"lunes", "martes", "miercoles", "jueves", "viernes", "sabado", "domingo"};
                                            int fil = Integer.parseInt(request.getParameter("horas"));
                                            String diaie = request.getParameter("diai");
                                            String diafe = request.getParameter("diaf");
                                            String tardeie = request.getParameter("tardei");
                                            String tardefe = request.getParameter("tardef");
                                            String tiempo = request.getParameter("tiempo");
                                            con.consulta("INSERT INTO horario( iddoctor, diai, diaf, tardei, tardef, tiempo) VALUES ( '" + id + "', '" + diaie + "', '" + diafe + "', '" + tardeie + "', '" + tardefe + "', '" + tiempo + "');");
                                            for (int i = 1; i <= fil; i++) {
                                                String hora = request.getParameter("hora_" + i);
                                                String l = request.getParameter(dias[0] + "_" + i);
                                                if (l != null) {
                                                    l = "true";
                                                } else {
                                                    l = "false";
                                                }
                                                String m = request.getParameter(dias[1] + "_" + i);
                                                if (m != null) {
                                                    m = "true";
                                                } else {
                                                    m = "false";
                                                }
                                                String mi = request.getParameter(dias[2] + "_" + i);
                                                if (mi != null) {
                                                    mi = "true";
                                                } else {
                                                    mi = "false";
                                                }
                                                String ju = request.getParameter(dias[3] + "_" + i);
                                                if (ju != null) {
                                                    ju = "true";
                                                } else {
                                                    ju = "false";
                                                }
                                                String v = request.getParameter(dias[4] + "_" + i);
                                                if (v != null) {
                                                    v = "true";
                                                } else {
                                                    v = "false";
                                                }
                                                String s = request.getParameter(dias[5] + "_" + i);
                                                if (s != null) {
                                                    s = "true";
                                                } else {
                                                    s = "false";
                                                }
                                                String d = request.getParameter(dias[6] + "_" + i);
                                                if (d != null) {
                                                    d = "true";
                                                } else {
                                                    d = "false";
                                                }

                                                con.consulta("INSERT INTO horarios( horahor, iddoctor, lunes, martes, miercoles, jueves,viernes, sabado, domingo,idhorarios)    VALUES ( '" + hora + "', '" + id + "', '" + l + "', '" + m + "', '" + mi + "', '" + ju + "',  '" + v + "', '" + s + "','" + d + "',(select idhorario from horario order by idhorario desc limit 1));");

                                            }
                                            con.consulta("delete from horarios where horahor='null' and iddoctor='" + id + "'");
                                            out.print("<script>");
                                            out.print("swal({title: 'Información del Sistema', text: 'Información Actualizada Correctamente', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                                            out.print("if (isConfirm) {");
                                            out.print("window.location = '../administracion/horario.jsp';");
                                            out.print("}");
                                            out.print("});");
                                            out.print("</script>");

                                        }
                                    %>



                                </div>
                            </div>
                        </div>  
                </section>
            </section>

        </section>




        <link rel="stylesheet" href="../css/jquery-ui-1.10.0.custom.min.css" type="text/css" />
        <script type="text/javascript" src="../js/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.core.min.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.widget.min.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.tabs.min.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.position.min.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.timepicker.js"></script>

        <script type="text/javascript">
                                            $(document).ready(function() {
                                                $('#diai').timepicker(
                                                        {
                                                            onSelect: tpStartSelect,
                                                            maxTime: {
                                                                hour: 13, minute: 00
                                                            }
                                                        }
                                                );
                                                $('#diaf').timepicker(
                                                        {
                                                            onSelect: tpEndSelect,
                                                            minTime: {
                                                                hour: 12, minute: 00
                                                            }
                                                        }
                                                );
                                            });

                                            // when start time change, update minimum for end timepicker
                                            function tpStartSelect(time, endTimePickerInst) {
                                                $('#diaf').timepicker('option', {
                                                    minTime: {
                                                        hour: endTimePickerInst.hours,
                                                        minute: endTimePickerInst.minutes
                                                    }
                                                });
                                            }

                                            // when end time change, update maximum for start timepicker
                                            function tpEndSelect(time, startTimePickerInst) {
                                                $('#diai').timepicker('option', {
                                                    maxTime: {
                                                        hour: startTimePickerInst.hours,
                                                        minute: startTimePickerInst.minutes
                                                    }
                                                });
                                            }
        </script>


        <script type="text/javascript">
            $(document).ready(function() {
                $('#tardei').timepicker(
                        {
                            onSelect: tpStartSelect1,
                            maxTime: {
                                hour: 18, minute: 00
                            }
                        }
                );
                $('#tardef').timepicker(
                        {
                            onSelect: tpEndSelect1,
                            minTime: {
                                hour: 17, minute: 00
                            }
                        }
                );
            });

            // when start time change, update minimum for end timepicker
            function tpStartSelect1(time, endTimePickerInst) {
                $('#tardef').timepicker('option', {
                    minTime: {
                        hour: endTimePickerInst.hours,
                        minute: endTimePickerInst.minutes
                    }
                });
            }

            // when end time change, update maximum for start timepicker
            function tpEndSelect1(time, startTimePickerInst) {
                $('#tardei').timepicker('option', {
                    maxTime: {
                        hour: startTimePickerInst.hours,
                        minute: startTimePickerInst.minutes
                    }
                });
            }
        </script>



        <script>
            var total = 0;
            var cont = 0;
            function genera() {
                //hora de la mañana
                inicio = document.forms['horas'].elements['diai'].value;
                fin = document.forms['horas'].elements['diaf'].value;
                conteo = document.forms['horas'].elements['tiempo'].value;
                conteo1 = parseInt(conteo);
                inicioMinutos = parseInt(inicio.substr(3, 2));
                inicioHoras = parseInt(inicio.substr(0, 2));

                finMinutos = parseInt(fin.substr(3, 2));
                finHoras = parseInt(fin.substr(0, 2));

                transcurridoMinutos = finMinutos - inicioMinutos;
                transcurridoHoras = finHoras - inicioHoras;

                if (transcurridoMinutos < 0) {
                    transcurridoHoras--;
                    transcurridoMinutos = 60 + transcurridoMinutos;
                }

                horas = transcurridoHoras.toString();
                minutos = transcurridoMinutos.toString();

                if (horas.length < 2) {
                    horas = "0" + horas;
                }

                if (horas.length < 2) {
                    horas = "0" + horas;
                }
                var ho = parseInt(horas) * 60;
                var mi = parseInt(minutos);
                total = ho + mi;
                var verif = 0;
                verif = total;
                var sumh = 0;
                sumh = parseInt(inicioMinutos);
                var summ = 0;
                summ = parseInt(inicioHoras);


                //cargar select 
                var indiceFila = 1;
                myNewRow = document.getElementById('tabla').insertRow(-1);
                myNewRow.id = indiceFila;
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<td>Eliminar Horas</td>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<td>Activar Dias</td>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<td><input type="checkbox"  name="lunes" onclick="activar(1);"/></td>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<input type="checkbox"    name="martes" onclick="activar(2);"/>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<input type="checkbox"    name="miercoles" onclick="activar(3);"/>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<input type="checkbox"   name="jueves" onclick="activar(4);"/>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<input type="checkbox"   name="viernes" onclick="activar(5);"/>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<input type="checkbox"  name="sabado" onclick="activar(6);"/>';
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<input type="checkbox"  name="domingo" onclick="activar(7);"/>';

                //fin del select


                for (i = 0; i < total; i = i + conteo1) {

                    var camh = "";
                    var camm = "";
                    camh = summ.toString();
                    camm = sumh.toString();
                    if (camh == "0" || camh == "1" || camh == "2" || camh == "3" || camh == "4" || camh == "5" || camh == "6" || camh == "7" || camh == "8" || camh == "9") {
                        camh = "0" + camh;
                    }
                    if (camm == "0" || camm == "1" || camm == "2" || camm == "3" || camm == "4" || camm == "5" || camm == "6" || camm == "7" || camm == "8" || camm == "9") {
                        camm = "0" + camm;
                    }
                    if ((verif + (conteo1 / 2.5)) >= conteo1) {
                        cont++;
                        var indiceFila = 1;
                        myNewRow = document.getElementById('tabla').insertRow(-1);
                        myNewRow.id = indiceFila;
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<td><input type="checkbox"  name="codigos_' + cont + '" /></td>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<td><input type="time" value="' + camh + ":" + camm + '" required size="5" name="hora_' + cont + '" /></td>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<td><input type="checkbox"  name="lunes_' + cont + '" /></td>';

                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"    name="martes_' + cont + '"/>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"    name="miercoles_' + cont + '"/>';

                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"   name="jueves_' + cont + '">';

                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"   name="viernes_' + cont + '">';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"  name="sabado_' + cont + '">';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"  name="domingo_' + cont + '">';
                        indiceFila++;
                    }
                    sumh = sumh + conteo1;
                    verif = verif - conteo1;
                    if (sumh > 59) {
                        sumh = sumh - 60;
                        summ++;
                    }
                    if (summ > 23) {
                        summ = summ - 24;
                    }
                }



                //hora de descanso
                cont++;
                myNewRow = document.getElementById('tabla').insertRow(-1);
                myNewRow.id = 1;
                myNewCell = myNewRow.insertCell(-1);
                myNewCell.innerHTML = '<td colspan="9" align="center"><input type="time"  name="hora_' + cont + '" style="display: none"><br></td>';
                //hora de la tarde
                inicio = document.forms['horas'].elements['tardei'].value;
                fin = document.forms['horas'].elements['tardef'].value;
                conteo = document.forms['horas'].elements['tiempo'].value;
                conteo1 = parseInt(conteo);
                inicioMinutos = parseInt(inicio.substr(3, 2));
                inicioHoras = parseInt(inicio.substr(0, 2));

                finMinutos = parseInt(fin.substr(3, 2));
                finHoras = parseInt(fin.substr(0, 2));

                transcurridoMinutos = finMinutos - inicioMinutos;
                transcurridoHoras = finHoras - inicioHoras;

                if (transcurridoMinutos < 0) {
                    transcurridoHoras--;
                    transcurridoMinutos = 60 + transcurridoMinutos;
                }

                horas = transcurridoHoras.toString();
                minutos = transcurridoMinutos.toString();

                if (horas.length < 2) {
                    horas = "0" + horas;
                }

                if (horas.length < 2) {
                    horas = "0" + horas;
                }
                var ho = parseInt(horas) * 60;
                var mi = parseInt(minutos);
                total = ho + mi;
                var verif = 0;
                verif = total;
                var sumh = 0;
                sumh = parseInt(inicioMinutos);
                var summ = 0;
                summ = parseInt(inicioHoras);
                for (i = 0; i < total; i = i + conteo1) {

                    var camh = "";
                    var camm = "";
                    camh = summ.toString();
                    camm = sumh.toString();
                    if (camh == "0" || camh == "1" || camh == "2" || camh == "3" || camh == "4" || camh == "5" || camh == "6" || camh == "7" || camh == "8" || camh == "9") {
                        camh = "0" + camh;
                    }
                    if (camm == "0" || camm == "1" || camm == "2" || camm == "3" || camm == "4" || camm == "5" || camm == "6" || camm == "7" || camm == "8" || camm == "9") {
                        camm = "0" + camm;
                    }
                    if ((verif + (conteo1 / 2.5)) >= conteo1) {
                        cont++;
                        var indiceFila = 1;
                        myNewRow = document.getElementById('tabla').insertRow(-1);
                        myNewRow.id = indiceFila;
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<td><input type="checkbox"  name="codigos_' + cont + '" /></td>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<td><input type="time" value="' + camh + ":" + camm + '" required size="5" name="hora_' + cont + '" /></td>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<td><input type="checkbox"   name="lunes_' + cont + '" /></td>';

                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"    name="martes_' + cont + '"/>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"    name="miercoles_' + cont + '"/>';

                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"  name="jueves_' + cont + '"/>';

                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"  name="viernes_' + cont + '"/>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"  name="sabado_' + cont + '"/>';
                        myNewCell = myNewRow.insertCell(-1);
                        myNewCell.innerHTML = '<input type="checkbox"  name="domingo_' + cont + '"/>';
                        indiceFila++;
                    }
                    sumh = sumh + conteo1;
                    verif = verif - conteo1;
                    if (sumh > 59) {
                        sumh = sumh - 60;
                        summ++;
                    }
                    if (summ > 23) {
                        summ = summ - 24;
                    }
                }
                document.forms['horas'].elements['horas'].value = cont;
            }
            function borrar(tableID) {

                try {
                    var table = document.getElementById(tableID);
                    var rowCount = table.rows.length;
                    for (var i = 0; i < rowCount; i++) {
                        var row = table.rows[i];
                        var chkbox = row.cells[0].childNodes[0];
                        if (null != chkbox && true == chkbox.checked) {
                            table.deleteRow(i);
                            rowCount--;
                            i--;
                        }
                    }

                } catch (e) {
                    alert(e);
                }
            }
            function limpiar(tableID) {

                try {
                    var table = document.getElementById(tableID);
                    var rowCount = table.rows.length;
                    for (var i = 2; i < rowCount; i++) {
                        table.deleteRow(i);
                        rowCount--;
                        i--;
                        cont = 0;
                        total = 0;
                    }

                } catch (e) {
                    alert(e);
                }
            }
            function activar(id) {

                try {
                    var diasv = "";
                    if (id == 1) {
                        diasv = "lunes";
                    } else if (id == 2) {
                        diasv = "martes";
                    } else if (id == 3) {
                        diasv = "miercoles";
                    }
                    else if (id == 4) {
                        diasv = "jueves";
                    }
                    else if (id == 5) {
                        diasv = "viernes";
                    }
                    else if (id == 6) {
                        diasv = "sabado";
                    }
                    else if (id == 7) {
                        diasv = "domingo";
                    }
                    var table = document.getElementById('tabla');
                    var rowCount = table.rows.length;
                    for (var i = 1; i < rowCount; i++) {
                        var chkbox = document.forms['horas'].elements[diasv].checked;
                        if (chkbox == true) {
                            var probar = document.forms['horas'].elements[diasv + '_' + i];
                            if (probar != null) {
                                document.forms['horas'].elements[diasv + '_' + i].checked = true;
                            }


                        } else
                        {
                            var probar = document.forms['horas'].elements[diasv + '_' + i];
                            if (probar != null) {
                                document.forms['horas'].elements[diasv + '_' + i].checked = false;
                            }
                        }

                    }

                } catch (e) {

                    alert(e);

                }

            }


        </script>
        <!-- Plugin utilizados a iniciar -->
        <script src="../assets/js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="../assets/js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="../assets/js/jquery.scrollTo.min.js"></script>
        <script src="../assets/js/jquery.nicescroll.js" type="text/javascript"></script>
        <script src="../assets/js/jquery.sparkline.js"></script>
        <script src="../assets/js/common-scripts.js"></script>
        <script type="text/javascript" src="../assets/js/gritter/js/jquery.gritter.js"></script>
        <script type="text/javascript" src="../assets/js/gritter-conf.js"></script>
        <script src="../assets/js/sparkline-chart.js"></script>
    </body>
</html>
