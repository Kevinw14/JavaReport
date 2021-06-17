import java.util.ArrayList;

public class HelpCommand extends ParsableCommand{
    private final String name;
    private final ArrayList<ParsableCommand> commands;

    public HelpCommand(ArrayList<ParsableCommand> commands) {
        this.name = "help";
        this.commands = commands;
    }

    @Override
    public void run() {
        System.out.println();
        for (ParsableCommand command: commands) {
            System.out.println(command.getName());
        }
    }

    public String getName() {
        return name;
    }
}
