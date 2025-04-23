import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants.dart';
part 'word.g.dart';

@HiveType(typeId: 7)
class Word extends HiveObject {
    @HiveField(0)
    late int id;
    @HiveField(1)
    int? book;
    @HiveField(2)
    int? chKJV;
    @HiveField(3)
    int? vsKJV;
    @HiveField(4)
    int? vsIdKJV;
    @HiveField(5)
    int? chBHS;
    @HiveField(6)
    int? vsBHS;
    @HiveField(7)
    int? vsIdBHS;
    // String? lang;
    // String? speech;
    @HiveField(8)
    String? person;
    @HiveField(9)
    String? gender;
    @HiveField(10)
    String? number;
    @HiveField(11)
    String? vTense;
    @HiveField(12)
    String? vStem;
    @HiveField(13)
    String? state;
    @HiveField(14)
    String? prsPerson;
    @HiveField(15)
    String? prsGender;
    @HiveField(16)
    String? prsNumber;
    @HiveField(17)
    String? suffix;
    @HiveField(18)
    String? text;
    @HiveField(19)
    String? textCons;
    @HiveField(20)
    String? trailer;
    @HiveField(21)
    String? transliteration;
    @HiveField(22)
    String? glossExt;
    @HiveField(23)
    String? glossBSB;
    @HiveField(24)
    num? sortBSB;
    @HiveField(25)
    String? strongsId;
    @HiveField(26)
    int? lexId;
    @HiveField(27)
    int? phraseId;
    @HiveField(28)
    int? clauseAtomId;
    @HiveField(29)
    int? clauseId;
    @HiveField(30)
    int? sentenceId;
    @HiveField(31)
    int? freqOcc;
    @HiveField(32)
    int? rankOcc;
    @HiveField(33)
    String? poetryMarker;
    @HiveField(34)
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