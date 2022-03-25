class WordConstants {

  static String table = 'word';

  static String id = 'id';
  static String book = 'book';
  static String chKJV = 'chKJV';
  static String vsKJV = 'vsKJV';
  static String vsIdKJV = 'vsIdKJV';
  static String chBHS = 'chBHS';
  static String vsBHS = 'vsBHS';
  static String vsIdBHS = 'vsIdBHS';
  static String lang = 'lang';
  static String speech = 'speech';
  static String person = 'person';
  static String gender = 'gender';
  static String number = 'number';
  static String vTense = 'vTense';
  static String vStem = 'vStem';
  static String state = 'state';
  static String prsPerson = 'prsPerson';
  static String prsGender = 'prsGender';
  static String prsNumber = 'prsNumber';
  static String suffix = 'suffix';
  static String text = 'text';
  static String textCons = 'textCons';
  static String trailer = 'trailer';
  static String transliteration = 'transliteration';
  static String glossExt = 'glossExt';
  static String glossBSB = 'glossBSB';
  static String sortBSB = 'sortBSB';
  static String strongs = 'strongs';
  static String lexId = 'lexId';
  static String phraseId = 'phraseId';
  static String clauseAtomId = 'clauseAtomId';
  static String clauseId = 'clauseId';
  static String sentenceId = 'sentenceId';
  static String freqOcc = 'freqOcc';
  static String rankOcc = 'rankOcc';
  static String poetryMarker = 'poetryMarker';
  static String parMarker = 'parMarker';

  List<String> cols = [
    id,
    book,
    chKJV,
    vsKJV,
    vsIdKJV,
    chBHS,
    vsBHS,
    vsIdBHS,
    lang,
    speech,
    person,
    gender,
    number,
    vTense,
    vStem,
    state,
    prsPerson,
    prsGender,
    prsNumber,
    suffix,
    text,
    textCons,
    trailer,
    transliteration,
    glossExt,
    glossBSB,
    sortBSB,
    strongs,
    lexId,
    phraseId,
    clauseAtomId,
    clauseId,
    sentenceId,
    freqOcc,
    rankOcc,
    poetryMarker,
    parMarker,
  ];
}


class LexemeConstants {

  static String table = 'lex';

  static String id = 'id';
  static String lang = 'lang';
  static String speech = 'speech';
  static String nameType = 'nameType';
  static String lexSet = 'lexSet';
  static String text = 'lex'; // NOTE
  static String gloss = 'gloss';
  static String freqLex = 'freqLex';
  static String rankLex = 'rankLex';
  
  List<String> cols = [
    id,
    lang,
    speech,
    nameType,
    lexSet,
    text,
    gloss,
    freqLex,
    rankLex
  ];
}


class PhraseConstants {

  static String table = 'phrase';

  static String id = 'id';
  static String determined = 'determined';
  static String function = 'function';
  static String number = 'number';
  static String type = 'type';
  
  List<String> cols = [
    id,
    determined,
    function,
    number,
    type
  ];
}


class ClauseAtomConstants {

  static String table = 'clauseAtom';

  static String id = 'id';
  static String code = 'code';
  static String paragraph = 'paragraph';
  static String tab = 'tab';
  static String type = 'type';
  
  List<String> cols = [
    id,
    code,
    paragraph,
    tab,
    type
  ];
}


class ClauseConstants {

  static String table = 'clause';

  static String id = 'id';
  static String domain = 'domain';
  static String kind = 'kind';
  static String number = 'number';
  static String relation = 'relation';
  static String type = 'type';
  
  List<String> cols = [
    id,
    domain,
    kind,
    number,
    relation,
    type
  ];
}


class BookConstants {

  static String table = 'book';

  static String id = 'id';
  static String osis = 'osis';
  static String leb = 'leb';
  static String name = 'name';
  static String tanakh = 'tanakh';

  List<String> cols = [
    id,
    osis,
    leb,
    name,
    tanakh
  ];
}
