
import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Phrase {
  int? id;
  String? determined;
  String? function;
  String? number;
  String? type;

  Phrase({
    required this.id,
    required this.determined,
    required this.function,
    required this.number,
    required this.type
  });

  factory Phrase.fromRawJson(String str) => Phrase.fromJson(json.decode(str));
  
  factory Phrase.fromJson(Map<String, dynamic> json) => Phrase(
    id: json[PhraseConstants.id], 
    determined: json[PhraseConstants.determined], 
    function: json[PhraseConstants.function], 
    number: json[PhraseConstants.number], 
    type: json[PhraseConstants.type],     
  );
}