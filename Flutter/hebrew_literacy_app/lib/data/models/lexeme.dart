import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Lexeme {
  int? id;
  String? lang;
  String? speech;
  String? nameType;
  String? lexSet;
  String? text;
  String? gloss;
  int? freqLex;
  int? rankLex;
  // Strongs TO ADD
  // STEP gloss TO ADD

  Lexeme({
    required this.id,
    required this.lang,
    required this.speech,
    required this.nameType,
    required this.lexSet,
    required this.text,
    required this.gloss,
    required this.freqLex,
    required this.rankLex,
  });

  factory Lexeme.fromRawJson(String str) => Lexeme.fromJson(json.decode(str));
  
  factory Lexeme.fromJson(Map<String, dynamic> json) => Lexeme(
    id: json[LexemeConstants.id], 
    lang: json[LexemeConstants.lang],
    speech: json[LexemeConstants.speech],
    nameType: json[LexemeConstants.nameType],
    lexSet: json[LexemeConstants.lexSet],
    text: json[LexemeConstants.text],
    gloss: json[LexemeConstants.gloss],
    freqLex: json[LexemeConstants.freqLex],
    rankLex: json[LexemeConstants.rankLex],
  );
  
}