import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Lexeme {
  int? id;
  String? language;
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
    required this.language,
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
    id: json[LexemeConstants.lexId], 
    language: json[LexemeConstants.language],
    speech: json[LexemeConstants.speech],
    nameType: json[LexemeConstants.nameType],
    lexSet: json[LexemeConstants.lexSet],
    text: json[LexemeConstants.lexText],
    gloss: json[LexemeConstants.gloss],
    freqLex: json[LexemeConstants.freqLex],
    rankLex: json[LexemeConstants.rankLex],
  );
  
}