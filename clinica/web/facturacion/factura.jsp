<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    conexion con = new conexion();
    ResultSet rs = null;
    String nom = "", apel = "", foto = "", id = "", pri = "", idno = "", identifica = "";//variables de usuario
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
        identifica = request.getParameter("id");
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
        <script language='JavaScript'>

            function borrar(tableID) {

                try {

                    var table = document.getElementById(tableID);

                    var rowCount = table.rows.length;
                    for (var i = 0; i < rowCount; i++) {

                        var row = table.rows[i];

                        var chkbox = row.cells[0].childNodes[0];

                        if (null != chkbox && true == chkbox.checked) {
                            var can = document.forms['form'].elements['var_cont'];
                            var t = parseInt(can.value);
                            t--;
                            document.forms['form'].elements['var_cont'].value = t;
                            table.deleteRow(i);

                            rowCount--;

                            i--;

                        }

                    }

                } catch (e) {

                    alert(e);

                }

            }


////////////FUNCION ASIGNA VALOR DE CONT PARA EL FOR DE MOSTRAR DATOS MP-MOD-TT////////

            function mul()
            {
                try {
                    var suma = 0.0;
                    var item = document.forms['form'].elements['var_cont1'];
                    var item1 = parseInt(item.value);
                    var iva = document.forms['form'].elements['iva'];
                    var iva1 = parseFloat(iva.value);
                    while (item1 > 0) {
                        var contador = document.forms['form'].elements['preu_' + item1];
                        var can = document.forms['form'].elements['cantidad_' + item1];
                        if (contador != null) {
                            var t = parseFloat(contador.value);
                            var t1 = parseFloat(can.value);
                            var t3 = t * t1;
                            suma = suma + t3;
                            document.forms['form'].elements['pret_' + item1].value = t3.toFixed(2);
                            var tiva = (suma * (((iva1) / 100) + 1)) - suma;
                            var ttotal = tiva + suma;
                            document.forms['form'].elements['txtsubtotal'].value = suma.toFixed(2);
                            document.forms['form'].elements['txtiva'].value = tiva.toFixed(2);
                            document.forms['form'].elements['txttotal'].value = ttotal.toFixed(2);
                        }
                        item1--;
                    }
                } catch (e) {

                    alert(e);

                }
            }
        </script>
    </head>

    <body onload="mul();">

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
                            <a  href="../administracion/panela.jsp">
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
                    <center><h4><i class="fa fa-refresh"></i>Facturación del Reservas </h4></center>
                    <div class="row mt">
                        <div class="col-lg-12">
                            <div class="form-panel">
                                <%
                                    rs = con.consulta("select count(*) from citas where estpago='Pendiente' and paciente='" + identifica + "'");
                                    int contador = 0;
                                    while (rs.next()) {
                                        contador = rs.getInt("count");

                                    }
                                    rs = con.consulta("select p.*,e.iva from citas c,personas p,empresa e where c.paciente='" + identifica + "' and c.paciente=p.dni limit 1");
                                    while (rs.next()) {%>
                                <form name="form" id="form" method="post" action="factura.jsp?id=<%out.print(identifica);%>">
                                    <table class="table table-striped table-advance table-hover" id="dataTable" >
                                        <tbody>
                                            <tr>
                                                <th colspan="8" scope="col"><center><h5><i class="fa fa-refresh"></i> Información del Cliente </h5></center></th>
                                        <tr>
                                            <td>
                                                <h5><span class='help-block'> Número de Identificación</span> </h5>
                                                <input type="text" class='form-control' name="txtcedula" id="txtcedula" readonly=”readonly” value="<%out.print(rs.getString("dni"));%>">
                                            </td>
                                            <td >
                                                <h5><span class='help-block'> Nombres</span> </h5>
                                                <input type="text" class='form-control' name="txtnombre" id="txtnombre" readonly=”readonly” value="<%out.print(rs.getString("nombres"));%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <h5><span class='help-block'> Apellidos</span> </h5>
                                                <input type="text" class='form-control' name="txtapellidos" id="txtapellidos" readonly=”readonly” value="<%out.print(rs.getString("apellidos"));%>"></td>
                                            <td>
                                                <h5><span class='help-block'> Telefono</span> </h5>
                                                <input type="text" class='form-control' name="txttelefono" id="txttelefono" readonly=”readonly” value="<%out.print(rs.getString("telefono"));%>"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <h5><span class='help-block'> dirección</span> </h5>
                                                <input name="txtdireccion" type="text" class='form-control' id="txtdireccion"  readonly=”readonly” value="<%out.print(rs.getString("direccion"));%>"></td>}
                                            <td>         <h5><span class='help-block'> Correo </span> </h5>
                                                <input name="txtcorreo" type="text" class='form-control' id="txtcorreo"  readonly=”readonly” value="<%out.print(rs.getString("correo"));%>">
                                                <input name="iva" type="text" style="display: none"  id="iva"  value="<%out.print(rs.getString("iva"));%>"></td>

                                        </tr>
                                        <%}%>
                                        <tr>
                                            <td colspan="2" align="center"><p>&nbsp;</p>

                                                <input type="text"  style="display: none" name="var_cont" value="<%out.print(contador);%>">
                                                <input type="text" style="display: none"  name="var_cont1" value="<%out.print(contador);%>">
                                                <table class="table table-striped table-advance table-hover" id="tabla">
                                                    <tbody>
                                                        <tr >
                                                            <th scope='col'></th>
                                                            <th scope='col'>Cod Cita</th>
                                                            <th scope='col'>Cod Servicio</th>
                                                            <th scope='col'>Cantidad</th>
                                                            <th scope='col'>Descripción</th>
                                                            <th scope='col'>P. Unitario</th>
                                                            <th scope='col'>P.Total</th>
                                                        </tr>
                                                        <%rs = con.consulta("select *,(round(valservicio::decimal,2))valtol from citas c,servicios s where c.estpago='Pendiente' and s.idservicio=c.servicio and c.paciente='" + identifica + "'");
                                                            int numero = 1;

                                                            while (rs.next()) {%>
                                                        <tr >
                                                            <td><input type="checkbox"  size="10" name="codigos_<%out.print(numero);%>" /></td>
                                                            <td><input type="text" size="3" readonly=”readonly”  value="<%out.print(rs.getString("idcita"));%>" name="cita_<%out.print(numero);%>"/></td>
                                                            <td><input type="text" size="8" readonly=”readonly”  value="<%out.print(rs.getString("idservicio"));%>" name="codigo_<%out.print(numero);%>"/></td>
                                                            <td><input type="text" size="3" readonly=”readonly”   value="<%out.print(rs.getString("cantidad"));%>" name="cantidad_<%out.print(numero);%>" /></td>';
                                                            <td><input type="text" readonly=”readonly”   value="<%out.print(rs.getString("nomservicio"));%>" name="producto_<%out.print(numero);%>"/></td>
                                                            <td> <input type="text" size="6" readonly=”readonly”   value="<%out.print(rs.getString("valtol"));%>" name="preu_<%out.print(numero);%>"/></td>
                                                            <td> <input type="text" size="6" readonly=”readonly”  value="0" name="pret_<%out.print(numero);%>"></td>
                                                        </tr>
                                                        <%  numero++;
                                                            }
                                                        %>
                                                    </tbody>
                                                </table><input type="button" name="btnmenos" id="btnmenos" value="Eliminar Servicio de Factura" class="btn btn-default btn-lg btn-block" onClick="borrar('tabla');
                                                        mul();">

                                                <p>&nbsp;</p></td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <h5><span class='help-block'> Observaciones</span> </h5>
                                                <textarea name="txtarea" id="txtarea" rows="8" class='form-control'></textarea>
                                                </p></td>
                                            <td align="right"><p>&nbsp;</p>
                                                <p>
                                                    <label for="textfield">Subtotal:</label>
                                                    <input type="text" readonly=”readonly” name="txtsubtotal" id="txtsubtotal">
                                                </p>
                                                <p>
                                                    <label for="textfield2">Iva:</label>
                                                    <input type="text" readonly=”readonly” name="txtiva" id="txtiva">
                                                </p>
                                                <p>
                                                    <label for="textfield4">Total:</label>
                                                    <input type="text" readonly=”readonly” name="txttotal" id="txttotal">
                                                </p>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <input type="submit" name="btnenviar" id="btnenviar" value="Enviar Para Facturar" class="btn btn-default btn-lg btn-block">
                                </form>
                                <%
                                    try {
                                        if (request.getParameter("btnenviar") != null) {
                                            String codigoide = request.getParameter("txtcedula");
                                            String subtotal = request.getParameter("txtsubtotal");
                                            String iva = request.getParameter("txtiva");
                                            String total = request.getParameter("txttotal");
                                            String observacion = request.getParameter("txtarea");
                                            con.consulta("INSERT INTO facturas( cliente, subtotal, iva, total, observacion)VALUES ('" + codigoide + "', " + subtotal + ", " + iva + ", " + total + ", '" + observacion + "');");
                                            int datost = Integer.parseInt(request.getParameter("var_cont1"));
                                            for (int i = 1; i <= datost; i++) {
                                                String seleccion = request.getParameter("codigos_" + i);
                                                String codci = request.getParameter("cita_" + i);
                                                String codser = request.getParameter("codigo_" + i);
                                                String preu = request.getParameter("preu_" + i);
                                                String producto = request.getParameter("producto_" + i);
                                                String cantidad = request.getParameter("cantidad_" + i);
                                                String pret = request.getParameter("pret_" + i);
                                                con.consulta("INSERT INTO dfactura( idcita, idservicio, cantidad, descripcion, punitario,ptotal,codfactura)VALUES (" + codci + ", '" + codser + "', " + cantidad + ", '" + producto + "'," + preu + " , " + pret + ",(select idfactura from facturas order by idfactura desc limit 1));");
                                                con.consulta("update citas set estpago='Pagado' where idcita=" + codci + "");
                                            }
                                            con.consulta("delete from dfactura where idservicio='null'");
                                            out.print("<script>");
                                            out.print("swal({title: 'Información del Sistema', text: 'Transacción Exitosa', type: 'warning', showCancelButton: false, confirmButtonColor: '#01DF3A', confirmButtonText: 'Ok', cancelButtonText: 'No, cancel plx!', closeOnConfirm: false, closeOnCancel: false}, function(isConfirm) {");
                                            out.print("if (isConfirm) {");
                                            out.print("window.location = '../facturacion/vfactura.jsp';");
                                            out.print("}");
                                            out.print("});");
                                            out.print("</script>");
                                        }
                                    } catch (Exception e) {

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
