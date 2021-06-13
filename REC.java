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
        while (true) {
            String userCommand = textView.prompt("Please enter a command");
            String command = parser.parseCommand(userCommand);
            String[] args = parser.parseArgs(userCommand);

            switch (command) {
                case "help":
                    if (args.length == 0)
                        helpCommand();
                    break;
                case "quit":
                    if (args.length == 0)
                        quitCommand();
                    break;
                case "rpt":
                    if (args.length > 0)
                        reportCommand(userCommand);
                    else {
                        System.out.println();
                        System.out.println("Not enough arguments. [listing <min> <max>]");
                    }
                    break;
                default:
                    System.out.println();
                    System.out.println("Invalid command. list commands by typing \"help\"");
            }
            System.out.println();
        }
    }

    void helpCommand() {
        System.out.println();
        System.out.println("help");
        System.out.println("quit");
        System.out.println("rpt [listing <min> <max>]");
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
                } else {
                    System.out.println();
                    System.out.println("Not enough arguments <min> <max>");
                }
                break;

            default:
                System.out.println();
                System.out.println("Invalid Command");
        }
    }

    void listing(String min, String max) {
        try {
            String query = "SELECT Listing_ID, Num_Bedrooms, Num_Baths, City, State, Price FROM PROPERTIES WHERE PRICE BETWEEN "
                    + min + " AND " + max + " ORDER BY PRICE";
            String[][] dataset = DataSource.getInstance().executeQuery(query);
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

}