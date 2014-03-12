package sgfview;

import java.util.Date;

/**
 *
 * @author Silent
 */
public class GameMin {
    public int id;
    public String playerBlack;
    public String playerBlackRange;
    public String playerWhite;
    public String playerWhiteRange;
    public Date data;
    public String result;
    
    public GameMin(int id, 
                   String playerBlack, 
                   String playerBlackRange, 
                   String playerWhite, 
                   String playerWhiteRange, 
                   Date data, 
                   String result) {
        this.id = id;
        this.playerBlack = playerBlack;
        this.playerBlackRange = playerBlackRange;
        this.playerWhite = playerWhite;
        this.playerWhiteRange = playerWhiteRange;
        this.data = data;
        this.result = result;
    }
}