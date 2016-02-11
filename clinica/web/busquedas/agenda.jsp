<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="clases.fechas"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<%
    conexion con = new conexion();
    ResultSet rs = null;
    String nom = "", apel = "", foto = "", id = "", pri = "", idno = "", idc = "";//variables de usuario
    String dia = "", diam = "", diami = "", diaj = "", diav = "", dias = "", diad = "";
    String empresa = "";//variable de empresa
    String user = (String) session.getAttribute("varUsuario");//variable que contiene la sesion activa
    String dato = (String) session.getAttribute("mover");
    int mover = Integer.parseInt(dato);
    Date pasa = new Date();
    fechas sr = new fechas();
    String url = request.getRequestURI();//varible que extrae url de pagina
    int acceso = 0;//varible de acceso a pagina
    if (user == null) {

    } else {
        dia = sr.srfecha(pasa, 0, mover);
        diam = sr.srfecha(pasa, 1, mover);
        diami = sr.srfecha(pasa, 2, mover);
        diaj = sr.srfecha(pasa, 3, mover);
        diav = sr.srfecha(pasa, 4, mover);
        dias = sr.srfecha(pasa, 5, mover);
        diad = sr.srfecha(pasa, 6, mover);
    }
    String buscar = request.getParameter("doctor");
    idc = request.getParameter("idc");
    ResultSet rs4 = con.consulta("select * from personas where dni='" + buscar + "'");
    while (rs4.next()) {
        out.print("<table class='table table-striped table-advance table-hover'>");
        out.print("   <center> <h4> Información del Especialista </h4></center>");
        out.print("  <hr>");
        out.print(" <thead>");
        out.print("  <tr>");
        out.print("    <th><i class='fa fa-barcode'></i> N° Identificación</th>");
        out.print("    <th class='hidden-phone'> <i class='fa fa-list-alt'></i>Nombres</th>");
        out.print("   <th><i class='fa fa-list'></i> Apellidos</th>");
        out.print(" <th><i class='fa fa-check-square-o'></i> Teléfono</th>");
        out.print("    <th class='hidden-phone'><i class='fa fa-cog'></i>Correo</th>");
        out.print("</tr>");
        out.print(" </thead>");
        out.print("  <tbody>");
            out.print("   <tr>");
            out.print("  <td>" + rs4.getString("dni") + "</td>");
            out.print("    <td class='hidden-phone'>" + rs4.getString("nombres") + "</td>");
            out.print("  <td>" + rs4.getString("apellidos") + "</td>");
            out.print("  <td>" + rs4.getString("telefono") + "</td>");
            out.print("  <td class='hidden-phone'>" + rs4.getString("correo") + "</td>");
            out.print(" </tr>");
        out.print("  </tbody>");
        out.print(" </table>");
    }
    ResultSet idp1 = con.consulta("select * from doctores where dnidoctor='" + buscar + "'");
    String idp = "";
    while (idp1.next()) {
        idp = idp1.getString("iddoctor");
    }
    rs = con.consulta("select count(*) from horarios where iddoctor='" + buscar + "'");
    String conte = "";
    while (rs.next()) {
        conte = rs.getString("count");
    }
    if (!conte.equals("0")) {
        id = buscar;
        out.print("  <form id='ncita' name='ncita' action='' method='POST'>");
        out.print("   <table class='table table-striped table-advance table-hover'>");
        out.print("   <center> <h4><i class='fa fa-list'></i> Agenda de Reservas del Especialista </h4></center>");
        out.print("  <hr>");
        out.print(" <thead>");
        out.print("     <tr>");

        out.print("        <th>Hora</th>");
        out.print("        <th>Lun-<input  type='text' size='2' readonly='readonly' name='dial' value=" + (dia.substring(8, 10)) + "></th>");
        out.print("       <th>Mar-<input  type='text' size='2' readonly='readonly' name='diam' value=" + (diam.substring(8, 10)) + "></th>");
        out.print("        <th>Mié-<input  type='text' size='2' readonly='readonly' name='diami' value=" + (diami.substring(8, 10)) + "></th>");
        out.print("       <th>Jue-<input  type='text' size='2' readonly='readonly' name='diaj' value=" + (diaj.substring(8, 10)) + "></th>");
        out.print("       <th>Vie-<input  type='text' size='2' readonly='readonly' name='diav' value=" + (diav.substring(8, 10)) + "></th>");
        out.print("       <th>Sáb-<input  type='text' size='2' readonly='readonly' name='dias' value=" + (dias.substring(8, 10)) + "></th>");
        out.print("       <th>Dom-<input  type='text' size='2' readonly='readonly' name='diad' value=" + (diad.substring(8, 10)) + "></th>");
        out.print("    </tr>");
        rs = con.consulta("select * from horarios h where iddoctor='" + buscar + "' order by horahor asc");
        int subir = 0;
        out.print(" </thead>");
        out.print("    <tbody>");

        ResultSet ocu = null;
        int sino = 0;
        DateFormat formatos = new SimpleDateFormat("HH:mm");
        DateFormat formatosf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar hora = Calendar.getInstance();
        String ahoran = formatosf.format(hora.getTime());
        Date factual = formatosf.parse(ahoran);
        String horaa = hora.get(Calendar.HOUR_OF_DAY) + ":" + hora.get(Calendar.MINUTE);
        Date hactual = formatos.parse(horaa);
        while (rs.next()) {
            subir++;
            if (rs.getString("horahor").equals("")) {

            } else {
                out.print("    <tr>");
                out.print(" <td><input type='text'  size='5' readonly='readonly' required='required' name='hora_" + subir + "' value='" + rs.getString("horahor") + "'/></td>");

                if (rs.getString("lunes").equals("t")) {
                    ocu = con.consulta("select count(*) from citas where medico='" + id + "' and fecha='" + dia + "' and hora='" + rs.getString("horahor") + "'");
                    while (ocu.next()) {
                        sino = ocu.getInt("count");
                    }
                    if (sino == 1) {
                        out.print("<td><a style='color:#B2B91D'> Reservado </a></td>");
                    } else {
                        Date hnueva = formatos.parse(rs.getString("horahor"));
                        Date fnueva = formatosf.parse(dia);
                        if (fnueva.compareTo(factual) >= 0) {
                            if (fnueva.compareTo(factual) == 0) {
                                if ((hnueva.compareTo(hactual) >= 0)) {
                                    out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + dia + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                                } else {
                                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                                }
                            } else {
                                out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + dia + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                            }
                        } else {
                            out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                        }
                    }
                } else {
                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                }
                if (rs.getString("martes").equals("t")) {
                    ocu = con.consulta("select count(*) from citas where medico='" + id + "' and fecha='" + diam + "' and hora='" + rs.getString("horahor") + "'");
                    while (ocu.next()) {
                        sino = ocu.getInt("count");
                    }
                    if (sino == 1) {
                        out.print("<td><a style='color:#B2B91D'> Reservado </a></td>");
                    } else {
                        Date hnueva = formatos.parse(rs.getString("horahor"));
                        Date fnueva = formatosf.parse(diam);
                        if (fnueva.compareTo(factual) >= 0) {
                            if (fnueva.compareTo(factual) == 0) {
                                if ((hnueva.compareTo(hactual) >= 0)) {
                                    out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diam + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                                } else {
                                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                                }
                            } else {
                                out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diam + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                            }
                        } else {
                            out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                        }
                    }
                } else {
                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                }
                if (rs.getString("miercoles").equals("t")) {
                    ocu = con.consulta("select count(*) from citas where medico='" + id + "' and fecha='" + diami + "' and hora='" + rs.getString("horahor") + "'");
                    while (ocu.next()) {
                        sino = ocu.getInt("count");
                    }
                    if (sino == 1) {
                        out.print("<td><a style='color:#B2B91D'> Reservado </a></td>");
                    } else {
                        Date hnueva = formatos.parse(rs.getString("horahor"));
                        Date fnueva = formatosf.parse(diami);
                        if (fnueva.compareTo(factual) >= 0) {
                            if (fnueva.compareTo(factual) == 0) {
                                if ((hnueva.compareTo(hactual) >= 0)) {
                                    out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diami + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                                } else {
                                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                                }
                            } else {
                                out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diami + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                            }
                        } else {
                            out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                        }
                    }
                } else {
                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                }
                if (rs.getString("jueves").equals("t")) {
                    ocu = con.consulta("select count(*) from citas where medico='" + id + "' and fecha='" + diaj + "' and hora='" + rs.getString("horahor") + "'");
                    while (ocu.next()) {
                        sino = ocu.getInt("count");
                    }
                    if (sino == 1) {
                        out.print("<td><a style='color:#B2B91D'> Reservado </a></td>");
                    } else {
                        Date hnueva = formatos.parse(rs.getString("horahor"));
                        Date fnueva = formatosf.parse(diaj);
                        if (fnueva.compareTo(factual) >= 0) {
                            if (fnueva.compareTo(factual) == 0) {
                                if ((hnueva.compareTo(hactual) >= 0)) {
                                    out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diaj + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                                } else {
                                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                                }
                            } else {
                                out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diaj + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                            }
                        } else {
                            out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                        }
                    }
                } else {
                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                }
                if (rs.getString("viernes").equals("t")) {
                    ocu = con.consulta("select count(*) from citas where medico='" + id + "' and fecha='" + diav + "' and hora='" + rs.getString("horahor") + "'");
                    while (ocu.next()) {
                        sino = ocu.getInt("count");
                    }
                    if (sino == 1) {
                        out.print("<td><a style='color:#B2B91D'> Reservado </a></td>");
                    } else {
                        Date hnueva = formatos.parse(rs.getString("horahor"));
                        Date fnueva = formatosf.parse(diav);
                        if (fnueva.compareTo(factual) >= 0) {
                            if (fnueva.compareTo(factual) == 0) {
                                if ((hnueva.compareTo(hactual) >= 0)) {
                                    out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diav + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                                } else {
                                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                                }
                            } else {
                                out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diav + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                            }
                        } else {
                            out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                        }
                    }
                } else {
                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                }
                if (rs.getString("sabado").equals("t")) {
                    ocu = con.consulta("select count(*) from citas where medico='" + id + "' and fecha='" + dias + "' and hora='" + rs.getString("horahor") + "'");
                    while (ocu.next()) {
                        sino = ocu.getInt("count");
                    }
                    if (sino == 1) {
                        out.print("<td><a style='color:#B2B91D'> Reservado </a></td>");
                    } else {
                        Date hnueva = formatos.parse(rs.getString("horahor"));
                        Date fnueva = formatosf.parse(dias);
                        if (fnueva.compareTo(factual) >= 0) {
                            if (fnueva.compareTo(factual) == 0) {
                                if ((hnueva.compareTo(hactual) >= 0)) {
                                    out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + dias + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                                } else {
                                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                                }
                            } else {
                                out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + dias + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                            }
                        } else {
                            out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                        }
                    }
                } else {
                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                }
                if (rs.getString("domingo").equals("t")) {
                    ocu = con.consulta("select count(*) from citas where medico='" + id + "' and fecha='" + diad + "' and hora='" + rs.getString("horahor") + "'");
                    while (ocu.next()) {
                        sino = ocu.getInt("count");
                    }
                    if (sino == 1) {
                        out.print("<td><a style='color:#B2B91D'> Reservado </a></td>");
                    } else {
                        Date hnueva = formatos.parse(rs.getString("horahor"));
                        Date fnueva = formatosf.parse(diad);
                        if (fnueva.compareTo(factual) >= 0) {
                            if (fnueva.compareTo(factual) == 0) {
                                if ((hnueva.compareTo(hactual) >= 0)) {
                                    out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diad + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                                } else {
                                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                                }
                            } else {
                                out.print("<td><a style='color:#34E768' href='ncita.jsp?hora=" + rs.getString("horahor") + "&&fecha=" + diad + "&&idd=" + id + "&&idp=" + idp + "&&idc=" + idc + "'>Disponible</a></td>");
                            }
                        } else {
                            out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                        }
                    }
                } else {
                    out.print("<td><a style='color:#FF3333'>No Disponible</a></td>");
                }
                out.print("    </tr>");

            }

        }
        out.print("  </tbody>");
        out.print("     </table>");
        out.print("  </form>");
    } else {
        out.print("No existen Registro de una Agenda de Reservas");
    }
%>
