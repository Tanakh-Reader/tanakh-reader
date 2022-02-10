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

