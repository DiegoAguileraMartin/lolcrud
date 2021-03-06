<%-- 
    Document   : editar
    Created on : 23 feb 2022, 17:57:51
    Author     : Usuario
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="css/peceraStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <title>Editar Campeones</title>
        <link rel="icon" type="image/x-icon" href="./images/logo.png">
    </head>
    <body>


        <%request.setCharacterEncoding("UTF-8");%>

        <%

            String identificadorCampeon = request.getParameter("id");
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/lolcrud?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
            Statement s = conexion.createStatement();

            Statement w = conexion.createStatement();

            boolean campeonRepetido = false;

            ResultSet campeon = w.executeQuery("SELECT * FROM listado_campeon WHERE CodUsu = " + session.getAttribute("codigoUsuario"));

            while (campeon.next()) {
                if (request.getParameter("NomCamp").toString().equals(campeon.getString("NomCamp").toString())) {
                    campeonRepetido = true;
                }
            }

            if (campeonRepetido) {
                session.setAttribute("errorCampeon", "campeon repetido");
                response.sendRedirect("listado.jsp");
            }else {

                ResultSet listadoCampeon = s.executeQuery("SELECT * FROM listado_campeon");
                listadoCampeon.next();

                String insertarCampeon = "UPDATE listado_campeon SET "
                        
                        + "NomCamp='" + request.getParameter("NomCamp") + "',"
                        + "LineaCamp='" + request.getParameter("LineaCamp") + "',"
                        + "RolHabCamp='" + request.getParameter("RolHabCamp")+ "',"
                        + "DescCamp='"+ request.getParameter("DescCamp")+ "',"
                        + "CodUsu='" + session.getAttribute("codigoUsuario")+ "'"
                        + "WHERE CodCamp='"+ request.getParameter("CodCamp")+ "'";
                
                session.setAttribute("datos", listadoCampeon);
                s.execute(insertarCampeon);
                out.print(insertarCampeon);
                response.sendRedirect("listado.jsp");
            }

        %>

     


        <!-- Javascript Bootstrap V5 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </script>
    </body>
</html>