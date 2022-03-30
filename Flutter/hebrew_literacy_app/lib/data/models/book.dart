import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Book {
  int? id;
  int? chapters;
  String? abbrOSIS; // OSIS abbreviation.
  String? abbrLEB; // LEB abbreviation.
  String? name; 
  String? nameHeb;
  String? tanakhSort; // Tanakh book name at id. 

  Book({
    required this.id,
    required this.chapters,
    required this.abbrOSIS,
    required this.abbrLEB,
    required this.name,
    required this.nameHeb,
    required this.tanakhSort,
  });

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));
  
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json[BookConstants.id], 
    chapters: json[BookConstants.chapters],
    abbrOSIS: json[BookConstants.abbrOSIS],
    abbrLEB: json[BookConstants.abbrLEB],
    name: json[BookConstants.name],
    nameHeb: json[BookConstants.nameHeb],
    tanakhSort: json[BookConstants.tanakhSort],
  );
  
}