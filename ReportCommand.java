import java.util.ArrayList;

public class ReportCommand extends ParsableCommand{

    private final String name;
    private ArrayList<ParsableCommand> subcommands;

    public ReportCommand() {
        this.name = "rpt";
    }

    @Override
    public void run() {
        // TODO Auto-generated method stub
        
    }
    
}
