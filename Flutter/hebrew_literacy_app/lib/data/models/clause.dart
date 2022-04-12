import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Clause {
  String? id;
  String? domain;
  String? kind;
  String? number;
  String? relation;
  String? type;

  Clause({
    required this.id,
    required this.domain,
    required this.kind,
    required this.number,
    required this.relation,
    required this.type
  });
  
  factory Clause.fromRawJson(String str) => Clause.fromJson(json.decode(str));
  
  factory Clause.fromJson(Map<String, dynamic> json) => Clause(
    id: json[ClauseConstants.clauseId], 
    domain: json[ClauseConstants.domain], 
    kind: json[ClauseConstants.kind], 
    number: json[ClauseConstants.number],
    relation: json[ClauseConstants.relation], 
    type: json[ClauseConstants.clauseType], 
  );
  
}