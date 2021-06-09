package com.company;

import java.sql.*;

/**
 *
 */
public class DataSource {

    private static DataSource obj;
    private Connection conn;

    private DataSource() throws SQLException {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        conn = DriverManager.getConnection("jdbc:oracle:thin:@Worf.radford.edu:1521:itec3", "kwood3", "fykfep-qitMa3-hegwyj");
    }

    static DataSource getInstance() throws SQLException {
        if (obj == null)
            obj = new DataSource();
        return obj;
    }

    /**
     * Executes query passed in and appended to a 2D array along with the column
     * header names.
     *
     * @param query Query to be executed
     * @return 2D array of the column headers and data returned by the query.
     * @throws SQLException Thrown if problem occurs during request for data.
     */
    public String[][] executeQuery(String query) throws SQLException {
        Statement statement = conn.createStatement( ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet results = statement.executeQuery(query);
        ResultSetMetaData metaData = results.getMetaData();
        String[][] dataset = new String[metaData.getColumnCount()][];

        for (int i = 1; i <= metaData.getColumnCount(); i++) {
            int count = getRowCount(results);
            String[] columnDataset = new String[count + 1];
            String columnName = metaData.getColumnName(i);
            columnDataset[0] = columnName;

            while (results.next()) {
                int row = results.getRow();
                String value = results.getString(columnName);
                columnDataset[row] = value;
            }

            dataset[i - 1] = columnDataset;
        }
        return dataset;
    }

    /**
     * Gets the amount of rows that was returned by the query.
     * Last gets the last object in the results, then retrieves which row it is
     * on and then set it back to the beginning.
     *
     * @param results Results returned from the query.
     * @return Number of rows returned by the query.
     * @throws SQLException Thrown if problem occurs during request for data.
     */
    private int getRowCount(ResultSet results) throws SQLException {
        results.last();
        int count = results.getRow();
        results.beforeFirst();
        return count;
    }

    /**
     * Closes the connection to the database.
     *
     * @throws SQLException Thrown if problem occurs during request for data.
     */
    public void close() throws SQLException {
        conn.close();
    }

}
