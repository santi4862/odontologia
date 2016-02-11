<%
    String dato = (String) session.getAttribute("mover");
    int mover = Integer.parseInt(dato);
    mover--;
    String inc = Integer.toString(mover);
    session.setAttribute("mover", inc);
    out.print("restado");
%>
