import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

// https://www.raywenderlich.com/22180993-flutter-code-generation-getting-started
// USE CODE GENERATORS
// ALSO THINK ABOUT USING GENERATOR TO STORE
// WORD DATA IN PASSAGE RENDORING TO SAVE MEMORY
class Word with ChangeNotifier {
  int id;
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

  // https://blog.devgenius.io/adding-sqlite-db-file-from-the-assets-internet-in-flutter-3ec42c14cd44
  factory Word.fromRawJson(String str) => Word.fromJson(json.decode(str));
  
  factory Word.fromJson(Map<String, dynamic> json) => Word(
    id: json[WordConstants.wordId] is int ? json[WordConstants.wordId] : int.tryParse(json[WordConstants.wordId]), 
    book: json[WordConstants.book] is int ? json[WordConstants.book] : int.tryParse(json[WordConstants.book]), 
    chKJV: json[WordConstants.chKJV] is int ? json[WordConstants.chKJV] : int.tryParse(json[WordConstants.chKJV]),
    vsKJV: json[WordConstants.vsKJV] is int ? json[WordConstants.vsKJV] : int.tryParse(json[WordConstants.vsKJV]),
    vsIdKJV: json[WordConstants.vsIdKJV] is int ? json[WordConstants.vsIdKJV] : int.tryParse(json[WordConstants.vsIdKJV]),
    chBHS: json[WordConstants.chBHS] is int ? json[WordConstants.chBHS] : int.tryParse(json[WordConstants.chBHS]),
    vsBHS: json[WordConstants.vsBHS] is int ? json[WordConstants.vsBHS] : int.tryParse(json[WordConstants.vsBHS]),
    vsIdBHS: json[WordConstants.vsIdBHS] is int ? json[WordConstants.vsIdBHS] : int.tryParse(json[WordConstants.vsIdBHS]),
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
    sortBSB: json[WordConstants.sortBSB] is num ? json[WordConstants.sortBSB] : num.tryParse(json[WordConstants.sortBSB]),
    strongsId: json[WordConstants.strongsId],
    lexId: json[WordConstants.lexId] is int ? json[WordConstants.lexId] : int.tryParse(json[WordConstants.lexId]),
    phraseId: json[WordConstants.phraseId] is int ? json[WordConstants.phraseId] : int.tryParse(json[WordConstants.phraseId]),
    clauseAtomId: json[WordConstants.clauseAtomId] is int ? json[WordConstants.clauseAtomId] : int.tryParse(json[WordConstants.clauseAtomId]),
    clauseId: json[WordConstants.clauseId] is int ? json[WordConstants.clauseId] : int.tryParse(json[WordConstants.clauseId]),
    sentenceId: json[WordConstants.sentenceId] is int ? json[WordConstants.sentenceId] : int.tryParse(json[WordConstants.sentenceId]),
    freqOcc: json[WordConstants.freqOcc] is int ? json[WordConstants.freqOcc] : int.tryParse(json[WordConstants.freqOcc]),
    rankOcc: json[WordConstants.rankOcc] is int ? json[WordConstants.rankOcc] : int.tryParse(json[WordConstants.rankOcc]),
    poetryMarker: json[WordConstants.poetryMarker],
    parMarker: json[WordConstants.parMarker]
  );
  
}