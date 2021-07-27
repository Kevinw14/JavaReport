import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class DataSource {

    private static DataSource obj;
    private Connection conn;

    private DataSource() throws SQLException {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        conn = DriverManager.getConnection("jdbc:oracle:thin:@Worf.radford.edu:1521:itec3", "kwood3",
                "fykfep-qitMa3-hegwyj");
    }

    static DataSource getInstance() {
        if (obj == null)
            try {
                obj = new DataSource();
            } catch (SQLException e) {
                System.out.println("Error connecting to database " + e.getLocalizedMessage());
            }
        return obj;
    }

    private int getRowCount(ResultSet results) throws SQLException {
        results.last();
        int count = results.getRow();
        results.beforeFirst();
        return count;
    }

    private String[] getColumnNames(ResultSetMetaData metadata) throws SQLException {
        int columnCount = metadata.getColumnCount();
        String[] columnResults = new String[columnCount];

        for (int i = 0; i < columnCount; i++) {
            columnResults[i] = metadata.getColumnName(i + 1);
        }
        return columnResults;
    }

    private String[] getRow(ResultSet results, ResultSetMetaData metadata) throws SQLException {
        int columnCount = metadata.getColumnCount();
        String[] columnResults = new String[columnCount];

        for (int i = 0; i < columnCount; i++) {
            String data = results.getString(i + 1);
            columnResults[i] = data;
        }
        return columnResults;
    }

    public String[][] executeQuery(String query) throws SQLException {
        Statement statement = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet results = statement.executeQuery(query);
        ResultSetMetaData metadata = results.getMetaData();

        int rowCount = getRowCount(results);
        String[][] dataset = new String[rowCount + 1][];
        dataset[0] = getColumnNames(metadata);

        while (results.next()) {
            int row = results.getRow();
            String[] columnResults = getRow(results, metadata);
            dataset[row] = columnResults;
        }

        return dataset;
    }

    public ArrayList<DAO> executeDAO(String query) throws SQLException {
        Statement statement = conn.createStatement();
        ResultSet results = statement.executeQuery(query);
        ArrayList<DAO> daos = new ArrayList<>();

        while (results.next()) {
            String state = results.getString("State");
            int count = results.getInt("Count");
            int min = results.getInt("Low");
            int max = results.getInt("High");
            int avg = results.getInt("Average");

            DAO dao = new DAO(state, count, min, max, avg);
            daos.add(dao);
        }

        return daos;
    }

    public void executeTrade(int offer1, int offer2) throws SQLException {

        try {
            conn.setAutoCommit(false);
            CallableStatement offer1Purchase = conn.prepareCall("{call purchase(?)}");
            CallableStatement offer2Purchase = conn.prepareCall("{call purchase(?)}");
            
            offer1Purchase.setInt(1, offer1);
            offer2Purchase.setInt(1, offer2);

            offer1Purchase.execute();
            offer2Purchase.execute();

            conn.commit();
            System.out.println("Trade successful");
        } catch (SQLException e) {
            System.out.println("Error occurred during the trade " + e);
            conn.rollback();
        } finally {
            conn.setAutoCommit(true);
        }
    }

    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error closing connection " + e.getLocalizedMessage());
        }
    }
}