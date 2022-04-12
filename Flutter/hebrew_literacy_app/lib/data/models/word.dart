import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

// https://www.raywenderlich.com/22180993-flutter-code-generation-getting-started
// USE CODE GENERATORS
// ALSO THINK ABOUT USING GENERATOR TO STORE
// WORD DATA IN PASSAGE RENDORING TO SAVE MEMORY
class Word with ChangeNotifier {
  int? id;
  int? book;
  int? chKJV;
  int? vsKJV;
  int? vsIdKJV;
  int? chBHS;
  int? vsBHS;
  int? vsIdBHS;
  // String? lang;
  // String? speech;
  String? person;
  String? gender;
  String? number;
  String? vTense;
  String? vStem;
  String? state;
  String? prsPerson;
  String? prsGender;
  String? prsNumber;
  String? suffix;
  String? text;
  String? textCons;
  String? trailer;
  String? transliteration;
  String? glossExt;
  String? glossBSB;
  num? sortBSB;
  String? strongsId;
  int? lexId;
  int? phraseId;
  int? clauseAtomId;
  int? clauseId;
  int? sentenceId;
  int? freqOcc;
  int? rankOcc;
  String? poetryMarker;
  String? parMarker;

  bool isSelected = false;

  Word ({
    required this.id,
    required this.book,
    required this.chKJV,
    required this.vsKJV,
    required this.vsIdKJV,
    required this.chBHS,
    required this.vsBHS,
    required this.vsIdBHS,
    // required this.lang,
    // required this.speech,
    required this.person,
    required this.gender,
    required this.number,
    required this.vTense,
    required this.vStem,
    required this.state,
    required this.prsPerson,
    required this.prsGender,
    required this.prsNumber,
    required this.suffix,
    required this.text,
    required this.textCons,
    required this.trailer,
    required this.transliteration,
    required this.glossExt,
    required this.glossBSB,
    required this.sortBSB,
    required this.strongsId,
    required this.lexId,
    required this.phraseId,
    required this.clauseAtomId,
    required this.clauseId,
    required this.sentenceId,
    required this.freqOcc,
    required this.rankOcc,
    required this.poetryMarker,
    required this.parMarker,
  });

  void toggleSelected() {
    isSelected = !isSelected;
  }

  Map<String, String> stems = {
    'qal':  'Qal',
    'hif':  'Hiphil',
    'piel': 'Piel',
    'nif':  'Niphal',
    'hit':  'Hitpael',
    'pual': 'Pual',
    'hof':  'Hophal'
  };

  Map<String, String> tenses = {
      'perf': 'perfect',
      'impf': 'imperfect',
      'wayq': 'wayyiqtol',
      'ptca': 'participle active',
      'infc': 'infinitive construct',
      'impv': 'imperative',
      'ptcp': 'participle passive',
      'infa': 'infinitive absolute'
  };

  // https://blog.devgenius.io/adding-sqlite-db-file-from-the-assets-internet-in-flutter-3ec42c14cd44
  factory Word.fromRawJson(String str) => Word.fromJson(json.decode(str));
  
  factory Word.fromJson(Map<String, dynamic> json) => Word(
    id: json[WordConstants.wordId], 
    book: json[WordConstants.book], 
    chKJV: json[WordConstants.chKJV],
    vsKJV: json[WordConstants.vsKJV],
    vsIdKJV: json[WordConstants.vsIdKJV],
    chBHS: json[WordConstants.chBHS],
    vsBHS: json[WordConstants.vsBHS],
    vsIdBHS: json[WordConstants.vsIdBHS],
    // lang: json[WordConstants.lang],
    // speech: json[WordConstants.speech],
    person: json[WordConstants.person],
    gender: json[WordConstants.gender],
    number: json[WordConstants.number],
    vTense: json[WordConstants.vTense],
    vStem: json[WordConstants.vStem],
    state: json[WordConstants.state],
    prsPerson: json[WordConstants.prsPerson],
    prsGender: json[WordConstants.prsGender],
    prsNumber: json[WordConstants.prsNumber],
    suffix: json[WordConstants.suffix],
    text: json[WordConstants.text],
    textCons: json[WordConstants.textCons],
    trailer: json[WordConstants.trailer],
    transliteration: json[WordConstants.transliteration],
    glossExt: json[WordConstants.glossExt],
    glossBSB: json[WordConstants.glossBSB],
    sortBSB: json[WordConstants.sortBSB],
    strongsId: json[WordConstants.strongsId],
    lexId: json[WordConstants.lexId],
    phraseId: json[WordConstants.phraseId],
    clauseAtomId: json[WordConstants.clauseAtomId],
    clauseId: json[WordConstants.clauseId],
    sentenceId: json[WordConstants.sentenceId],
    freqOcc: json[WordConstants.freqOcc],
    rankOcc: json[WordConstants.rankOcc],
    poetryMarker: json[WordConstants.poetryMarker],
    parMarker: json[WordConstants.parMarker]
  );
  
}

class Passage {
  int? id;
  int? wordCount;
  num? weight;
  int? startWordId;
  int? endWordId;

  Passage({
    this.id,
    this.wordCount,
    this.weight,
    this.startWordId,
    this.endWordId
  });

  factory Passage.fromRawJson(String str) => Passage.fromJson(json.decode(str));
  
  factory Passage.fromJson(Map<String, dynamic> json) => Passage(
    id: json[PassageConstants.passageId],
    wordCount: json[PassageConstants.wordCount],
    weight: json[PassageConstants.weight],
    startWordId: json[PassageConstants.startWordId],
    endWordId: json[PassageConstants.endWordId]
  );
}