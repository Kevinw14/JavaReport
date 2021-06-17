import java.util.ArrayList;

public class ArgParser {

    private ArrayList<ParsableCommand> commands;

    public ArgParser() {
        commands = new ArrayList<>();
        ParsableCommand helpCommand = new HelpCommand(commands);
        addCommand(helpCommand);
    }

    public void addCommand(ParsableCommand commmand) {
        commands.add(commmand);
    }

    private String command(String userCommand) {
        return userCommand.split(" ")[0];
    }

    public void parse(String userCommand) {
        String commandString = command(userCommand);

        for (ParsableCommand command: commands) {
            if (command.getName().contains(commandString))
                command.run();
        }
    }
    // public String[] args(String userCommand) {
    //     return userCommand.split(" ");
    // }

    // public void listCommands() {
    //     System.out.println();

    //     for (Command command: commands) {
    //         System.out.println(command.getCommand());
    //     }

    //     System.out.println();
    // }
}