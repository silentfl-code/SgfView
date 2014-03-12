package sgfview;

import java.io.*;
import java.sql.*;
import java.net.InetSocketAddress;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import oracle.jdbc.driver.OracleDriver;
import oracle.jdbc.OracleTypes;
import java.util.Queue;
import java.util.LinkedList;
import java.util.Date;
import java.util.Arrays;
/**
 *
 * @author Silent
 */
public class SgfView {

    public static Connection conn;
    public static String Sgf;
    
    //пример функции, вызывающей sql-запрос
    public static Game getGame(int id){
        PreparedStatement query = null;
        try {
            String sqlstring = "SELECT games.id, games.data as data, gamers1.name as PlayerBlack, rank1.name as PlayerBlackRank, gamers2.name as PlayerWhite, rank2.name AS PlayerWhiteRank, games.result AS "+
                                "RESULT, games.\"Size\", games.place, games.rules, games.timelimit, games.komi, games.\"COMMENT\", games.game "+
                                "FROM games JOIN gamers gamers1 on games.playerblack = gamers1.id "+
                                "JOIN gamers gamers2 on games.playerwhite = gamers2.id "+
                                "JOIN rank rank1 ON gamers1.rank = rank1.id "+
                                "JOIN rank rank2 ON gamers2.rank = rank2.id "+
                                "WHERE games.id = ?";
            query = conn.prepareStatement(sqlstring);
            query.setInt(1, id);
            ResultSet rs = query.executeQuery();
            rs.next();
            return new Game(rs.getInt("size"),
                    rs.getString("PlayerBlack"),
                    rs.getString("playerBlackRank"), 
                    rs.getString("playerWhite"), 
                    rs.getString("playerWhiteRank"),
                    rs.getDate("data").toString(), 
                    rs.getString("place"),
                    rs.getString("result"),
                    rs.getString("rules"),
                    rs.getFloat("timeLimit"),
                    rs.getFloat("komi"), 
                    rs.getString("comment"), 
                    rs.getString("game"));
        } 
        catch (SQLException e) {
            return null;
        } 
        finally {
            if ( query != null ) try { query.close(); } catch (SQLException e) {}; 
        }  
    }
    
    //пример функции, вызывающей хранимую процедуру
    //на выходе процедуры - cursor
    public static LinkedList<GameMin> getGames(String PlayerName) {
        CallableStatement query = null;
        LinkedList <GameMin> res = new LinkedList<GameMin>();
        try{
            query = conn.prepareCall(
                    "{call GetMainTable(?, ?)}");
            //Задаём входные параметры
            if (!PlayerName.equals("")) PlayerName = "%"+PlayerName+"%";
            query.setString(1, PlayerName);
            query.registerOutParameter(2, OracleTypes.CURSOR);
            //Выполняем запрос
            query.execute();
            ResultSet result = (ResultSet)query.getObject(2);
            while (result.next()) {
                res.add(new GameMin(result.getInt("id"),
                                    result.getString("PlayerBlack"),
                                    result.getString("PlayerBlackRank"),
                                    result.getString("PlayerWhite"),
                                    result.getString("PlayerWhiteRank"),
                                    result.getDate("data"),
                                    result.getString("result")));
            }
            return res;
        }
        catch (SQLException e) {
            return null;
        }
        finally {
            if (query != null) {try { query.close(); } catch (SQLException e) {};};
        }
    }
    
    //пример функции, вызывающей хранимую процедуру
    //для вставки данных в таблицы
    public static void insGame(Game g, String filename) {
        CallableStatement query = null;
        try{
            query = conn.prepareCall(
                    "{call insertgame(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            //Задаём входные параметры
            query.setString(1, g.playerWhite);
            query.setString(2, g.playerWhiteRange);
            query.setString(3, g.playerBlack);
            query.setString(4, g.playerBlackRange);
            query.setInt(5, g.size);
            try{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
            Date dt = sdf.parse(g.data.substring(0,10));
            query.setDate(6, new java.sql.Date(dt.getTime()));
            }
            catch (Exception e){};
            query.setString(7, g.place);
            query.setString(8, g.result);
            query.setString(9, g.rules);
            query.setFloat(10, g.timeLimit);
            query.setFloat(11, g.komi);
            query.setString(12, g.comment);
            query.setString(13, g.game);          
            
            //Выполняем запрос
            query.execute();
        }
        catch (SQLException e) {
            System.out.println(filename + " "+ e.toString());
        }
        finally {
            if (query != null) {try { query.close(); } catch (SQLException e) {};};
        }
    }
    
	//загрузка sgf-файлов из указанного каталога
    public static void LoadSgfs(String folderName) {
        File folder = new File(folderName);
        File[] listOfFiles = folder.listFiles();

        for (int i = 0; i < listOfFiles.length; i++) {
            if (listOfFiles[i].isFile()) {
                try {
                    File file = new File(listOfFiles[i].getName());
                    byte [] bytearray  = new byte [(int)file.length()];
                    FileInputStream fis = new FileInputStream(file);
                    BufferedInputStream bis = new BufferedInputStream(fis);
                    bis.read(bytearray, 0, bytearray.length);
                    try {
                    Game g = new Game(new String(bytearray));
                    insGame(g, listOfFiles[i].getName());
                    }
                    catch (Exception e) {};
                }
                catch (FileNotFoundException e){
                }        
                catch (IOException e) {
                }
            }
        }
    }
    
    public static void main(String[] args) {
        //LoadSgfs("d:\\");
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "test","test");
            if(conn == null) {
                System.out.println("Can't connect to database!");
                System.exit(1);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("ClassNotFoundException");
            System.exit(1);
        }
        catch (SQLException e) {
            System.out.println("SQLException\n" + e.getMessage());
            System.exit(1);
        };
        try {
            HttpServer server = HttpServer.create(new InetSocketAddress(8000), 0);
            server.createContext("/", new MainHandler());
            server.setExecutor(null); // creates a default executor
            server.start();
        } 
        catch (Exception e) {
            System.out.print(e.toString());
        }
    }
    
    static class MainHandler implements HttpHandler {  
	
        public String ConvertToXML(Object[] args) {
            String xmlStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<Nodes>\n";
            for (int i = 0; i < args.length; i++)
            {
                GameMin t = (GameMin)(args[i]);
                xmlStr += String.format("\t<Node>\n\t\t<id>%s</id>\n\t\t<PlayerBlack>%s</PlayerBlack>\n\t\t<PlayerBlackRange>%s</PlayerBlackRange>\n\t\t<PlayerWhite>%s</PlayerWhite>\n\t\t<PlayerWhiteRange>%s</PlayerWhiteRange>\n\t\t<Result>%s</Result>\n\t\t<Data>%s</Data>\n\t</Node>\n",
                                        t.id,
                                        t.playerBlack,
                                        t.playerBlackRange,
                                        t.playerWhite,
                                        t.playerWhiteRange,
                                        t.result,
                                        t.data);
            }
            xmlStr += "</Nodes>";
            return xmlStr;
        }
        
        public void handle(HttpExchange t) throws IOException {
            String uri = t.getRequestURI().getPath();
            byte[] response;
            int code = 0, id = 0;
            String PlayerName = "";
            switch (uri){
                case ("/"): uri = "/index.html";
                case ("/index.html"):
                case ("/script.js"):
                case ("/styles.css"):
                case ("/view.jpg"): {
                    response = getFile(uri);
                    code = 200;
                    break;
                }
                case ("/list.xml"): {
                    if (t.getRequestURI().getQuery() == null) PlayerName = "";
                    else {
                        try{
                            if (!t.getRequestURI().getQuery().substring(0,3).equalsIgnoreCase("id=")) PlayerName = "";
                            else {
                                try {
                                    PlayerName = t.getRequestURI().getQuery().substring(3);
                                }
                                catch (NumberFormatException e) {
                                    PlayerName = "";
                                }
                            }
                        }catch (ArrayIndexOutOfBoundsException e) {};
                    }
                    Queue<GameMin> g = getGames(PlayerName);
                    response = ConvertToXML(g.toArray()).getBytes();
                    code = 200;
                    break;
                }
                case ("/sgf.html"): {
                    if (Sgf==null) Sgf = new String(getFile("/sgf.html"));
                    String tmp = Sgf;
                    try{
                        if (!t.getRequestURI().getQuery().substring(0,3).equalsIgnoreCase("id=")) id = 0;
                        else {
                            try {
                                id = Integer.parseInt(t.getRequestURI().getQuery().substring(3));
                            }
                            catch (NumberFormatException e) {
                                id = 0;
                            }
                        }
                    }
                    catch (ArrayIndexOutOfBoundsException e) {};
                    response = (tmp.replace("<<SgfFile>>", getGame(id).toJSON())).getBytes();
                    code = 200;
                    t.getResponseHeaders().put("Content-Type", Arrays.asList("text/html; charset=UTF-8"));
                    break;
                }
                default : {
                    response = "<b>File not found</b>".getBytes();
                    code = 404;
                }
            }
            t.sendResponseHeaders(200, response.length);
            OutputStream os = t.getResponseBody();
            os.write(response);
            os.close();
        }
        
        byte[] getFile(String filename) {
            try {
                File file = new File (this.getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+ "www"+ filename);
                byte [] bytearray  = new byte [(int)file.length()];
                FileInputStream fis = new FileInputStream(file);
                BufferedInputStream bis = new BufferedInputStream(fis);
                bis.read(bytearray, 0, bytearray.length);
                return bytearray;
            }
            catch (FileNotFoundException e){
                return null;
            }        
            catch (IOException e) {
                return null;
            }
        }
    }
}
