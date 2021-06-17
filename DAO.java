import java.sql.*;

public class DAO {
    
    private ResultSet results;
    private ResultSetMetaData metadata;

    public DAO(ResultSet results, ResultSetMetaData metadata) {
        this.results = results;
        this.metadata = metadata;
    }

    
}
