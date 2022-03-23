import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Book {
  int? id;
  String? osis; // OSIS abbreviation.
  String? leb; // LEB abbreviation.
  String? name; 
  String? tanakh; // Tanakh book name at id. 
  // List<Chapter>? chapters;

  Book({
    required this.id,
    required this.osis,
    required this.leb,
    required this.name,
    required this.tanakh,
  });

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));
  
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json[BookConstants.id], 
    osis: json[BookConstants.osis],
    leb: json[BookConstants.leb],
    name: json[BookConstants.name],
    tanakh: json[BookConstants.tanakh],
  );
  
}