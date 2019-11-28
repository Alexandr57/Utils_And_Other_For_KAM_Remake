unit C_TEXTS;
interface

uses KM_Defaults;

const
  EXT_FILE_LIBX_DOT = '.libx';

  PATH_TEXT  = 'data\text\text.%s' + EXT_FILE_LIBX_DOT;
  PATH_CONST = 'KM_TextIDs.inc';

  CMPPATH_1 = 'campaigns\';
  CMPPATH_2 = '\text.%s' + EXT_FILE_LIBX_DOT;

  LENGTH_NULL_CMP_TEXT = 6;

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

  SCAN_SUB_FOLDERS_LIBX_KMR_BOOL: Array[0..LENGTH_FOLDERS_LIBX - 1] of boolean =
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

  TEXT_INDEX_HEADER_CMP   = 'HEADER CAMPAIGN';

  TEXT_INDEX_NULL_CMP     = 'NULL';

  TEXT_INDEX_MISSION_CMP  = 'MISSION %d';

  TEXT_INDEX = 'TEXT INDEX %d';

implementation

end.
