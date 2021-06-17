import java.sql.SQLException;

public class REC {
    private final TextIO textView;
    private final CommandParser parser;

    public REC() {
        this.textView = new TextIO();
        parser = new CommandParser();
        DataSource.getInstance();
    }

    void start() {
        String userCommand = textView.prompt("Please enter a command");
        String command = parser.parseCommand(userCommand);

        switch (command) {
            case "help":
                helpCommand();
                break;
            case "quit":
                quitCommand();
                break;
            case "rpt":
                reportCommand(userCommand);
                break;
            default:
                System.out.println();
                System.out.println("Invalid command. list commands by typing \"help\"");
        }
        System.out.println();
    }

    void helpCommand() {
        System.out.println();
        System.out.println("help");
        System.out.println("quit");
        System.out.println("rpt [listing <min> <max>], [summary]");
    }

    void quitCommand() {
        System.exit(0);
    }

    void reportCommand(String userCommand) {
        String[] args = parser.parseArgs(userCommand);
        switch (args[0]) {
            case "listing":
                if (args.length == 3) {
                    String min = args[1];
                    String max = args[2];
                    listing(min, max);
                }
                break;

            case "summary":
                summary();
                break;
            default:
                System.out.println("Invalid command. list commands by typing \"help\"");
        }
    }

    void listing(String min, String max) {
        try {
            String query = "SELECT Listing_ID, Num_Bedrooms, Num_Baths, City, State,"
                    + "Price FROM PROPERTIES WHERE PRICE BETWEEN " + min + " AND " + max + " ORDER BY PRICE";
            DOA dataset = DataSource.getInstance().executeQuery(query);
            int[] columnWidths = textView.calculateColumnWidth(dataset);
            String report = textView.formatReport(dataset, 10, columnWidths);
            textView.display(report);
            quitCommand();
        } catch (SQLException e) {
            System.out.println("Error " + e);
        } finally {
            DataSource.getInstance().close();
        }
    }

    void summary() {
        try {
            String query = "SELECT STATE, Count(*) AS COUNT, MIN(PRICE) AS LOW, MAX(PRICE) AS HIGH, ROUND(AVG(PRICE)) AS AVERAGE FROM PROPERTIES GROUP BY STATE";
            String[][] dataset = DataSource.getInstance().executeQuery(query);
            int[] columnWidths = textView.calculateColumnWidth(dataset);
            String report = textView.formatReport(dataset, 10, columnWidths);
            textView.display(report);
            quitCommand();
        } catch (SQLException e) {
            System.out.println("Error getting data: " + e.getLocalizedMessage());
        } finally {
            DataSource.getInstance().close();
        }
    }
}