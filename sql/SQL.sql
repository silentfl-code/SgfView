-- Версия сервера: Oracle Database 10g Enterprise Edition Release 10.2.0.3.0 - Production With the Partitioning, OLAP and Data Mining options

CREATE SEQUENCE TEST.RULES_ID
  START WITH 21
  INCREMENT BY 1;

CREATE SEQUENCE TEST.RANK_ID
  START WITH 101
  INCREMENT BY 1;

CREATE SEQUENCE TEST.GAMES_ID
  START WITH 41
  INCREMENT BY 1;

CREATE SEQUENCE TEST.GAMERS_ID
  START WITH 1
  INCREMENT BY 1;

-- MAINTABLEOBJECT specification
CREATE OR REPLACE type TEST.MainTableObject as Object
(
    id NUMBER,
    data DATE,
    PlayerBlack varchar(20),
    PlayerBlackRank varchar(4),
    PLayerWhite varchar(20),
    PlayerWhiteRank varchar(4),
    RESULT VARCHAR(20)
);
/

CREATE OR REPLACE TYPE TEST.MAINTABLELIST AS
    TABLE OF TEST.MAINTABLEOBJECT;
/

CREATE TABLE TEST.GAMES (
  ID NUMBER(8),
  PLAYERWHITE VARCHAR2(20 BYTE) NOT NULL,
  PLAYERBLACK VARCHAR2(20 BYTE),
  "Size" NUMBER(2) NOT NULL,
  DATA DATE,
  PLACE VARCHAR2(20 BYTE),
  RESULT VARCHAR2(20 BYTE),
  RULES NUMBER(4),
  TIMELIMIT FLOAT(126),
  KOMI FLOAT(126),
  "COMMENT" VARCHAR2(200 BYTE),
  GAME VARCHAR2(2000 BYTE),
  CONSTRAINT PK_GAMES PRIMARY KEY (ID))
TABLESPACE USERS
STORAGE (
  INITIAL 64K
  MAXEXTENTS UNLIMITED
)
LOGGING;

CREATE TABLE TEST.GAMERS (
  ID NUMBER(8),
  NAME VARCHAR2(20 BYTE),
  RANK NUMBER(2),
  CONSTRAINT PK_GAMERS PRIMARY KEY (ID))
TABLESPACE USERS
STORAGE (
  INITIAL 64K
  MAXEXTENTS UNLIMITED
)
LOGGING;

CREATE TABLE TEST.RANK (
  ID NUMBER(2),
  NAME VARCHAR2(4 BYTE) NOT NULL,
  CONSTRAINT PK_RANK PRIMARY KEY (ID),
  UNIQUE (NAME))
TABLESPACE USERS
STORAGE (
  INITIAL 64K
  MAXEXTENTS UNLIMITED
)
LOGGING;

CREATE TABLE TEST.RULES (
  ID NUMBER(4),
  NAME VARCHAR2(100 BYTE),
  CONSTRAINT PK_RULES PRIMARY KEY (ID))
TABLESPACE USERS
STORAGE (
  INITIAL 64K
  MAXEXTENTS UNLIMITED
)
LOGGING;

CREATE OR REPLACE function TEST.GetRankID (vName VARCHAR2)
  -- возвращает id по наименованию (или создает если нет такого)
  RETURN NUMBER
AS
  rankId NUMBER;
BEGIN
  SELECT id INTO rankId
    FROM rank
    WHERE rank.name = vName;
  RETURN rankid;
EXCEPTION 
  WHEN NO_DATA_FOUND THEN
    INSERT INTO rank (NAME) VALUES (vName);
    SELECT id INTO rankId FROM rank WHERE rank.name = vName;
    RETURN rankid;
END;
/

CREATE OR REPLACE function TEST.GetRulesID (vName VARCHAR2)
  -- возвращает id по наименованию (или создает если нет такого)
  RETURN NUMBER
AS
  rulesId NUMBER;
BEGIN
  SELECT id INTO rulesId
    FROM rules
    WHERE rules.name = vName;
  RETURN rulesId;
EXCEPTION 
  WHEN NO_DATA_FOUND THEN
    INSERT INTO rules (NAME) VALUES (vName);
    SELECT id INTO rulesId FROM rules WHERE rules.name = vName;
    RETURN rulesId;
END;
/

CREATE OR REPLACE PROCEDURE TEST.GetMainTable (
  vName IN VARCHAR2,
  l_list OUT SYS_REFCURSOR)
AS
BEGIN
  OPEN l_list
  FOR 
    SELECT games.id, 
           games.data as data, 
           gamers1.name as PlayerBlack, 
           rank1.name as PlayerBlackRank,
           gamers2.name as PlayerWhite, 
           rank2.name AS PlayerWhiteRank, 
           games.result AS Result
    FROM games JOIN gamers gamers1 on games.playerblack = gamers1.id 
      JOIN gamers gamers2 on games.playerwhite = gamers2.id
      JOIN rank rank1 ON gamers1.rank = rank1.id
      JOIN rank rank2 ON gamers2.rank = rank2.id
      WHERE upper(gamers1.name) LIKE (upper(vname) || '%') OR upper(gamers2.name) LIKE (upper(vname) || '%');
END;
/

CREATE OR REPLACE FUNCTION TEST.GetGamerID (
  -- возвращает id игрока (если такого нет - создает)
  vName VARCHAR2,
  vRank VARCHAR2
)
  RETURN NUMBER
AS
  rankId NUMBER;
  GamerID NUMBER;
BEGIN
  rankId := GetRankID(vrank);
  SELECT Gamers.id INTO GamerID
    FROM Gamers
    WHERE (Gamers.name = vname) and (Gamers.rank = rankId);
  RETURN GamerId;
EXCEPTION 
  WHEN NO_DATA_FOUND THEN
    INSERT 
      INTO gamers (name, rank)
      VALUES (vname, rankid);
  SELECT Gamers.id INTO GamerID
    FROM Gamers
    WHERE Gamers.name = vName and Gamers.rank = rankId;
  RETURN GamerId;
END;
/

CREATE OR REPLACE PROCEDURE TEST.InsertGame (
  vPlayerWhiteName VARCHAR2,
  vPlayerWhiteRank VARCHAR2,
  vPlayerBlackName VARCHAR2,
  vPlayerBlackRank VARCHAR2,
  vSize NUMBER,
  vData DATE,
  vPlace VARCHAR2,
  vResult VARCHAR2,
  vRules VARCHAR2,
  vTimeLimit FLOAT,
  vKomi FLOAT,
  vComment VARCHAR2,
  vGame VARCHAR2
  )
IS
  currData DATE := sysdate;
  PlayerWhiteId NUMBER;
  PlayerBlackId NUMBER;
  RulesId NUMBER;
  message EXCEPTION;
BEGIN
  -- проверим размер доски, он должен быть обязательно
  IF vsize IS NULL THEN
    RAISE message;
  END IF;
  
 -- получим id белого игрока
  PlayerWhiteId := GetGamerId(vPlayerWhiteName, vPlayerWhiteRank);
  
  --получим id черного игрока
  PlayerBlackId := GetGamerId(vPlayerBlackName, vPlayerBlackRank);

  --получим id правил
  RulesId := GetRulesId(vRules);

  INSERT 
    INTO games (PlayerWhite, PlayerBlack, "Size", "DATA", place, "RESULT", "RULES", timelimit, komi, "COMMENT", game)
    VALUES ( PlayerWhiteId, PlayerBlackId, vsize, currdata, vplace, vresult, rulesId, vtimelimit, vkomi, vcomment, vgame);
END;
/

CREATE OR REPLACE TRIGGER TEST.BI_GAMERS
BEFORE INSERT ON TEST.GAMERS
REFERENCING NEW AS NEWROW OLD AS OLDROW FOR EACH ROW
  WHEN (OldRow.ID is NULL)
BEGIN
SELECT games_id.nextval INTO
:newrow.ID FROM dual;
END;
/

CREATE OR REPLACE TRIGGER TEST.BI_GAMES
BEFORE INSERT ON TEST.GAMES
REFERENCING NEW AS NEWROW OLD AS OLDROW FOR EACH ROW
  WHEN (NEWROW.ID IS NULL)
BEGIN
  select games_id.NEXTVAL
   INTO :NEWROW.ID from dual;
END;
/

CREATE OR REPLACE TRIGGER TEST.BI_RANK
BEFORE INSERT ON TEST.RANK
REFERENCING NEW AS NEWROW OLD AS OLDROW FOR EACH ROW
  WHEN (OldRow.ID is NULL)
BEGIN
  SELECT rank_id.nextval 
    INTO :NewRow.ID FROM dual;
END;
/

CREATE OR REPLACE TRIGGER TEST.BI_RULES
BEFORE INSERT ON TEST.RULES
REFERENCING NEW AS NEWROW OLD AS OLDROW FOR EACH ROW
  WHEN (OldRow.Id is NULL)
BEGIN
  SELECT rules_id.nextval 
    INTO :NewRow.ID FROM dual;
END;
/