import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class WeightedPassage {
  int? id;
  int? wordCount;
  num? weight;
  int? startVsId;
  int? endVsId;
  int? bookId;
  Set<int> chapters = {};
  int? startVs;
  int? endVs;
  bool? isChapter;
  Set<int>? lexIds;
  List<String>? sampleText;

  


  WeightedPassage({
    this.id,
    this.wordCount,
    this.weight,
    this.startVsId,
    this.endVsId
  });

  factory WeightedPassage.fromRawJson(String str) => WeightedPassage.fromJson(json.decode(str));
  
  factory WeightedPassage.fromJson(Map<String, dynamic> json) => WeightedPassage(
    id: json[PassageConstants.passageId],
    wordCount: json[PassageConstants.wordCount],
    weight: json[PassageConstants.weight],
    startVsId: json[PassageConstants.startVsId],
    endVsId: json[PassageConstants.endVsId]
  );
}