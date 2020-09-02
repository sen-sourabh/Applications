import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.swing.JOptionPane;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Sourabh
 */
public class SendEmail
{
    public static boolean sendMail(String name, String email, String password, String category, String task) throws MessagingException{
//      String to = "sourabhsen9696@gmail.com";//change accordingly
//      String from = "sourabhsen201313@gmail.com";//change accordingly
//      String host = "localhost";//or IP address

         //Get the session object
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        
        String accountGmail = "sourabhsen201313@gmail.com";
        String accountPassword = "Nbe!9969";

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
              return new PasswordAuthentication(accountGmail, accountPassword);
            }
        });
        Message message = prepareMessage(session, accountGmail, email, name, password, category, task);
        Transport.send(message);
        return true;
    }
 
    private static Message prepareMessage(Session session, String accountGmail, String email, String name, String password, String category, String task) {
        //compose the message
      try{
         Message message = new MimeMessage(session);
         message.setFrom(new InternetAddress(accountGmail));
         message.addRecipient(Message.RecipientType.TO,new InternetAddress(email));
         
         if("removed".equals(task)) {
            message.setSubject("Your account has been deleted by Admin from Student Registration System");
             message.setText("Hello, These are the details from Student Registration System : \nName : " + name + "\nEmail : " + email + "\nCategory : " + category);
         }else if("pchanged".equals(task)) {
             message.setSubject("Change password success in Student Registration System");
             message.setText("Hello, These are the details from Student Registration System : \nName : " + name + "\nEmail : " + email + "\nPassword : " + password + "\nCategory : " + category);
         }else if("updated".equals(task)) {
             message.setSubject("Update account details of Student Registration System");
             message.setText("Hello, These are the details from Student Registration System : \nName : " + name + "\nEmail : " + email + "\nCategory : " + category);
         }else {
             message.setSubject("Thank you for register with Student Registration System");
             message.setText("Hello, These are the details from Student Registration System : \nName : " + name + "\nEmail : " + email + "\nPassword : " + password + "\nCategory : " + category);
         }
         return message;
      }catch (MessagingException mex) {
          JOptionPane.showMessageDialog(null,mex.getMessage());
      }
        return null;
    }
}