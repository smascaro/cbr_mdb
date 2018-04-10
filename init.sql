/* run as sysdba */
create or replace directory MEDIA_DIR AS '/home/oracle/mdb_cbr/music';
grant read,write on directory MEDIA_DIR to MDB;
commit;

create or replace directory IMAGES_DIR AS '/home/oracle/mdb_cbr/images';
grant read, write on directory IMAGES_DIR to MDB;
commit;
/* end run as sysdba */

/* enable output */
set serveroutput on;

/*check directories have been created succesfully*/
select * from dba_directories where directory_name = 'MEDIA_DIR' or directory_name = 'IMAGES_DIR';


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
