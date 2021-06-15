import java.util.ArrayList;

public class ArgParser {

    private ArrayList<Command> commands;

    public ArgParser() {
        commands = new ArrayList<>();
    }

    public void addCommand(String commandName, int requiredArguments) {
        Command command = new Command(commandName, requiredArguments);
        commands.add(command);
    }

    public String command(String userCommand) {
        for (Command command: commands) {
            if (userCommand.contains(command.getCommand()) && command.hasCorrectAmountOfArgs(userCommand)) {
                return command.getCommand();
            }
        }
        return "";
    }

    public String[] args(String userCommand) {
        return userCommand.split(" ");
    }

    public void listCommands() {
        System.out.println();

        for (Command command: commands) {
            System.out.println(command.getCommand());
        }

        System.out.println();
    }
}