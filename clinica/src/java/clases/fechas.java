/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Windows
 */
public class fechas {

    public String srfecha(Date fecha, int dias, int meses) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha);
        int coni = calendar.get(Calendar.DAY_OF_WEEK);
        if (coni == 2) {
            calendar.add(Calendar.DAY_OF_YEAR, 0);
        } else if (coni == 3) {
            calendar.add(Calendar.DAY_OF_YEAR, -1);
        } else if (coni == 4) {
            calendar.add(Calendar.DAY_OF_YEAR, -2);
        } else if (coni == 5) {
            calendar.add(Calendar.DAY_OF_YEAR, -3);
        } else if (coni == 6) {
            calendar.add(Calendar.DAY_OF_YEAR, -4);
        } else if (coni == 0) {
            calendar.add(Calendar.DAY_OF_YEAR, -5);
        } else if (coni == 1) {
            calendar.add(Calendar.DAY_OF_YEAR, -6);
        }
        calendar.add(Calendar.WEEK_OF_MONTH, meses);
        calendar.add(Calendar.DAY_OF_YEAR, dias);  // numero de días a añadir, o restar en caso de días<0
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        String nuevo = formato.format(calendar.getTime());
        return nuevo; // Devuelve el objeto Date con los nuevos días añadidos

    }

    public String coni(Date fecha, int dias, int meses) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha);
        int coni = calendar.get(Calendar.DAY_OF_WEEK);
        if (coni == 4) {
            calendar.add(Calendar.DAY_OF_YEAR, 0);
        } else if (coni == 5) {
            calendar.add(Calendar.DAY_OF_YEAR, -1);
        } else if (coni == 6) {
            calendar.add(Calendar.DAY_OF_YEAR, -2);
        } else if (coni == 0) {
            calendar.add(Calendar.DAY_OF_YEAR, -3);
        } else if (coni == 1) {
            calendar.add(Calendar.DAY_OF_YEAR, -4);
        } else if (coni == 2) {
            calendar.add(Calendar.DAY_OF_YEAR, -5);
        } else if (coni == 3) {
            calendar.add(Calendar.DAY_OF_YEAR, -6);
        }
        calendar.add(Calendar.WEEK_OF_MONTH, meses);
        calendar.add(Calendar.DAY_OF_YEAR, dias);  // numero de días a añadir, o restar en caso de días<0
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        String nuevo = formato.format(calendar.getTime());
        nuevo = Integer.toString(coni);
        return nuevo; // Devuelve el objeto Date con los nuevos días añadidos

    }

}
