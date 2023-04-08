import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Book {
  int id;
  int? chapters;
  String? abbrOSIS; // OSIS abbreviation.
  String? abbrLEB; // LEB abbreviation.
  String? name; 
  String? nameHeb;
  int? tanakhSort; // Tanakh book name at id. 

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
    id: json[BookConstants.bookId] is int ? json[BookConstants.bookId] : int.tryParse(json[BookConstants.bookId]), 
    chapters: json[BookConstants.chapters] is int ? json[BookConstants.chapters] : int.tryParse(json[BookConstants.chapters]),
    abbrOSIS: json[BookConstants.abbrOSIS],
    abbrLEB: json[BookConstants.abbrLEB],
    name: json[BookConstants.bookName],
    nameHeb: json[BookConstants.bookNameHeb],
    tanakhSort: json[BookConstants.tanakhSort] is int ? json[BookConstants.tanakhSort] : int.tryParse(json[BookConstants.tanakhSort]),
  );
  
}