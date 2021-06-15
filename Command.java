public class Command {

    private String command;
    private int requiredArguments;

    public Command(String command, int requiredArguments) {
        this.command = command;
        this.requiredArguments = requiredArguments;
    }

    public boolean hasCorrectAmountOfArgs(String userCommand) {
        int sizeOfCommand = userCommand.split(" ").length - 1;
        return sizeOfCommand == requiredArguments;
    }

    public String getCommand() {
        return command;
    }
}

