import java.sql.*;

public class DOA {
    
    private ResultSet results;
    private ResultSetMetaData metadata;

    public DOA(ResultSet results, ResultSetMetaData metadata) {
        this.results = results;
        this.metadata = metadata;
    }

    
}
