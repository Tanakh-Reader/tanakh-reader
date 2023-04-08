import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'passage.g.dart';

@HiveType(typeId: 5)
class Passage extends HiveObject {

  @HiveField(0)
  late int passageId;

  @HiveField(1)
  late int wordCount;

  @HiveField(2)
  num? weight;

  @HiveField(3)
  int? startVsId;

  @HiveField(4)
  int? endVsId;
  
  @HiveField(5)
  late int bookId;

  @HiveField(6)
  List<int> chapters = [];

  @HiveField(7)
  late int startVs;

  @HiveField(8)
  late int endVs;

  @HiveField(9)
  bool isChapter = false;

  // True if the passage was opened.
  @HiveField(10)
  bool visited = false;

  @HiveField(11)
  bool completed = false;
  
  @HiveField(12)
  DateTime? dateCompleted;

  // Time to complete in seconds
  @HiveField(13)
  int? secondsToComplete;

  @HiveField(14)
  int timesRead = 0;

  @HiveField(15)
  List<int> lexIds = [];

  @HiveField(16)
  List<String>? sampleText;

  
  // Vocab({
  //   required this.lexId,
  //   required this.status,
  //   required this.saved,
  //   required this.tapCount,
  // });
}