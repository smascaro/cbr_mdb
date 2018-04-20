# cbr_mdb
Design and implement a multimedia database system for the chosen subject area.
## Usage:
1. In file **init.sql**  
  1.1. Run directory creation scripts as sysdba  
  1.2. Enable server output  
  1.3. (optional) use last queries in order to check if directories were created succesfully  
2. Run **table_creation.sql** script (tables will be created in a correct order)  
3. Run **data_initialization.sql** script (it might take some minutes as it needs to load more than 40 audio files)
4. Compile procedures and functions in **functionalities.sql** one by one in the same order they appear. The file contains test executions for each procedure, some pass and some don't.
