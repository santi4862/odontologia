/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Session;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.InternetAddress;
import javax.swing.JOptionPane;

/**
 *
 * @author Windows
 */
public class MailSender {

    private String Username = "";
    private String PassWord = "";
    String Mensage = "";
    String To = "";
    String Subject = "Confirme su activacion de cuenta";
    conexion con = new conexion();

    public MailSender() {
        try {
            con.conectar();
            ResultSet rs = con.consulta("select * from empresa where id='Od1'");
            while (rs.next()) {
                this.Username = rs.getString("correoi");
                this.PassWord = rs.getString("clavecor");
            }
            con.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(MailSender.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void mensaje(String mensaje) {
        this.Mensage = mensaje;
    }

    public void para(String para) {
        this.To = para;
    }

    public void asunto(String asunto) {
        this.Subject = asunto;
    }

    public void SendMail() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Username, PassWord);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(To));
            message.setSubject(Subject);
            message.setText(Mensage);

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void enviarpdf(String archivo, String nombre, String asunto) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Username, PassWord);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(To));
            BodyPart adjunto = new MimeBodyPart();
            BodyPart texto = new MimeBodyPart();
            texto.setText(asunto);
            adjunto.setDataHandler(new DataHandler(new FileDataSource(archivo)));
            adjunto.setFileName(nombre);
            MimeMultipart multiParte = new MimeMultipart();
            multiParte.addBodyPart(adjunto);
            multiParte.addBodyPart(texto);
            message.setSubject(Subject);
            message.setText(Mensage);
            message.setContent(multiParte);
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void enviarpdfxml(String archivopdf, String nombrepdf, String archivoxml, String nombrexml, String asunto) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Username, PassWord);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(To));
            BodyPart adjuntopdf = new MimeBodyPart();
            BodyPart adjuntoxml = new MimeBodyPart();
            BodyPart texto = new MimeBodyPart();
            texto.setText(asunto);
            adjuntopdf.setDataHandler(new DataHandler(new FileDataSource(archivopdf)));
            adjuntopdf.setFileName(nombrepdf);
            adjuntoxml.setDataHandler(new DataHandler(new FileDataSource(archivoxml)));
            adjuntoxml.setFileName(nombrexml);
            MimeMultipart multiParte = new MimeMultipart();
            multiParte.addBodyPart(adjuntopdf);
            multiParte.addBodyPart(adjuntoxml);
            multiParte.addBodyPart(texto);
            message.setSubject(Subject);
            message.setText(Mensage);
            message.setContent(multiParte);
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
