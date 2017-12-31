unit C_TEXTS;
interface

const
  LENGTH_FOLDERS_LIBX = 7;

  FOLDERS_LIBX_KMR_TEXT: Array[0..LENGTH_FOLDERS_LIBX - 1] of string =
  (
    'Game',
    'Single Maps',
    'Multiplayer Maps',
    'Downloaded Maps',
    'Battle Tutorial',
    'Town Tutorial',
    'Campaigns'
  );

  FOLDERS_LIBX_KMR     : Array[0..LENGTH_FOLDERS_LIBX - 1] of string =
  (
    'data\text\',
    'Maps\',
    'MapsMP\',
    'MapsDL\',
    'Tutorials\Battle Tutorial\',
    'Tutorials\Town Tutorial\',
    'Campaigns\'
  );

  FOLDERS_LIBX_KMR_BOOL: Array[0..LENGTH_FOLDERS_LIBX - 1] of boolean =
  (
    FALSE,
    TRUE,
    TRUE,
    TRUE,
    FALSE,
    FALSE,
    TRUE
  );


  TEXT_SEL_FILE           = 'Select File: %s';

  TEXT_INDEX_NAME_CMP     = 'CAMPAIGN NAME';

  TEXT_INDEX_SNAME_CMP    = 'SHORT CAMPAIGN NAME';

  TEXT_INDEX_INFO_CMP     = 'INFO CAMPAIGN';

  TEXT_INDEX_MISSION_CMP  = 'MISSION %s';

implementation

end.
