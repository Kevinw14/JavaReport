public class DAO {

    private final String state;
    private final int count;
    private final int min;
    private final int max;
    private final int avg;

    public DAO(String state, int count, int min, int max, int avg) {
        this.state = state;
        this.count = count;
        this.min = min;
        this.max = max;
        this.avg = avg;
    }

    String getState() { return state; }
    int getCount() { return count; }
    int getMin() { return min; }
    int getMax() { return max; }
    int getAvg() { return avg; }

    @Override
    public String toString() {
        return String.format("%s, %d, %d, %d, %d", state, count, min, max, avg);
    }

    public String get(String column) {
        switch (column) {
            case "State":
            return state;
            case "Count":
            return String.format("%d", count);
            case "Low":
            return String.format("%d", min);
            case "High":
            return String.format("%d", max);
            case "Average":
            return String.format("%d", avg);
            default:
            return "";
        }
    }
}
