<%-- 
    Document   : consulta.jsp
    Created on : 21 feb 2022, 19:41:15
    Author     : Usuario
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta tus campeones</title>
    <link rel="stylesheet" href="styles/login.css">
    <link rel="shortcut icon" href="./images/lolcrud.ico" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
</head>
<body class="vh-100">
    
     <%request.setCharacterEncoding("UTF-8");%>
     
     <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/lolcrud?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
            Statement s = conexion.createStatement();
            Statement u = conexion.createStatement();
            

            ResultSet listadoCampeones = s.executeQuery("SELECT * FROM listado_campeon");
     %>
     
     
    <div id="wrapper" class="container vh-100 bg-light">
        <h1 class="text-center py-5">Estos son los campeones que has jugado</h1>
        <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
            <thead>
            <tr>
                <th scope="col">Nombre Campeón</th>
                <th scope="col">Línea del Campeón</th>
                <th scope="col">Rol habitual</th>
                <th scope="col">Descripción del campeón</th>
                <th scope="col">Usuarios que ya lo han jugado</th>
                <th scope="col">Editar</th>
                <th scope="col">Borrar</th>
            </tr>
            </thead>
            <tbody>
           <%  
                    while (listadoCampeones.next()) {  
           %>

                    <tr>
                        <td class="col-3"> <%= listadoCampeones.getString("NomCamp")%></td>
                        <td class="col-3"> <%= listadoCampeones.getString("LineaCamp")%></td> 
                        <td class="col-3"> <%= listadoCampeones.getString("RolHabCamp")%></td>
                        <td class="col-3"> <%= listadoCampeones.getString("DescCamp")%></td>
                        <td class="col-3"> <%= listadoCampeones.getString("CodUsu")%></td>
                        <td class="col-1"><a href="editar.jsp?id=<%=listadoCampeones.getString("CodCamp")%>" class="col-1 bi bi-pencil-square rowWithImage" data-bs-toggle="modal" data-bs-target="#modalEditar"></a></td> 
                        <td class="col-1"><a href="eliminar.jsp?id=<%=listadoCampeones.getString("CodCamp")%>" class=" bi-trash3-fill rowWithImage text-danger" onclick="confirm('¿Estás seguro de que quieres eliminar un campeon?')"></a></td>
                    </tr>
            <%
                }
            %>
            </tbody>
          </table>
        </div>
        <a href="anadirCampeon.jsp" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAnadido">Insertar nuevo campeón</a>
        
        <!-- Modal para añadir campeones -->
<div class="modal fade" id="modalAnadido" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalAnadido">Nuevo campeón</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body container">
          <form action="anadirCampeon.jsp">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="NomCamp">Nombre Campeón</label>
                                    <input class="form-control" type="text" name="NomCamp" required/><br>
                                </div>
                                <div class="col-md-6">
                                    <label for="LineaCamp">Linea del Campeón</label>
                                    <input class="form-control" type="text" name="LineaCamp" required/></br>
                                </div>
                                <div class="col-md-6">
                                    <label for="RolHabCamp">Rol habitual del Campeón</label>
                                    <input class="form-control" type="text" name="RolHabCamp" required/></br>
                                </div>
                                <div class="col-md-6">
                                    <label for="DescCamp">Descripción del Campeón</label>
                                    <input class="form-control" type="text" name="DescCamp" required/></br>
                                </div>
                                <div class="col-md-6">
                                    <label for="CodUsu">Conocidos que lo han jugado</label>
                                    <input class="form-control" type="text" name="CodUsu"/></br>
                                </div>
                            </div>
                    </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <input class="btn btn-primary" type="submit" value="Aceptar">
                                </div>
                            </div>
                        </form>
      </div>
    </div>
  </div>
</div>
            
            
            
            <!-- Modal para editar campeones -->
<div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalEditar">Nuevo campeón</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body container">
          <form action="editar.jsp">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="NomCampEdi">Nuevo nombre</label>
                                    <input class="form-control" type="text" name="NomCampEdi" required/><br>
                                </div>
                                <div class="col-md-6">
                                    <label for="LineaCampEdi">Nueva línea</label>
                                    <input class="form-control" type="text" name="LineaCampEdi" required/></br>
                                </div>
                                <div class="col-md-6">
                                    <label for="RolHabCampEdi">Nuevo rol habitual</label>
                                    <input class="form-control" type="text" name="RolHabCampEdi" required/></br>
                                </div>
                                <div class="col-md-6">
                                    <label for="DescCampEdi">Nueva descripción</label>
                                    <input class="form-control" type="text" name="DescCampEdi" required/></br>
                                </div>
                                <div class="col-md-6">
                                    <input class="form-control" type="text" name="CodUsuEdi"/></br>
                                </div>
                            </div>
                    </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <button class="btn btn-primary" type="submit" value="Aceptar">Editar</button>
                                </div>
                            </div>
                        </form>
      </div>
    </div>
  </div>
</div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>
