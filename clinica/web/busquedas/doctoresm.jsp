<%@page import="java.sql.ResultSet"%>
<%@page import="clases.conexion"%>
<form  id="dos" name="dos" action="ncitas_1.jsp" method="POST">
    <div class="form-group">
        <h5><span class='help-block'> Seleccione el Especialista </span></h5>
        <select name="doctor" required class="form-control" id="doctor">
            <option value="">Seleccione el Especialista </option>
            <%
                String esp = request.getParameter("espe");
                String idc = request.getParameter("idc");
                conexion con = new conexion();
                ResultSet rs = null;
                rs = con.consulta("select d.*,p.* from doctores d,personas p where d.dnidoctor=p.dni and d.estdoctor='true' and d.espdoctor='" + esp + "'");
                while (rs.next()) {
                    out.print("<option value='" + rs.getString("dnidoctor") + "'>Dr. " + rs.getString("apellidos") + "</option>");
                }
            %>
        </select>
        <div class="form-group">
            <input name="idc" value="<%out.print(idc);%>" style=" display:none;">
        </div>
    </div>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        $('#doctor').change(function() {
            var datos = $('#dos').serialize();
            $.ajax({
                type: "POST",
                //data: dataString,
                url: "../busquedas/agendas.jsp",
                data: datos,
                success: function(a) {
                    $('#agenda').html(a);
                }
            });
        });
    });
</script>



