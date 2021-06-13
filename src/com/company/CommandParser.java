package com.company;

public class CommandParser {

    private int count;

    public CommandParser() {
        count = 0;
    }

    public String parseCommand(String command) {
        String[] splitString = command.split(" ");
        if (splitString.length > 0) {
            return splitString[0];
        }
        return "";
    }

    public String[] parseArgs(String command) {
        String[] splitString = command.split(" ");
        String[] args = new String[splitString.length - 1];

        for (int i = 1; i < splitString.length; i++) {
            args[i - 1] = splitString[i];
        }
        return args;
    }
}
