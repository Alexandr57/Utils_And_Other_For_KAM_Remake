unit CONSTS;
interface

//---------------
//Общие константы
//---------------

const

  LANG_RUS = 'RUSSIAN';
  LANG_ENG = 'ENGLISH';

  EXT_FILE_LIBX = 'libx';
  EXT_FILE_LIBX_DOT = '.' + EXT_FILE_LIBX;

//--------------------------
//Константы для  Libx Editor
//--------------------------

const

  PATH_DATA_TEXT  = 'data\text\text.%s' + EXT_FILE_LIBX_DOT;
  PATH_CONST = 'KM_TextIDs.inc';

  POS_CMPPATH = 'campaigns\';

  POS_CMPFN   = '\text.%s' + EXT_FILE_LIBX_DOT;

  LENGTH_CMP_TEXT = 6;

  LENGTH_FOLDERS_LIBX = 7;

type

  TArrayFolders_String = Array[0..LENGTH_FOLDERS_LIBX - 1] of String;
  TArrayFolders_Integer = Array[0..LENGTH_FOLDERS_LIBX - 1] of Integer;
  TArrayFolders_BOOL = Array[0..LENGTH_FOLDERS_LIBX - 1] of Boolean;

const

  FOLDERS_LIBX_KMR_TEXT: TArrayFolders_String =
  (
    'Game',
    'Single Maps',
    'Multiplayer Maps',
    'Downloaded Maps',
    'Battle Tutorial',
    'Town Tutorial',
    'Campaigns'
  );

  FOLDERS_LIBX_KMR     : TArrayFolders_String =
  (
    'data\text\',
    'Maps\',
    'MapsMP\',
    'MapsDL\',
    'Tutorials\Battle Tutorial\',
    'Tutorials\Town Tutorial\',
    'Campaigns\'
  );

  SCAN_SUB_FOLDERS_LIBX_KMR_BOOL: TArrayFolders_BOOL =
  (
    FALSE,
    TRUE,
    TRUE,
    TRUE,
    FALSE,
    FALSE,
    TRUE
  );

  CNST_SEARCH_FILES: Array[0..38] of String =
  (
    'tsk',
    'tpr',
    'cmp',
    'tsk1',
    'tsk2',
    'tsk3',
    'tsk4',
    'tsk5',
    'tsk6',
    'tsk7',
    'tsk8',
    'tsk9',
    'tsk 1',
    'tsk 2',
    'tsk 3',
    'tsk 4',
    'tsk 5',
    'tsk 6',
    'tsk 7',
    'tsk 8',
    'tsk 9',
    'tpr1',
    'tpr2',
    'tpr3',
    'tpr4',
    'tpr5',
    'tpr6',
    'tpr7',
    'tpr8',
    'tpr9',
    'tpr 1',
    'tpr 2',
    'tpr 3',
    'tpr 4',
    'tpr 5',
    'tpr 6',
    'tpr 7',
    'tpr 8',
    'tpr 9'
  );

  REPLACE_SEARCH_FILES: Array[0..38] of String =
  (
    'The Shattered Kingdom',
    'The Peasants Rebellion',
    'Campaigns',
    'tsk01',
    'tsk02',
    'tsk03',
    'tsk04',
    'tsk05',
    'tsk06',
    'tsk07',
    'tsk08',
    'tsk09',
    'tsk01',
    'tsk01',
    'tsk01',
    'tsk01',
    'tsk01',
    'tsk01',
    'tsk01',
    'tsk01',
    'tsk01',
    'tpr01',
    'tpr02',
    'tpr03',
    'tpr04',
    'tpr05',
    'tpr06',
    'tpr07',
    'tpr08',
    'tpr09',
    'tpr01',
    'tpr02',
    'tpr03',
    'tpr04',
    'tpr05',
    'tpr06',
    'tpr07',
    'tpr08',
    'tpr09'
  );

  TEXT_SEL_FILE           = 'Select File: %s';

  TEXT_INDEX_NAME_CMP     = 'CAMPAIGN NAME';

  TEXT_INDEX_SNAME_CMP    = 'SHORT CAMPAIGN NAME';

  TEXT_INDEX_INFO_CMP     = 'INFO CAMPAIGN';

  TEXT_INDEX_HEADER_CMP   = 'HEADER CAMPAIGN';

  TEXT_INDEX_NULL_CMP     = 'NULL';

  TEXT_INDEX_MISSION_CMP  = 'MISSION %d';

  TEXT_INDEX = 'TEXT INDEX %d';

  TX_ERROR_LOAD_LANGS_KMR = 'ID_TX_ERROR_0';

  CT_ERROR_LOAD_LANGS_KMR = 'ID_CT_ERROR_0';

implementation

end.
