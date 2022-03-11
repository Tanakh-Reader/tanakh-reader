import 'dart:convert';

import 'package:flutter/material.dart';

class HebrewWord with ChangeNotifier {
  /* Consider also adding st (state), ls (lexical set) */
  int? id; // _id
  int? freqLex; // freq_lex
  String? consText; // g_cons_utf8
  String? pointedText; // g_word_utf8
  String? trailer; // trailer_utf8
  String? gloss; // gloss
  String? gender; // gn
  String? number; // nu
  String? person; // ps
  String? speech; // sp
  String? vbStem; // vs
  String? vbTense; // vt
  bool isSelected = false;

  HebrewWord ({
    required this.id,
    required this.freqLex,
    required this.consText,
    required this.pointedText,
    required this.trailer,
    required this.gloss,
    required this.gender,
    required this.number,
    required this.person,
    required this.speech,
    required this.vbStem,
    required this.vbTense
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
  factory HebrewWord.fromRawJson(String str) => HebrewWord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HebrewWord.fromJson(Map<String, dynamic> json) => HebrewWord(
    id: json["_id"],
    freqLex: json["freq_lex"],
    consText: json["g_cons_utf8"],
    pointedText: json["g_word_utf8"],
    trailer: json["trailer_utf8"],
    gloss: json['gloss'],
    gender: json["gn"],
    number: json["nu"],
    person: json["ps"],
    speech: json["sp"],
    vbStem: json["vs"],
    vbTense: json["vt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "freq_lex": freqLex,
    "g_cons_utf8": consText,
    "g_word_utf8": pointedText,
    "trailer_utf8": trailer,
    "gloss": gloss,
    "gn": gender,
    "nu": number,
    "ps": person,
    "sp": speech,
    "vs": vbStem,
    "vt": vbTense,
  };
  
}

Map<String, String> bookNames = {
    "1": "Genesis",
    "2": "Exodus",
    "3": "Leviticus",
    "4": "Numbers",
    "5": "Deuteronomy",
    "6": "Joshua",
    "7": "Judges",
    "8": "Ruth",
    "9": "1 Samuel",
    "10": "2 Samuel",
    "11": "1Kings",
    "12": "2Kings",
    "13": "1 Chronicles",
    "14": "2 Chronicles",
    "15": "Ezra",
    "16": "Nehemiah",
    "17": "Esther",
    "18": "Job",
    "19": "Psalms",
    "20": "Proverbs",
    "21": "Ecclesiastes",
    "22": "Song of Songs",
    "23": "Isaiah",
    "24": "Jeremiah",
    "25": "Lamentations",
    "26": "Ezekiel",
    "27": "Daniel",
    "28": "Hosea",
    "29": "Joel",
    "30": "Amos",
    "31": "Obadiah",
    "32": "Jonah",
    "33": "Micah",
    "34": "Nahum",
    "35": "Habakkuk",
    "36": "Zephaniah",
    "37": "Haggai",
    "38": "Zechariah",
    "39": "Malachi"
};

Map<String, String> standardAbbreviationENG = {
    "1": "Gen",
    "2": "Exod",
    "3": "Lev",
    "4": "Num",
    "5": "Deut",
    "6": "Josh",
    "7": "Judg",
    "8": "Ruth",
    "9": "1Sam",
    "10": "2Sam",
    "11": "1Kgs",
    "12": "2Kgs",
    "13": "1Chr",
    "14": "2Chr",
    "15": "Ezra",
    "16": "Neh",
    "17": "Esth",
    "18": "Job",
    "19": "Ps",
    "20": "Prov",
    "21": "Eccl",
    "22": "Song",
    "23": "Isa",
    "24": "Jer",
    "25": "Lam",
    "26": "Ezek",
    "27": "Dan",
    "28": "Hos",
    "29": "Joel",
    "30": "Amos",
    "31": "Obad",
    "32": "Jonah",
    "33": "Mic",
    "34": "Nah",
    "35": "Hab",
    "36": "Zeph",
    "37": "Hag",
    "38": "Zech",
    "39": "Mal"
};