package com.company;

import java.util.*;

/**
 *
 */
public class TextIO {

    private Scanner scan;

    public TextIO()
    {
        this.scan = new Scanner(System.in);
    }

    /**
     * Writes a message to the console.
     *
     * @param msg The message to be displayed to the console.
     */
    public void display(String msg)
    {
        System.out.println(msg);
    }

    /**
     * Used to calculate column width from data returned from the query
     * Used to format output to the console.
     *
     * @param results Dataset that is used to find the column widths
     * @return Array of largest values from the dataset.
     */
    public int[] calculateColumnWidth(String[][] results) {
        int[] rowWidths = new int[results.length];

        for (int i = 0; i < results.length; i++) {
            rowWidths[i] = largestAmount(results[i]);
        }
        return rowWidths;
    }

    /**
     * Used to determine what the largest string's character count.
     *
     * @param result Values to determine what is the largest string character count.
     * @return The largest string's character count
     */
    private int largestAmount(String[] result) {
        int largest = Integer.MIN_VALUE;

        for (int i = 0; i < result.length; i++) {
            if (result[i].length() > largest) {
                largest = result[i].length();
            }
        }

        return largest;
    }

    public String formatReport(String[][] results, int[] columnWidths) {
        String report = "";
        int rowLength = results[0].length;
        int colLength = results.length;
        for (int i = 0; i < rowLength; i++) {
            for (int j = 0; j < colLength; j++) {
                report += results[j][i];
            }

            report += "\n";
        }

        System.out.println(report);
        return report;
    }

    /**
     * Used to prompt a message to the user then get the user's response.
     *
     * @param msg Message to be displayed
     * @return Input from user
     */
    public String prompt(String msg)
    {
        this.display(msg);
        return this.scan.next();
    }
}
