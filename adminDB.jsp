<%-- Authors: Ram, David, Troy
Date: 10-8-2021 --%>
<%@ page import = "javax.servlet.*"%>
<%@ page import = "javax.servlet.http.*"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.sql.*"%>
<%
String connectionUser = "MOORED";
String connectionPass = "MOORED";
Connection con = null;
try {
    DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", connectionUser,connectionPass);// find the vars at top for easier access
} catch(Exception e) {
    out.println("There was an issue connecting to the database: " + e.toString());
}
if(request.getMethod().equals("POST")){

    // drop tables
    if (request.getParameter("adminAction").equals("drop")) {
        PreparedStatement tbl = null;
        tbl = con.prepareStatement("DROP TABLE USERS");
        try {
            tbl.executeUpdate();
        } catch(Exception e) {

        }
        tbl = con.prepareStatement("DROP TABLE PRODUCT_REGISTRATION");
        try {
            tbl.executeUpdate();
        } catch(Exception e) {

        }

        tbl = con.prepareStatement("DROP SEQUENCE \"USERS_SEQ\"");
        try {
            tbl.executeUpdate();
        } catch(Exception e) {

        }

        tbl = con.prepareStatement("DROP TRIGGER \"BI_USERS\"");
        try {
            tbl.executeUpdate();
        } catch(Exception e) {

        }

        out.println("tables dropped");
    } // end drop


    // create tables, and insert Rows
    if (request.getParameter("adminAction").equals("create")) {
        PreparedStatement tbl = null;
        tbl = con.prepareStatement("CREATE table USERS (ID NUMBER(9) NOT NULL, EMAIL VARCHAR2(500) NOT NULL, USERNAME VARCHAR2(50) NOT NULL, PASSWORD VARCHAR2(50) NOT NULL, constraint USERS_PK primary key (ID))");
        try {
            tbl.executeUpdate();
        } catch(Exception e) {

        }


        tbl = con.prepareStatement("CREATE sequence \"USERS_SEQ\"");
        try {
            tbl.executeUpdate();
        } catch(Exception e) {

        }

        Statement stm = con.createStatement();
        try {
            stm.executeQuery("CREATE trigger \"BI_USERS\"before insert on \"USERS\" for each row begin if :NEW.\"ID\" is null then select \"USERS_SEQ\".nextval into :NEW.\"ID\" from dual; end if; end;");
        } catch(Exception e) {

        }


        stm.executeQuery("INSERT INTO USERS VALUES ('','tstreeter@kuElectronic.com','tstreeter','password123')");


        stm.executeQuery("INSERT INTO USERS VALUES ('','dmoore@kuElectronic.com','dmoore','123password')");


        stm.executeQuery("INSERT INTO USERS VALUES ('','rchapagai@kuElectronic.com','rchapagia','123password321')");


        stm.executeQuery("INSERT INTO USERS VALUES ('','dosier@kuElectronic.com','dosier','mypassword123')");


        stm.executeQuery("INSERT INTO USERS VALUES ('','ssampson@kuElectronic.com','ssampson','pass123word')");



        tbl = con.prepareStatement("CREATE table PRODUCT_REGISTRATION (EMAIL VARCHAR2(60) NOT NULL,FIRST_NAME VARCHAR2(30) NOT NULL,LAST_NAME VARCHAR2(30) NOT NULL,PRODUCT_NAME VARCHAR2(20) NOT NULL,PRODUCT_MODEL VARCHAR2(8)  NOT NULL,SERIAL_NUMBER  VARCHAR2(10) NOT NULL,PURCHASED_DATE VARCHAR2(10),STOLEN VARCHAR2(1) NOT NULL, constraint PRODUCT_REGISTRATION_PK primary key(SERIAL_NUMBER))");
        try {
            tbl.executeUpdate();
        } catch(Exception e) {

        }

        stm.executeQuery("INSERT INTO PRODUCT_REGISTRATION VALUES('tstreeter@kuElectronic.com','Troy','Streeter','SpeedMinder','SM500','1234B6789C','01-10-2020','N')");

        stm.executeQuery("INSERT INTO PRODUCT_REGISTRATION VALUES('dmoore@kuElectronic.com','David','Moore','SpeedMinder','SM5001','2345G7890I','12-08-2020','N')");

        stm.executeQuery("INSERT INTO PRODUCT_REGISTRATION VALUES('rchapagai@kuElectronic.com','Ram','Chapagai','SpeedMinder','SM500','3456J8765L','08-14-2020','N')");

        stm.executeQuery("INSERT INTO PRODUCT_REGISTRATION VALUES('dosier@kuElectronic.com','Darin','Osier','SpeedMinder','SM5002','5678U7654Y','09-16-2020','N')");

        stm.executeQuery("INSERT INTO PRODUCT_REGISTRATION VALUES('ssampson@kuElectronic.com','Sue','Sampson','SpeedMinder','SM500','3456T6543R','10-04-2020','N')");


        stm.close();
        out.println("tables created");
    } // end create

    if (request.getParameter("adminAction").equals("getUsers")) {
        Statement stm = con.createStatement();
        String output = "";
        try {
            ResultSet rs = stm.executeQuery("SELECT * FROM USERS");

            while (rs.next()) {
                output += rs.getString(1) + " " + rs.getString(2)+ " " + rs.getString(3)+ " " + rs.getString(4) + "\n";
            }
        } catch(Exception e) {

        }


        out.println(output);
    } // end getUsers
    // get select from products
    if (request.getParameter("adminAction").equals("getProducts")) {
        Statement stm = con.createStatement();
        String output = "";
        try {
            ResultSet rs = stm.executeQuery("SELECT * FROM PRODUCT_REGISTRATION");

            while (rs.next()) {
                output += rs.getString(1) + " " + rs.getString(2)+ " " + rs.getString(3)+ " " + rs.getString(4)+ " " + rs.getString(5)+ " " + rs.getString(6)+ " " + rs.getString(7)+ " " + rs.getString(8) + "\n";
            }
        } catch(Exception e) {

        }


        out.println(output);
    } // end getUsers
}


%>
