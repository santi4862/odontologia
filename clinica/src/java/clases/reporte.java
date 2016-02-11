/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Windows
 */
public class reporte {

    
    public void abrirpdf(HttpServletRequest request, HttpServletResponse response, ServletContext application, String ruta) throws IOException {
        File documento = new File(application.getRealPath(ruta));
        FileInputStream archivo = new FileInputStream(documento.getPath());
        int tamanoInput = archivo.available();
        byte[] datosPDF = new byte[tamanoInput];
        archivo.read(datosPDF, 0, tamanoInput);
        response.setHeader("Content-disposition", "inline; filename=instalacion_tomcat.pdf");
        response.setContentType("application/pdf");
        response.setContentLength(tamanoInput);
        response.getOutputStream().write(datosPDF);
        archivo.close();
    }
}
