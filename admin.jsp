<%@ page import = "javax.servlet.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "Admin.AdminBean"%>
<jsp:useBean id="adminBean" class="Admin.AdminBean" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>KU Electronic Admin Control</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="js/adminFunc.js" charset="utf-8"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" id="brand">KU ELECTRONIC</a>
                <button class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#my-nav"
                        aria-controls="my-nav"
                        aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="my-nav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="index.html#home">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.html#product_registration" tabindex="-1" aria-disabled="true">Product Registration</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.html#warranty_claim" tabindex="-1" aria-disabled="true">Warranty Claim</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.html#firmware_downloads" tabindex="-1" aria-disabled="true">Firmware
                                Downloads</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin.jsp" tabindex="-1" aria-disabled="true">Admin Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <%
            if(request.getMethod().equals("GET")){
        %>
        <main>
            <section>
               <div class="container">
                 <form method="post" action="admin.jsp">
                    <div class="mb-3">
                        <label for="user" class="form-label"><jsp:getProperty name="adminBean" property="user"/></label>
                        <input type="text" class="form-control" id="user" name="user">
                    </div>
                    <div class="mb-3">
                        <label for="pass" class="form-label"><jsp:getProperty name="adminBean" property="pass"/></label>
                        <input type="password" class="form-control" id="pass" name="pass">
                    </div>
                    <%-- use a hidden form element to know if we login --%>
                    <input type='hidden' name='login' maxlength='25' value='true'/>
                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
               </div>
            </section>
        </main>

        <%
            }
            if(request.getMethod().equals("POST")){
                // check if we are loging in
                if (request.getParameter("login") != null) {
                    // connect to db
                    // maybe get the values from a text file in the war?
                    String connectionUser = "MOORED";
                    String connectionPass = "MOORED";
                    Connection con = null;
                    try {
                        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
                        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", connectionUser,connectionPass);// find the vars at top for easier access
                    } catch(Exception e) {
                        out.println("There was an issue connecting to the database: " + e.toString());
                    }

                    // Execute a SELECT statement
                    PreparedStatement stmt = con.prepareStatement("SELECT * FROM USERS WHERE USERNAME=? AND PASSWORD=?");
                    stmt.setString(1,request.getParameter("user"));
                    stmt.setString(2,request.getParameter("pass"));

                    int i=stmt.executeUpdate();
                    if (i > 0){
                        // they are valid!
                        //remove all html in the work area, and load the admin controls
                        //PrintWriter out = response.getWriter();
                        ResultSet rs = stmt.executeQuery();
                        rs.next();
                        out.println("Welcome, " + rs.getString(3));

                %>


                <main>
                    <section>
                       <div class="container">
                         <button class="btn btn-danger" onclick="drop();">Drop Database Tables</button><p id="dropText"></p>
                         <button class="btn btn-success" onclick="create();">Create Database Tables</button><p id="createText"></p>
                         <button class="btn btn-info" onclick="getUsers();">Get Admins from Users Table</button><p></p>
                         <button class="btn btn-info" onclick="getProducts();">Get rows from Proucts table</button><p></p>
                         <div class="mb-3">
                             <label for="usersText" class="form-label">Admins in User Table</label>
                             <textarea class="form-control" name="name" rows="8" cols="80" id="usersText" readonly></textarea>
                         </div>
                         <div class="mb-3">
                             <label for="productsText" class="form-label">Rows in Products Table</label>
                             <textarea class="form-control" name="name" rows="8" cols="80" id="productsText" readonly></textarea>
                         </div>
                     </div>
                    </section>


                </main>






                <%

                    }else{
                        // they are not valid, we need to display some error message
        %>

            <script>
                alert("That is not a correct username or password. Please click the back button on the browser and try again!");
            </script>

        <%
                    }

                }// end login if

            }// end post
            %>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
