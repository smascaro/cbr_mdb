# cbr_mdb
Design and implement a multimedia database system for an online playlist manager. Save your favorite songs, create playlists and export them.  
## Files
In order to emulate exact system, it will be needed to download all audio files and keep them in a precise structure. The following link will download a compressed folder with the directory structure which includes:
  * 45 audio files
  * 4 album covers
  * samples of exported playlists  
  
[Download file (301 MB)](https://drive.google.com/open?id=1-Uwx_D9XZ76Y26z3ZgvD7whMsCk0b3-A)

## Usage:
1. In file **init.sql**  
  1.1. Run directory creation scripts as sysdba  
  1.2. Enable server output  
  1.3. (optional) use last queries in order to check if directories were created succesfully  
2. Run **table_creation.sql** script (tables will be created in a correct order)  
3. Run **data_initialization.sql** script (it might take some minutes as it needs to load more than 40 audio files)
4. Compile procedures and functions in **functionalities.sql** one by one in the same order they appear. The file contains test executions for each procedure, some pass and some don't.
