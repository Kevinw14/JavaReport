abstract class ParsableCommand {
    private String name;
    public abstract void run();
    public String getName() {
        return name;
    }
}
