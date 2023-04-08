
import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Strongs {
  String? strongsId;
  String? lexeme;
  String? transliterationSTEP;
  String? morphCode;
  String? glossSTEP;
  String? definition;

  Strongs({
    required this.strongsId,
    required this.lexeme,
    required this.transliterationSTEP,
    required this.morphCode,
    required this.glossSTEP,
    required this.definition
  });

  factory Strongs.fromRawJson(String str) => Strongs.fromJson(json.decode(str));
  
  factory Strongs.fromJson(Map<String, dynamic> json) => Strongs(
    strongsId: json[StrongsConstants.strongsId], 
    lexeme: json[StrongsConstants.lexeme], 
    transliterationSTEP: json[StrongsConstants.transliterationSTEP], 
    morphCode: json[StrongsConstants.morphCode], 
    glossSTEP: json[StrongsConstants.glossSTEP],    
    definition: json[StrongsConstants.definition], 
  );

}