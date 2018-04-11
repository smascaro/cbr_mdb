/* run as sysdba */
create or replace directory MEDIA_DIR AS '/home/oracle/mdb_cbr/music';
grant read,write on directory MEDIA_DIR to MDB;
commit;

create or replace directory IMAGES_DIR AS '/home/oracle/mdb_cbr/images';
grant read, write on directory IMAGES_DIR to MDB;
commit;

create or replace directory EXPORTS_DIR AS '/home/oracle/mdb_cbr/exports';
grant read, write on directory EXPORTS_DIR to MDB;
commit;
/* end run as sysdba */

/* enable output */
set serveroutput on;

/*check directories have been created succesfully*/
select * from dba_directories 
where directory_name = 'MEDIA_DIR' or directory_name = 'IMAGES_DIR' or directory_name = 'EXPORTS_DIR';



