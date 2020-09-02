import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.swing.JOptionPane;
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
            message.setSubject("Your account has been deleted by Admin from EStore");
             message.setText("Hello, These are the details from EStore : \nName : " + name + "\nEmail : " + email + "\nPassword : " + password + "\nCategory : " + category);
         }else if("pchanged".equals(task)) {
             message.setSubject("Change password success in EStore");
             message.setText("Hello, These are the details from EStore : \nName : " + name + "\nEmail : " + email + "\nPassword : " + password + "\nCategory : " + category);
         }else if("updated".equals(task)) {
             message.setSubject("Update account details of EStore");
             message.setText("Hello, These are the details from EStore : \nName : " + name + "\nEmail : " + email + "\nPassword : " + password + "\nCategory : " + category);
         }else if("Subscription".equals(task)) {
             message.setSubject("Subscription on EStore");
             message.setText("Hello, These are the details from EStore : \nName : " + name + "\nEmail : " + email + "\nPassword : " + password + "\nCategory : " + category);
         }else {
             message.setSubject("Thank you for register with EStore");
             message.setText("Hello, These are the details from EStore : \nName : " + name + "\nEmail : " + email + "\nPassword : " + password + "\nCategory : " + category);
         }
         return message;
      }catch (MessagingException mex) {
          JOptionPane.showMessageDialog(null,mex.getMessage());
      }
        return null;
    }
}