import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class ClauseAtom {
  int? id;
  String? code;
  String? paragraph;
  String? tab;
  String? type;

  ClauseAtom({
    required this.id,
    required this.code,
    required this.paragraph,
    required this.tab,
    required this.type,
  });

  factory ClauseAtom.fromRawJson(String str) => ClauseAtom.fromJson(json.decode(str));
  
  factory ClauseAtom.fromJson(Map<String, dynamic> json) => ClauseAtom(
    id: json[ClauseAtomConstants.clauseAtomId], 
    code: json[ClauseAtomConstants.code],
    paragraph: json[ClauseAtomConstants.paragraph],
    tab: json[ClauseAtomConstants.tab],
    type: json[ClauseAtomConstants.clauseAtomType],
  );
  
}