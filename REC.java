import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

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

    void summary() {
        try {
            String query = "SELECT State, Count(*) AS Count, MIN(PRICE) AS Low, MAX(PRICE) AS High, ROUND(AVG(PRICE)) AS Average FROM active_properties GROUP BY STATE ORDER BY STATE";
            ArrayList<DAO> daos = DataSource.getInstance().executeDAO(query);
            String[][] dataset = datasetFromDao(daos);
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

    private String[] regionSummary(ArrayList<DAO> daos) {
        String count = String.valueOf(totalCount(daos));
        String min = String.valueOf(minPrice(daos));
        String max = String.valueOf(maxPrice(daos));

        String[] regionSummary = new String[]{"", count, min, max, ""};
        return regionSummary;
    }

    private int totalCount(ArrayList<DAO> daos) {
        int totalCount = 0;

        for (int i = 0; i < daos.size(); i++) {
            totalCount += daos.get(i).getCount();
        }
        return totalCount;
    }

    private int minPrice(ArrayList<DAO> daos) {
        int min = Integer.MAX_VALUE;

        for (int i = 0; i < daos.size(); i++) {
            if (daos.get(i).getMin() < min) {
                min = daos.get(i).getMin();
            }
        }

        return min;
    }

    private int maxPrice(ArrayList<DAO> daos) {
        int max = Integer.MIN_VALUE;

        for (int i = 0; i < daos.size(); i++) {
            if (daos.get(i).getMax() > max) {
                max = daos.get(i).getMax();
            }
        }

        return max;
    }

    private String[][] datasetFromDao(ArrayList<DAO> daos) {
        String[] columns = new String[] { "State", "Count", "Low", "High", "Average" };
        String[][] dataset = new String[daos.size() + 2][];

        dataset[0] = columns;


        for (int i = 0; i < daos.size(); i++) {
            DAO dao = daos.get(i);
            String state = dao.getState();
            String count = String.valueOf(dao.getCount());
            String min = String.valueOf(dao.getMin());
            String max = String.valueOf(dao.getMax());
            String avg = String.valueOf(dao.getAvg());

            String[] rowResult = new String[]{state, count, min, max, avg};
            dataset[i + 1] = rowResult;
        }

        dataset[daos.size() + 1] = regionSummary(daos);
        return dataset;
    }
}