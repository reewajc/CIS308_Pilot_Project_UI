// Authors: Ram, David, Troy
// Date: 10-8-2021
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class RegisterProuctServlet extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{


        String connectionUser = "MOORED";
        String connectionPass = "MOORED";

        PrintWriter out = response.getWriter();
        Connection con = null;
        // connect to db
        try {
            DriverManager.registerDriver (new oracle.jdbc.OracleDriver());
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", connectionUser,connectionPass);// find the vars at top for easier access

        } catch(Exception e) {
            out.println("There was an issue connecting to the database: " + e.toString());
        }

        if (request.getParameter("adminAction").equals("register")) {
            // add to db
            try {
                // Execute a UPDATE statement
                PreparedStatement  stmt = con.prepareStatement("INSERT INTO PRODUCT_REGISTRATION VALUES(?,?,?,?,?,?,?,'N')");
                stmt.setString(1,request.getParameter("email"));
                stmt.setString(2,request.getParameter("first"));
                stmt.setString(3,request.getParameter("last"));
                stmt.setString(4,request.getParameter("item"));
                stmt.setString(5,request.getParameter("model"));
                stmt.setString(6,request.getParameter("num"));
                stmt.setString(7,request.getParameter("date"));

                try {
                    stmt.executeUpdate();
                    out.println("success");
                } catch(Exception e) {
                    out.println("fail: " + e);
                }
            } catch(Exception e) {
                out.println("There was an issue adding an entry to the database: " + e.toString());
            }
    }// end of register
}// end of post
}// end of class
