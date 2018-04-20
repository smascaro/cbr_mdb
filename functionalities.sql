/*procedure to insert a song into datbase given its info and the filename 
  (file must be placed in MEDIA_DIR directory)*/
CREATE OR REPLACE PROCEDURE ADD_SONG (
  NEW_TITLE IN VARCHAR2,
  NEW_ARTIST IN VARCHAR2,
  NEW_ALBUM IN VARCHAR2,
  FILENAME IN VARCHAR2)
  
IS
  OBJ ORDAUDIO;
  CTX RAW(64) := NULL;
  NEW_ID NUMBER;
  FOUND NUMBER := 0;
BEGIN
  SELECT MAX(ID) INTO NEW_ID FROM SONGS;
  NEW_ID := NEW_ID + 1;
  SELECT COUNT(*) INTO FOUND FROM SONGS 
  WHERE TITLE = NEW_TITLE AND ARTIST = NEW_ARTIST AND ALBUM = NEW_ALBUM;
  IF FOUND = 0 THEN 
    INSERT INTO SONGS 
    VALUES (NEW_TITLE, NEW_ARTIST, NEW_ALBUM, ORDAUDIO.INIT('FILE','MEDIA_DIR',FILENAME), NEW_ID)
    RETURNING TRACKFILE INTO OBJ;
  
    OBJ.IMPORT(CTX);
   
    OBJ.SETPROPERTIES(CTX);
   
    UPDATE SONGS SET TRACKFILE = OBJ WHERE TITLE=NEW_TITLE AND ARTIST=NEW_ARTIST;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(NEW_TITLE || ' by ' || NEW_ARTIST || ' has been inserted in the system.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('This song already exists in the system.');
  END IF;
  END;
/

/*following execution will fail if the song already exists*/
EXECUTE ADD_SONG('Com camot', 'Auxili', 'Tresors', 'converses_de_balcons.mp3');



/*procedure that inserts a song to the user's favorite list,
  user can pass a playlist name in order to classify his songs*/

CREATE OR REPLACE PROCEDURE ADD_FAVORITE (
  U_NAME FAVS.USERNAME%TYPE,
  SONG FAVS.SONG_ID%TYPE,
  PL_NAME FAVS.PLAYLIST%TYPE DEFAULT ' '
) 
IS 
  IN_PLAYLIST NUMBER := 0;
  EXISTS_PLAYLIST NUMBER;
  EXISTS_SONG NUMBER;
  EXISTS_USER NUMBER;
BEGIN 
  SELECT COUNT(*) INTO EXISTS_USER FROM USERS WHERE USERNAME = U_NAME;
  SELECT COUNT(*) INTO EXISTS_SONG FROM SONGS WHERE ID = SONG;
  IF EXISTS_USER > 0 AND EXISTS_SONG > 0 THEN
    SELECT COUNT(*) INTO EXISTS_PLAYLIST FROM FAVS WHERE PLAYLIST = PL_NAME AND USERNAME = U_NAME;
    IF PL_NAME != ' ' THEN 
        IN_PLAYLIST := 1; 
    END IF;
    INSERT INTO FAVS VALUES (U_NAME, SONG, PL_NAME);
    IF SQL%ROWCOUNT > 0 THEN
      IF IN_PLAYLIST > 0 THEN
        IF EXISTS_PLAYLIST > 0 THEN
          DBMS_OUTPUT.PUT_LINE('Song inserted into playlist named ' || PL_NAME || ' from user ' || U_NAME || '.');
        ELSE
          DBMS_OUTPUT.PUT_LINE('New playlist named ' || PL_NAME || ' has been created for user ' || U_NAME || '. The song has been inserted into the new playlist.');
        END IF;
      ELSE
        DBMS_OUTPUT.PUT_LINE('Song inserted into '|| U_NAME ||'''s favorites, but not related to any playlist.');
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Song couldnt be inserted into favorites table.');
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Either the song or the username does not exist.');
  END IF;

END;

/*testing add_favorite procedure*/
SET SERVEROUTPUT ON;
EXECUTE ADD_FAVORITE('msk1416', 20, 'vinarock');/*new playlist by msk1416*/
EXECUTE ADD_FAVORITE('msk1416', 15, 'vinarock');/*existing playlist*/
EXECUTE ADD_FAVORITE('msk1416', 30);/*not related to playlist*/
EXECUTE ADD_FAVORITE('msk1416', 60, 'nonexistentsong'); /*fail: song does not exist*/
EXECUTE ADD_FAVORITE('idontexist', 10);/*fail: user does not exist*/
EXECUTE ADD_FAVORITE('idontexisteither', 60);/*fail either user and song don't exist*/
EXECUTE ADD_FAVORITE('bstinson', 23, 'vinarock');/*new playlist by bstinson*/
EXECUTE ADD_FAVORITE('bstinson', 31, 'Get Psyched Mix 2.0');/*new playlist by bstinson*/
EXECUTE ADD_FAVORITE('msk1416', 1, 'vinarock'); 
EXECUTE ADD_FAVORITE('msk1416', 39, 'vinarock'); 
EXECUTE ADD_FAVORITE('msk1416', 44, 'vinarock');
EXECUTE ADD_FAVORITE('msk1416', 32, 'vinarock');
EXECUTE ADD_FAVORITE('msk1416', 31, 'vinarock');
EXECUTE ADD_FAVORITE('msk1416', 23, 'vinarock');
EXECUTE ADD_FAVORITE('msk1416', 29, 'vinarock');
EXECUTE ADD_FAVORITE('bstinson', 21, 'Get Psyched Mix 2.0');
EXECUTE ADD_FAVORITE('bstinson', 12, 'Get Psyched Mix 2.0');
EXECUTE ADD_FAVORITE('bstinson', 43, 'Get Psyched Mix 2.0');
EXECUTE ADD_FAVORITE('bstinson', 5, 'Get Psyched Mix 2.0');
EXECUTE ADD_FAVORITE('bstinson', 44, 'Get Psyched Mix 2.0');
EXECUTE ADD_FAVORITE('bstinson', 39, 'Get Psyched Mix 2.0');
EXECUTE ADD_FAVORITE('bstinson', 8, 'Get Psyched Mix 2.0');
EXECUTE ADD_FAVORITE('bstinson', 27, 'Get Psyched Mix 2.0');


/*procedure to export a user's playlist in xml format*/
CREATE OR REPLACE PROCEDURE EXPORT_PLAYLIST_TO_XML (
  U_NAME FAVS.USERNAME%TYPE,
  PL_NAME FAVS.PLAYLIST%TYPE
  )
  IS
    CURSOR CUR_SONGS IS SELECT SONG_ID 
      FROM FAVS 
      WHERE USERNAME = U_NAME AND PLAYLIST = PL_NAME;
    EXP_FILE UTL_FILE.FILE_TYPE;
    FILENAME VARCHAR(100);
    SONG FAVS.SONG_ID%TYPE;
    SONGROW SONGS%ROWTYPE;
    EXISTS_PLAYLIST NUMBER;
  BEGIN
    SELECT COUNT(*) INTO EXISTS_PLAYLIST FROM FAVS WHERE USERNAME = U_NAME AND PLAYLIST = PL_NAME;
    IF EXISTS_PLAYLIST > 0 THEN 
      FILENAME := 'export_' || PL_NAME || '_' || U_NAME || '.xml';
      EXP_FILE := UTL_FILE.FOPEN('EXPORTS_DIR',FILENAME,'W');
      UTL_FILE.PUT_LINE(EXP_FILE, '<?xml version="1.0" encoding="UTF-8"?>');
      UTL_FILE.PUT_LINE(EXP_FILE, '<Playlist name='''|| PL_NAME ||''' user='''|| U_NAME ||'''>');
      OPEN CUR_SONGS;
      LOOP
        FETCH CUR_SONGS
        INTO SONG;
        EXIT WHEN CUR_SONGS%NOTFOUND;
        
        SELECT * INTO SONGROW FROM SONGS WHERE ID = SONG;
        UTL_FILE.PUT_LINE(EXP_FILE, '<Song>');
        UTL_FILE.PUT_LINE(EXP_FILE, '<UniqueId>' || SONGROW.ID || '</UniqueId>');
        UTL_FILE.PUT_LINE(EXP_FILE, '<Title>' || SONGROW.TITLE || '</Title>');
        UTL_FILE.PUT_LINE(EXP_FILE, '<Artist>' || SONGROW.ARTIST || '</Artist>');
        UTL_FILE.PUT_LINE(EXP_FILE, '<Album>' || SONGROW.ALBUM || '</Album>');
        UTL_FILE.PUT_LINE(EXP_FILE, '</Song>');
        
      END LOOP;
      UTL_FILE.PUT_LINE(EXP_FILE, '</Playlist>');
      UTL_FILE.FCLOSE(EXP_FILE);
    ELSE
      DBMS_OUTPUT.PUT_LINE('No export has been done as this playlist does not exist for this user.');
    END IF;
  END;

EXECUTE EXPORT_PLAYLIST_TO_XML ('msk1416', 'vinarock');
EXECUTE EXPORT_PLAYLIST_TO_XML ('bstinson', 'Get Psyched Mix 2.0');



/*procedure that outputs a list with internal information for a requested song*/
CREATE OR REPLACE PROCEDURE CHECK_ATTRIBUTES_SONG (
  SONG_ID SONGS.ID%TYPE
  )
  IS
    CTX RAW(64) := NULL;
    OBJ ORDAUDIO;
    TEMPLOB CLOB;
  BEGIN
    SELECT TRACKFILE INTO OBJ FROM SONGS WHERE ID = SONG_ID;
    IF OBJ.CHECKPROPERTIES(CTX) = TRUE THEN
      DBMS_OUTPUT.PUT_LINE('Attribute list:');
      DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
      DBMS_LOB.CREATETEMPORARY(TEMPLOB, FALSE, DBMS_LOB.CALL);
      OBJ.GETALLATTRIBUTES(CTX,TEMPLOB);
      DBMS_OUTPUT.PUT_LINE(REPLACE(DBMS_LOB.SUBSTR(TEMPLOB, DBMS_LOB.GETLENGTH(TEMPLOB),1), ',',  CHR(13)||CHR(10)));
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Properties not set for this song file.');
    END IF;

    EXCEPTION 
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('There is no song with this ID in the database.');
  END;

/*testing procedure check_attributes_song*/
EXECUTE CHECK_ATTRIBUTES_SONG (23);/*will show list with file information*/
EXECUTE CHECK_ATTRIBUTES_SONG (47);/*this song does not exist -> handle exception*/

/* function that returns the minutes - seconds representation for a given duration
 in seconds */
CREATE OR REPLACE FUNCTION SECONDS_TO_MINUTES (
  DURATION NUMBER
  ) RETURN VARCHAR 
  IS
    MINUTES NUMBER;
    SECONDS NUMBER;
  BEGIN
    IF DURATION < 60 THEN
      RETURN DURATION || ' s';
    ELSE
      MINUTES := FLOOR(DURATION / 60);
      SECONDS := DURATION - MINUTES * 60;
      RETURN MINUTES || 'm ' || SECONDS || 's';
    END IF;
  END;

/* procedure to check similar songs in terms of duration */
CREATE OR REPLACE PROCEDURE CHECK_SONGS_BY_DURATION(
  SONG_ID SONGS.ID%TYPE
  ) 
  IS
    CTX RAW(64) := NULL;
    OBJ ORDAUDIO;
    CURRENT_SONG SONGS%ROWTYPE;
    OBJ_DURATION INTEGER;
    OBJ_TITLE SONGS.TITLE%TYPE;
    OBJ_ARTIST SONGS.ARTIST%TYPE;
    CURSOR CUR_SONGS IS SELECT *
      FROM SONGS
      WHERE ID != SONG_ID;
  BEGIN
    SELECT TRACKFILE, TITLE, ARTIST INTO OBJ, OBJ_TITLE, OBJ_ARTIST FROM SONGS WHERE ID = SONG_ID;
    IF OBJ.CHECKPROPERTIES(CTX) = TRUE THEN
      OBJ_DURATION := OBJ.GETAUDIODURATION();
      DBMS_OUTPUT.PUT_LINE(OBJ_TITLE || ' - ' || OBJ_ARTIST || ': ' || SECONDS_TO_MINUTES(OBJ_DURATION));
      DBMS_OUTPUT.PUT_LINE('----------------------------------');
      OPEN CUR_SONGS;
      LOOP
        FETCH CUR_SONGS
        INTO CURRENT_SONG;
        EXIT WHEN CUR_SONGS%NOTFOUND;
        IF CURRENT_SONG.TRACKFILE.GETAUDIODURATION() < OBJ_DURATION +  10 AND 
           CURRENT_SONG.TRACKFILE.GETAUDIODURATION() > OBJ_DURATION - 10 THEN 
           DBMS_OUTPUT.PUT_LINE(CURRENT_SONG.TITLE || ' - ' || CURRENT_SONG.ARTIST || ': ' || SECONDS_TO_MINUTES(CURRENT_SONG.TRACKFILE.GETAUDIODURATION()));
        END IF;
        
      END LOOP;
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Properties not set for this song file.');
    END IF;

    EXCEPTION 
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('There is no song with this ID in the database.');
  
  END;
  
EXECUTE CHECK_SONGS_BY_DURATION(29);  /* exists -> print similar songs in terms of duration */
EXECUTE CHECK_SONGS_BY_DURATION(999); /* not exists -> handle exception */


CREATE OR REPLACE PROCEDURE PLAY_SONG (
  PLAY_USER USERS.USERNAME%TYPE,
  PLAY_SONG_ID SONGS.ID%TYPE,
  PLAY_COUNT NUMBER DEFAULT 1
) 
IS
  USER_EXISTS NUMBER;
  SONG_EXISTS NUMBER;
  PLAY_EXISTS NUMBER;
BEGIN
  SELECT COUNT(*) INTO USER_EXISTS FROM USERS WHERE USERNAME = PLAY_USER;
  SELECT COUNT(*) INTO SONG_EXISTS FROM SONGS WHERE ID = PLAY_SONG_ID;
  SELECT COUNT(*) INTO PLAY_EXISTS FROM PLAYHISTORY WHERE USERNAME = PLAY_USER AND SONG_ID = PLAY_SONG_ID;
  
  IF SONG_EXISTS <> 0 AND USER_EXISTS <> 0 THEN
    IF PLAY_EXISTS = 0 THEN
      INSERT INTO PLAYHISTORY VALUES (PLAY_USER, PLAY_SONG_ID, PLAY_COUNT);
    ELSE 
      UPDATE PLAYHISTORY 
      SET PLAYCOUNT = PLAYCOUNT + PLAY_COUNT 
      WHERE USERNAME = PLAY_USER AND SONG_ID = PLAY_SONG_ID;
    END IF;
  ELSE 
    DBMS_OUTPUT.PUT_LINE('Either the song or the user does not exist.');
  END IF;
  EXCEPTION
  
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Either the song or the user does not exist.');
END;

EXECUTE PLAY_SONG('msk1416', 6, 10);
EXECUTE PLAY_SONG('bstinson', 18, 20);

/* trigger that checks if a song has been played more than 30 times, if so, it will
    be added to favorite list in a new playlist called 'Most played songs' */
CREATE OR REPLACE TRIGGER UPDATE_PLAYCOUNT 
AFTER INSERT OR UPDATE 
ON PLAYHISTORY
FOR EACH ROW
DECLARE
  ISFAV NUMBER;
  USER USERS.USERNAME%TYPE := :NEW.USERNAME;
  SONG SONGS.ID%TYPE := :NEW.SONG_ID;
  PLSQL_BLOCK VARCHAR2(500);
BEGIN
  SELECT COUNT (*) INTO ISFAV FROM FAVS WHERE USERNAME = :NEW.USERNAME AND SONG_ID = :NEW.SONG_ID;
  IF :NEW.PLAYCOUNT > 30 AND ISFAV = 0 THEN
    PLSQL_BLOCK := 'BEGIN add_favorite(:user, :song, ''Most played songs''); END;';
    EXECUTE IMMEDIATE PLSQL_BLOCK USING USER, SONG;
  END IF;
END;