import java.util.*;

public class TextIO {

    private Scanner scan;

    public TextIO() {
        this.scan = new Scanner(System.in);
    }

    public void display(String msg) {
        System.out.println(msg);
    }
    
    public int[] calculateColumnWidth(String[][] results) {
        int[] rowWidths = new int[results.length];

        for (int i = 0; i < results.length; i++) {
            rowWidths[i] = largestAmount(results[i]);
        }
        return rowWidths;
    }
    
    private int largestAmount(String[] result) {
        int largest = Integer.MIN_VALUE;

        for (int i = 0; i < result.length; i++) {
            if (result[i].length() > largest) {
                largest = result[i].length();
            }
        }

        return largest;
    }

    public String formatReport(String[][] results, int padding, int[] columnWidths) {
        String report = "";
        int rowLength = results[0].length;
        int colLength = results.length;
        for (int i = 0; i < rowLength; i++) {
            for (int j = 0; j < colLength; j++) {
                String data = results[j][i];
                int columnWidth = columnWidths[j];
                report += String.format("%-" + (columnWidth + padding) + "s", data);
            }

            report += "\n";
        }
        return report;
    }
    
    public String prompt(String msg) {
        this.display(msg);
        return this.scan.nextLine();
    }
}