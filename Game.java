package sgfview;
import java.util.Queue;
import java.util.LinkedList;
/**
 *
 * @author Silent
 */

public class Game {
    public int size;
    public String playerBlack;
    public String playerBlackRange;
    public String playerWhite;
    public String playerWhiteRange;
    public String data;           
    public String place;
    public String result;
    public String rules;
    public float timeLimit;
    public float komi;
    public String comment;
    public String game;
    
    public Game(String Value) throws Exception {
        this.game = (Value.replace("\r\n", "")).replace("\n", "");
        if (!parse())
            throw new Exception("Incorrect sgf format!");
    }

    public Game(int size, 
                String playerBlack, 
                String playerBlackRange, 
                String playerWhite, 
                String playerWhiteRange, 
                String data, 
                String place, 
                String result, 
                String rules, 
                float timeLimit, 
                float komi, 
                String comment, 
                String game) {
        this.size = size;
        this.playerBlack = playerBlack;
        this.playerBlackRange=playerBlackRange;
        this.playerWhite=playerWhite;
        this.playerWhiteRange=playerWhiteRange;
        this.data=data;
        this.place=place;
        this.result=result;
        this.rules=rules;
        this.timeLimit=timeLimit;
        this.komi=komi;
        this.comment=comment;
        this.game=game;
    }
    
    public String toJSON() {
        String res = String.format("{index:0,\nSZ:'%s',\nPW:'%s',\nWR:'%s',\nPB:'%s',\nBR:'%s',\nDT:'%s',\nPC:'%s',\nKM:'%s',\nRE:'%s',\nRU:'%s',\nmoves:['%s']\n}", 
                             this.size,
                             this.playerWhite,
                             this.playerWhiteRange,
                             this.playerBlack,
                             this.playerBlackRange,
                             this.data,
                             this.place,
                             this.komi,
                             this.result,
                             this.rules,
                             this.game.replaceAll(",", "','"));
        return res;
    }
    private Boolean parseHeader(String header) throws Exception {
        int i = 0;
        while (i < header.length()) {
            int start = i;
            //получаем имя свойства
            while (header.charAt(i) != '[' && (i < header.length())) i++;
            if (i == header.length()) return false;
            String prop = header.substring(start, i);

            start = i + 1; i++;  //пропускаем '['
            //получаем значение свойства
            while ((i < header.length()) && (header.charAt(i) != ']')) i++;
            if (i == header.length()) return false;
            String value = header.substring(start, i);

            switch (prop)
            {
                //board size
                case ("SZ"): { try { this.size = Integer.parseInt(value); } catch (NumberFormatException e) {this.size = 19; } break; }
                //black player name
                case ("PB"): { this.playerBlack = value; break; }
                //white player name
                case ("PW"): { this.playerWhite = value; break; }
                //rank black player
                case ("BR"): { this.playerBlackRange = value; break; }
                //rank white player
                case ("WR"): { this.playerWhiteRange = value; break; }
                //place where the games was played
                case ("PC"): { this.place = value; break; }
                //date when the game was played
                case ("DT"): { this.data = value; break; }
                //result of the game
                case ("RE"): { this.result = value; break; }
                //used rules for this game
                case ("RU"): { this.rules = value; break; }
                //time limits
                case ("TM"): { try { this.timeLimit = Float.parseFloat(value); } catch (NumberFormatException e) { this.timeLimit = 0.0f; }; break; }
                //komi
                case ("KM"): { try{ this.komi = Float.parseFloat(value.replace('.', ',')); } catch (NumberFormatException e) { this.komi = 0.0f; }; break; }
                //comment
                case ("C"): { this.comment = value; break; }
                case ("HA"): { throw new Exception("Unsupported feature HA"); }
                case ("AB"): { throw new Exception("Unsupported feature AB"); }
                default:
                    {
                        //сюда не вошли теги стандарта:
                        //AN, BT, CP, EV, GN, GC, ON, OT, RO, SO, US, WT
                        //AP и многие другие
                        break;
                    }
            }
            i++;
        }
        return true;
    }

    private Boolean parse() {
        String moves;
        Queue<String> move = new LinkedList<String>();
        int i = 0;
        //ищем открывающую скобку
        while (game.charAt(i) != '(') i++;
        //пропускаем корневой узел, он должен быть пустой
        while (game.charAt(i) != ';') i++;
        i++;    //пропускаем ';'
        //разбираем строку
        while ((i < game.length()) && game.charAt(i) != ')')
        {
            int start = i;
            while ((i < game.length()) && game.charAt(i) != ';' && game.charAt(i) != ')')
            {
                if (game.charAt(i) == '[')
                    while (game.charAt(i) != ']') i++;
                else i++;
            }
            move.add(game.substring(start, i)); //без ';'
            i++;
        }
        if (game.length() != i || game.charAt(i-1) != ')') return false;
        try {
            if (!parseHeader(move.poll())) return false;
        }
        catch (Exception e) {
            return false;
        };
        if (!move.isEmpty())
        {
            moves = move.poll();
            while (!move.isEmpty())
                moves += "," + move.poll();
        }
        return true;
    }
}
