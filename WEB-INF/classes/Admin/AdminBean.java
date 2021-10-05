package Admin;
import java.io.*;
public class AdminBean implements Serializable {
   private String user;
   private String pass;

   public AdminBean() {
       user = "Username";
       pass = "Password";
   }
   public String getUser(){
      return user;
   }
   public void setUser(String user){
      this.user = user;
   }

   public String getPass(){
      return pass;
   }
   public void setPass(String pass){
      this.pass = pass;
   }
}
