import java.sql.SQLException;

public class REC {
    private final TextIO textView;
    private final ArgParser parser;

    public REC() {
        this.textView = new TextIO();
        parser = new ArgParser();
        parser.addCommand("help", 0);
        parser.addCommand("quit", 0);
        parser.addCommand("rpt", 3);
        DataSource.getInstance();
    }

    void start() {
        while (true) {
            String userCommand = textView.prompt("Please enter a command.");
            String command = parser.command(userCommand);
            switch (command) {
                case "help":
                    parser.listCommands();
                    break;
                case "quit":
                    quitCommand();
                    break;
                case "rpt":
                    reportCommand(userCommand);
                    break;
                default:
                    System.out.println();
                    System.out.println("Command not found");
            }
        }
    }

    public void reportCommand(String userCommand) {
        String[] args = parser.args(userCommand);
        String subcommand = args[1];
        switch (subcommand) {
            case "listing":
                listings(args);
                break;
            default: break;
        }
    }

    void quitCommand() {
        System.exit(0);
    }

    void listings(String[] args) {
        String min = args[2];
        String max = args[3];
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