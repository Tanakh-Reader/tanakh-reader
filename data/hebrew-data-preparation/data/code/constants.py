import os 
from pathlib import Path


PROJECT_ROOT = 'Hebrew-Literacy-App'
STEP_DIR = 'STEP-Bible'
CLEAR_DIR = 'Clear-Bible'


class PATHS:

    CONSTANTS_FULL_PATH = Path(__file__)
    PROJECT_ROOT_FULL_PATH = [p for p in CONSTANTS_FULL_PATH.parents if p.parts[-1]==PROJECT_ROOT][0]
    
    HEBREW_DATA_PATH = 'data/hebrew-data-preparation'
    HEBREW_DATA_FULL_PATH = os.path.join(PROJECT_ROOT_FULL_PATH, HEBREW_DATA_PATH)
    HEBREW_DATA_DATA_FULL_PATH = os.path.join(HEBREW_DATA_FULL_PATH, 'data')
    HEBREW_DATA_SOURCES_FULL_PATH = os.path.join(HEBREW_DATA_FULL_PATH, 'sources')
    HEBREW_DATA_CODE_FULL_PATH = os.path.join(HEBREW_DATA_FULL_PATH, 'code')

    STEP_CORE_SOURCE_DATA_PATH = 'step/step-core-data/src/main/resources/com/tyndalehouse/step/core/data/create'
    STEP_BIBLE_SOURCE_DATA_PATH = 'STEPBible-Data'

    STEP_CORE_SOURCE_DATA_FULL_PATH = os.path.join(HEBREW_DATA_SOURCES_FULL_PATH, STEP_DIR, STEP_CORE_SOURCE_DATA_PATH)
    STEP_BIBLE_SOURCE_DATA_FULL_PATH = os.path.join(HEBREW_DATA_SOURCES_FULL_PATH, STEP_DIR, STEP_BIBLE_SOURCE_DATA_PATH)

    STEP_DATA_DEST_FULL_PATH = os.path.join(HEBREW_DATA_DATA_FULL_PATH, STEP_DIR)


class STEP_CORPORA:

    CORPORA_PREFIX = 'TOTHT'
    CORPORA_OG_HEADER = ['Ref in Heb', 'Eng ref', 'Pointed', 'Accented', 'Morphology', 'Extended Strongs']

    ID_ATTR = 'id'
    HEB_REF_ATTR = 'hebrewRef'
    ENG_REF_ATTR = 'englishRef'
    TEXT_ATTR = 'text'
    LEX_ATTR = 'lex'
    TRAILER_ATTR = 'trailer'
    MORPH_ATTR = 'morph'
    GLOSS_ATTR = 'gloss'
    SENSE_GLOSS_ATTR = 'senseGloss'
    STRONGS_ATTR = 'strongs'
    TRAILER_STRONGS_ATTR = 'trailerStrongs'

    CORPORA_HEADER = [
        HEB_REF_ATTR, 
        ENG_REF_ATTR, 
        TEXT_ATTR, 
        LEX_ATTR,
        TRAILER_ATTR, 
        MORPH_ATTR,
        GLOSS_ATTR, 
        SENSE_GLOSS_ATTR, 
        STRONGS_ATTR, 
        TRAILER_STRONGS_ATTR
    ]

    WRITE_FILE_UNFORMATTED = 'translators-hebrew-OT-unformatted.csv'
    WRITE_FILE_FORMATTED = 'translators-hebrew-OT.csv'
    WRITE_FILE_FORMATTED_WITH_QERE = 'translators-hebrew-OT-with-qere.csv'
