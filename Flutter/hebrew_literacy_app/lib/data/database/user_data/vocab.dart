import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'vocab.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 2)
enum VocabStatus {
  @HiveField(0)
  unkown,
  @HiveField(1)
  learning,
  @HiveField(2)
  known
}

@HiveType(typeId: 1)
class Vocab extends HiveObject {

  @HiveField(0)
  late int lexId;

  @HiveField(1)
  late VocabStatus status;

  @HiveField(2)
  late bool saved;

  @HiveField(3)
  late int tapCount;

  @HiveField(4)
  DateTime? latestTap;

  Vocab({
    required this.lexId,
    required this.status,
    required this.saved,
    required this.tapCount,
    this.latestTap
  });
}