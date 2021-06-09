package com.company;

import java.sql.SQLException;
import java.util.Arrays;

public class REC {
    private TextIO textView;
    private DataSource source;

    public REC() {
        textView = new TextIO();
        try {
            source = DataSource.getInstance();
        } catch (SQLException e) {
            textView.display("Error with datasource " + e);
        }
    }

    void start() {
        try {
            String[][] dataset = source.executeQuery("SELECT Listing_ID, Num_Bedrooms, Num_Baths, City, State, Price FROM PROPERTIES WHERE PRICE BETWEEN " + 299000 + " AND " + 749000 + " ORDER BY PRICE");
            int[] columnWidths = textView.calculateColumnWidth(dataset);
//            for (int i = 0; i < dataset.length; i++) {
//                System.out.println(Arrays.toString(dataset[i]));
//            }
            String report = textView.formatReport(dataset, columnWidths);
//            textView.display(report);
            source.close();
        } catch (SQLException e) {
            System.out.println("Error " + e);
        }
    }
}
