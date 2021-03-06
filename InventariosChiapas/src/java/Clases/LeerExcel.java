/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

/**
 *
 * @author CEDIS NAY 1
 */
public class LeerExcel {

    ConectionDB con = new ConectionDB();

    public boolean leeExcel(String ruta, String arch) {
        String query = "";
        try {
            // TODO code application logic here
            //Ubicación del archivo XLS
            ruta = ruta + "Inventarios/";
            String archivo = ruta + arch;
            System.out.println(archivo);
            //Creamos un Workbook para cargar el XLS en memoria 
            Workbook workbook = Workbook.getWorkbook(new File(archivo));
            //Elegimos la primera hoja
            Sheet sheet = workbook.getSheet(0);
            //inicializo el objeto que leerá el valor de la celda
            Cell celdaCurso;
            //Este String guardará el valor de la celda
            String valorCeldaCurso;

            //Obtengo el número de filas ocupadas en la hoja
            int rows = sheet.getRows();
            //Obtengo el número de columnas ocupadas en la hoja
            int cols = sheet.getColumns();

            //Para efectos de ejemplo recorremos las columnas de cada fila
            try {
                con.conectar();
                query = "insert into inventarios values  ";
                for (int x = 1;
                        x < rows;
                        x++) {
                    query = query + "(";
                    for (int y = 0; y < cols; y++) {
                        //Obtenemos el valor de la celda de la columna Y y fila X
                        celdaCurso = sheet.getCell(y, x);
                        //Obtenemos el valor de la celda
                        valorCeldaCurso = celdaCurso.getContents();
                        if (y == cols - 1) {
                            query = query + "'" + valorCeldaCurso.toString() + "'";
                        } else {
                            query = query + "'" + valorCeldaCurso.toString() + "',";
                        }
                        //System.out.print(valorCeldaCurso + "\t");
                    }
                    if (x == rows - 1) {
                        query = query + ")";
                    } else {
                        query = query + "),";
                    }
                    //System.out.println(query);
                }
                query = query + ";";
                con.cierraConexion();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

            System.out.println(query);
            workbook.close();
        } catch (IOException e) {
        } catch (BiffException e) {
        } catch (IndexOutOfBoundsException e) {
        }
        try {
            con.conectar();
            con.ejecuta(query);
            con.cierraConexion();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }

}
