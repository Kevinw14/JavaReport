public class QuitCommand extends ParsableCommand {

    private final String name;

    public QuitCommand() {
        this.name = "quit";
    }

    @Override
    public void run() {
        System.exit(0);
    }

    public String getName() {
        return name;
    }
}
