import java.sql.SQLException;

public class REC {
    private final TextIO textView;
    private final ArgParser parser;

    public REC() {
        this.textView = new TextIO();
        parser = new ArgParser();
        ParsableCommand quitCommand = new QuitCommand();
        parser.addCommand(quitCommand);
        DataSource.getInstance();
    }

    void start() {
        String userCommand = textView.prompt("Please enter a command.");
        parser.parse(userCommand);
    }

    // public void reportCommand(String userCommand) {
    //     String[] args = parser.args(userCommand);
    //     String subcommand = args[1];
    //     switch (subcommand) {
    //         case "listing":
    //             listings(args);
    //             break;
    //         default:
    //             break;
    //     }
    // }

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
        } catch (SQLException e) {
            System.out.println("Error " + e);
        } finally {
            DataSource.getInstance().close();
        }
    }

}