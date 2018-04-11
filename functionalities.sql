/*procedure to insert a song into datbase given its info and the filename 
  (file must be placed in MEDIA_DIR directory)*/
CREATE OR REPLACE PROCEDURE add_song (
  new_title IN VARCHAR2,
  new_artist IN VARCHAR2,
  new_album IN VARCHAR2,
  filename IN VARCHAR2)
  
IS
  obj ORDAUDIO;
  ctx RAW(64) := NULL;
  new_id NUMBER;
  found NUMBER := 0;
BEGIN
  select MAX(ID) into new_id from SONGS;
  new_id := new_id + 1;
  select count(*) into found from songs 
  where title = new_title and artist = new_artist and album = new_album;
  if found = 0 then 
    insert into songs 
    values (new_title, new_artist, new_album, ORDAudio.init('FILE','MEDIA_DIR',filename), new_id)
    returning trackfile into obj;
  
    obj.import(ctx);
   
    obj.setProperties(ctx);
   
    UPDATE songs SET trackfile = obj WHERE title=new_title and artist=new_artist;
    COMMIT;
    dbms_output.put_line(new_title || ' by ' || new_artist || ' has been inserted in the system.');
  else
    dbms_output.put_line('This song already exists in the system.');
  end if;
  END;
/

/*following execution will fail if the song already exists*/
execute ADD_SONG('Com camot', 'Auxili', 'Tresors', 'converses_de_balcons.mp3');



/*procedure that inserts a song to the user's favorite list,
  user can pass a playlist name in order to classify his songs*/

create or replace procedure add_favorite (
  u_name FAVS.USERNAME%TYPE,
  song favs.song_id%type,
  pl_name favs.playlist%type default ' '
) 
is 
  in_playlist NUMBER := 0;
  exists_playlist NUMBER;
  exists_song NUMBER;
  exists_user NUMBER;
begin 
  select count(*) into exists_user from users where username = u_name;
  select count(*) into exists_song from songs where id = song;
  if exists_user > 0 and exists_song > 0 then
    select count(*) into exists_playlist from favs where playlist = pl_name and username = u_name;
    if pl_name != ' ' then 
        in_playlist := 1; 
    end if;
    insert into favs values (u_name, song, pl_name);
    if sql%rowcount > 0 then
      if in_playlist > 0 then
        if exists_playlist > 0 then
          dbms_output.put_line('Song inserted into playlist named ' || pl_name || ' from user ' || u_name || '.');
        else
          dbms_output.put_line('New playlist named ' || pl_name || ' has been created for user ' || u_name || '. The song has been inserted into the new playlist.');
        end if;
      else
        dbms_output.put_line('Song inserted into '|| u_name ||'''s favorites, but not related to any playlist.');
      end if;
    else
      dbms_output.put_line('Song couldnt be inserted into favorites table.');
    end if;
  else
    dbms_output.put_line('Either the song or the username does not exist.');
  end if;

end;

/*testing add_favorite procedure*/
set serveroutput on;
execute add_favorite('msk1416', 20, 'vinarock');/*new playlist by msk1416*/
execute add_favorite('msk1416', 15, 'vinarock');/*existing playlist*/
execute add_favorite('msk1416', 30);/*not related to playlist*/
execute add_favorite('msk1416', 60, 'nonexistentsong'); /*fail: song does not exist*/
execute add_favorite('idontexist', 10);/*fail: user does not exist*/
execute add_favorite('idontexisteither', 60);/*fail either user and song don't exist*/
execute add_favorite('bstinson', 23, 'vinarock');/*new playlist by bstinson*/
execute add_favorite('bstinson', 31, 'Get Psyched Mix 2.0');/*new playlist by bstinson*/
execute add_favorite('msk1416', 1, 'vinarock'); 
execute add_favorite('msk1416', 39, 'vinarock'); 
execute add_favorite('msk1416', 44, 'vinarock');
execute add_favorite('msk1416', 32, 'vinarock');
execute add_favorite('msk1416', 31, 'vinarock');
execute add_favorite('msk1416', 23, 'vinarock');
execute add_favorite('msk1416', 29, 'vinarock');
execute add_favorite('bstinson', 21, 'Get Psyched Mix 2.0');
execute add_favorite('bstinson', 12, 'Get Psyched Mix 2.0');
execute add_favorite('bstinson', 43, 'Get Psyched Mix 2.0');
execute add_favorite('bstinson', 5, 'Get Psyched Mix 2.0');
execute add_favorite('bstinson', 44, 'Get Psyched Mix 2.0');
execute add_favorite('bstinson', 39, 'Get Psyched Mix 2.0');
execute add_favorite('bstinson', 8, 'Get Psyched Mix 2.0');
execute add_favorite('bstinson', 27, 'Get Psyched Mix 2.0');


/*procedure to export a user's playlist in xml format*/
create or replace procedure export_playlist_to_xml (
  u_name favs.username%type,
  pl_name favs.playlist%type
  )
  is
    cursor cur_songs is select song_id 
      from favs 
      where username = u_name and playlist = pl_name;
    exp_file UTL_FILE.FILE_TYPE;
    filename VARCHAR(100);
    song favs.song_id%type;
    songrow songs%rowtype;
    exists_playlist NUMBER;
  begin
    select count(*) into exists_playlist from favs where username = u_name and playlist = pl_name;
    if exists_playlist > 0 then 
      filename := 'export_' || pl_name || '_' || u_name || '.xml';
      exp_file := UTL_FILE.FOPEN('EXPORTS_DIR',filename,'W');
      UTL_FILE.put_line(exp_file, '<?xml version="1.0" encoding="UTF-8"?>');
      UTL_FILE.put_line(exp_file, '<Playlist name='''|| pl_name ||''' user='''|| u_name ||'''>');
      open cur_songs;
      loop
        fetch cur_songs
        into song;
        EXIT WHEN cur_songs%NOTFOUND;
        
        select * into songrow from songs where id = song;
        UTL_FILE.put_line(exp_file, '<Song>');
        UTL_FILE.put_line(exp_file, '<UniqueId>' || songrow.ID || '</UniqueId>');
        UTL_FILE.put_line(exp_file, '<Title>' || songrow.title || '</Title>');
        UTL_FILE.put_line(exp_file, '<Artist>' || songrow.artist || '</Artist>');
        UTL_FILE.put_line(exp_file, '<Album>' || songrow.album || '</Album>');
        UTL_FILE.put_line(exp_file, '</Song>');
        
      end loop;
      UTL_FILE.put_line(exp_file, '</Playlist>');
      UTL_FILE.FCLOSE(exp_file);
    else
      dbms_output.put_line('No export has been done as this playlist does not exist for this user.');
    end if;
  end;

execute export_playlist_to_xml ('msk1416', 'vinarock');
execute export_playlist_to_xml ('bstinson', 'Get Psyched Mix 2.0');



/*procedure that outputs a list with internal information for a requested song*/
create or replace procedure check_attributes_song (
  song_id songs.id%type
  )
  is
    ctx RAW(64) := NULL;
    obj ORDAUDIO;
    tempLob CLOB;
  begin
    select trackfile into obj from songs where id = song_id;
    if obj.checkProperties(ctx) = TRUE then
      DBMS_OUTPUT.PUT_LINE('Attribute list:');
      DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
      DBMS_LOB.CREATETEMPORARY(tempLob, FALSE, DBMS_LOB.CALL);
      obj.getAllAttributes(ctx,tempLob);
      DBMS_OUTPUT.PUT_LINE(REPLACE(DBMS_LOB.substr(tempLob, DBMS_LOB.getLength(tempLob),1), ',',  chr(13)||chr(10)));
    else 
      dbms_output.put_line('Properties not set for this song file.');
    end if;

    EXCEPTION 
      WHEN NO_DATA_FOUND then
        dbms_output.put_line('There is no song with this ID in the database.');
  end;

/*testing procedure check_attributes_song*/
execute check_attributes_song (23);/*will show list with file information*/
execute check_attributes_song (47);/*this song does not exist -> handle exception*/