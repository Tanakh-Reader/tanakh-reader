import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';

class Passage {
  int? id;
  int? wordCount;
  num? weight;
  int? startVsId;
  int? endVsId;

  Passage({
    this.id,
    this.wordCount,
    this.weight,
    this.startVsId,
    this.endVsId
  });

  factory Passage.fromRawJson(String str) => Passage.fromJson(json.decode(str));
  
  factory Passage.fromJson(Map<String, dynamic> json) => Passage(
    id: json[PassageConstants.passageId],
    wordCount: json[PassageConstants.wordCount],
    weight: json[PassageConstants.weight],
    startVsId: json[PassageConstants.startVsId],
    endVsId: json[PassageConstants.endVsId]
  );
}