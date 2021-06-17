public class ListingCommand extends ParsableCommand {

    private final String name;
    private final int min;
    private final int max;

    public ListingCommand(int min, int max) {
        this.name = "listing";
        this.min = min;
        this.max = max;
    }

    public String getName() {
        return name;
    }
    
    @Override
    public void run() {
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
