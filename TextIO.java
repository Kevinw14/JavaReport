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
        int[] rowWidths = new int[results[0].length];
        for (int i = 0; i < results[0].length; i++) {
            int largestCharacterCount = Integer.MIN_VALUE;


            for (int j = 0; j < results[i].length; j++) {
                int characterCount = results[j][i].length();
                if (characterCount > largestCharacterCount) {
                    largestCharacterCount = characterCount;
                }    
            }
            
            rowWidths[i] = largestCharacterCount;
        }

        return rowWidths;
    }
    
    public String formatReport(String[][] results, int padding, int[] columnWidths) {
        String report = "";
        for (int i = 0; i < results.length; i++) {
            for (int j = 0; j < results[0].length; j++) {
                String data = results[i][j];
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