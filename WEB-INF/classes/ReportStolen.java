import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class ReportStolen extends HttpServlet{
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

        if (request.getParameter("adminAction").equals("stolen")) {
            // add to db
            try {
                // Execute a UPDATE statement
                PreparedStatement  stmt = con.prepareStatement("UPDATE PRODUCT_REGISTRATION SET STOLEN = 'Y' WHERE SERIAL_NUMBER = ?");
                stmt.setString(1,request.getParameter("num"));

                try {
                    stmt.executeUpdate();
                    out.println("success");
                } catch(Exception e) {

                }
            } catch(Exception e) {
                out.println("There was an issue adding an entry to the database: " + e.toString());
            }

    }
}
}
