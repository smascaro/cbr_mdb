insert into artists values ('Auxili', 'PV', 'Reggae');
insert into artists values ('Los de Marras', 'ES', 'Punk-rock');
insert into artists values ('Vendetta', 'EK', 'Ska');
insert into artists values ('Poncho K', 'ES', 'Rock');

insert into albums values ('Tresors', 'Auxili', 2018, ORDImage.init());
insert into albums values ('Surrealismo', 'Los de Marras', 2014, ORDImage.init());
insert into albums values ('Bother', 'Vendetta', 2016, ORDImage.init());
insert into albums values ('11 palos', 'Poncho K', 2017, ORDImage.init());

set serveroutput on;
set echo on;
/* insert all songs into respective row -> might take some time (1 - 2 minutes) */
DECLARE
  obj ORDAUDIO;
  ctx RAW(64) := NULL;
  new_id NUMBER := 1;
BEGIN
  select MAX(ID) into new_id from SONGS;

  
  INSERT INTO songs VALUES('Com camot', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','com_camot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('Converses de balcons', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','converses_de_balcons.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('El front', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','el_front.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('Ferides', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','ferides.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('Fora dels murs', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','fora_dels_murs.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('Hui la liem', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','hui_la_liem.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('No m esperes', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','no_mesperes.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('Pagines negres', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','pagines_negres.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('Si tu vols', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','si_tu_vols.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  
  new_id := new_id + 1;

  INSERT INTO songs VALUES('T escric', 'Auxili', 'Tresors', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','tescric.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  COMMIT;
 
 
  new_id := new_id + 1;
 
  INSERT INTO songs VALUES('Aun quedan ganas', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','aun_quedan_ganas_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  
  new_id := new_id + 1;
  
  INSERT INTO songs VALUES('Batasuna', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','batasuna_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Bother the police', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','bother_the_police_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Madre', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','madre_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('No sabeis amar', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','no_sabeis_amar_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('No volvere', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','no_volvere_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Pao pao pao', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','pao_pao_pao_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Que importa', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','que_importa_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Reggaean Hegan', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','reggaean_hegan_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Zai', 'Vendetta', 'Bother', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','zai_bot.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  new_id := new_id + 1;
  
  
 
  
  
  INSERT INTO songs VALUES('Al trote', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','al_trote_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('De sereno', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','de_sereno_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('El gallo de la veleta', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','el_gallo_de_la_veleta_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('El hombrecito', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','el_hombrecito_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('La nina del caracol', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','la_nina_del_caracol_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('Los carniceros', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','los_carniceros_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('Lo tierno y la corteza', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','lo_tierno_y_la_corteza_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('Magia pura', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','magia_pura_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('Mequetrefe', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','mequetrefe_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('No me sale del cono', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','no_me_sale_del_cono_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  INSERT INTO songs VALUES('Vuela', 'Poncho K', '11 palos', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','vuela_11p.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  
  
  
  INSERT INTO songs VALUES('Coleando', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','coleando_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Compadre', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','compadre_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('De que se rie', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','de_que_se_rie_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Encadenado', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','encadenado_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('En los tejados', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','en_los_tejados_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Futuro?!', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','futuro_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Hoy', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','hoy_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Medolias', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','medolias_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Poder', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','poder_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Revolviendo', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','revolviendo_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Ruido', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','ruido_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Ser o no ser', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','ser_o_no_ser_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  
  new_id := new_id + 1;
  
  
  INSERT INTO songs VALUES('Sufro', 'Los de Marras', 'Surrealismo', ORDAudio.init(), new_id);
  SELECT trackfile INTO obj FROM songs WHERE id = new_id FOR UPDATE;
 
  obj.setSource('FILE','MEDIA_DIR','sufro_sur.mp3');
  obj.import(ctx);
 
  obj.setProperties(ctx);
 
  UPDATE songs SET trackfile = obj WHERE id = new_id;
  dbms_output.put_line('inserted song with id ' || new_id);
  
  COMMIT;
  
END;
/

/* insert image files to albums covers */
DECLARE 
  cover_file ORDIMAGE;
  album_name VARCHAR(50);
  album_sourcefile VARCHAR(50);
  ctx RAW(64) := NULL;
BEGIN
  
  album_name := 'Bother';
  album_sourcefile := 'front_bot.jpg';
  select cover into cover_file from albums where name = album_name for update;
  
  cover_file.setSource('FILE', 'IMAGES_DIR', album_sourcefile);
  cover_file.import(ctx);
  cover_file.setProperties();
  
  UPDATE albums SET cover = cover_file WHERE name = album_name;
  dbms_output.put_line('inserted cover file for album ' || album_name);
  
  COMMIT;
  
  album_name := 'Tresors';
  album_sourcefile := 'front_tresors.jpg';
  select cover into cover_file from albums where name = album_name for update;
  
  cover_file.setSource('FILE', 'IMAGES_DIR', album_sourcefile);
  cover_file.import(ctx);
  cover_file.setProperties();
  
  UPDATE albums SET cover = cover_file WHERE name = album_name;
  dbms_output.put_line('inserted cover file for album ' || album_name);
  
  
  COMMIT;
  
  album_name := 'Surrealismo';
  album_sourcefile := 'front_sur.jpg';
  select cover into cover_file from albums where name = album_name for update;
  
  cover_file.setSource('FILE', 'IMAGES_DIR', album_sourcefile);
  cover_file.import(ctx);
  cover_file.setProperties();
  
  UPDATE albums SET cover = cover_file WHERE name = album_name;
  dbms_output.put_line('inserted cover file for album ' || album_name);
  
  
  COMMIT;
  
  album_name := '11 palos';
  album_sourcefile := 'front_11p.jpg';
  select cover into cover_file from albums where name = album_name for update;
  
  cover_file.setSource('FILE', 'IMAGES_DIR', album_sourcefile);
  cover_file.import(ctx);
  cover_file.setProperties();
  
  UPDATE albums SET cover = cover_file WHERE name = album_name;
  dbms_output.put_line('inserted cover file for album ' || album_name);
  
  
  COMMIT;

END;
/

/*check that images have been inserted correctly*/
declare
  cover_file ORDIMAGE;
  ctx RAW(64) := null;
  album_name VARCHAR(50);
begin
  album_name := 'Bother';
  select cover into cover_file from albums where name = album_name;
  if (cover_file.checkProperties()) then
    dbms_output.put_line('Album: ' || album_name);
    dbms_output.put_line('image height: ' || cover_file.getHeight());
    dbms_output.put_line('image width: ' || cover_file.getWidth());
    dbms_output.put_line('image format: ' || cover_file.getContentFormat());
    dbms_output.put_line('image size: ' || cover_file.getContentLength());
  else
    dbms_output.put_line('Properties not set correctly');
  end if;
  dbms_output.put_line('');
  dbms_output.put_line('');
  

  album_name := 'Tresors';
  select cover into cover_file from albums where name = album_name;
  if (cover_file.checkProperties()) then
    dbms_output.put_line('Album: ' || album_name);
    dbms_output.put_line('image height: ' || cover_file.getHeight());
    dbms_output.put_line('image width: ' || cover_file.getWidth());
    dbms_output.put_line('image format: ' || cover_file.getContentFormat());
    dbms_output.put_line('image size: ' || cover_file.getContentLength());
  else
    dbms_output.put_line('Properties not set correctly');
  end if;
  dbms_output.put_line('');
  dbms_output.put_line('');
  

  album_name := 'Surrealismo';
  select cover into cover_file from albums where name = album_name;
  if (cover_file.checkProperties()) then
    dbms_output.put_line('Album: ' || album_name);
    dbms_output.put_line('image height: ' || cover_file.getHeight());
    dbms_output.put_line('image width: ' || cover_file.getWidth());
    dbms_output.put_line('image format: ' || cover_file.getContentFormat());
    dbms_output.put_line('image size: ' || cover_file.getContentLength());
  else
    dbms_output.put_line('Properties not set correctly');
  end if;
  dbms_output.put_line('');
  dbms_output.put_line('');
  
  
  album_name := '11 palos';
  select cover into cover_file from albums where name = album_name;
  if (cover_file.checkProperties()) then
    dbms_output.put_line('Album: ' || album_name);
    dbms_output.put_line('image height: ' || cover_file.getHeight());
    dbms_output.put_line('image width: ' || cover_file.getWidth());
    dbms_output.put_line('image format: ' || cover_file.getContentFormat());
    dbms_output.put_line('image size: ' || cover_file.getContentLength());
  else
    dbms_output.put_line('Properties not set correctly');
  end if;
  dbms_output.put_line('');
  dbms_output.put_line('');


end;
/

