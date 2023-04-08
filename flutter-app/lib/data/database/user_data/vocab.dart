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

  // True if the user updated the lexeme's status. 
  // Used to track user-updated vocab vs auto-updated vocab. 
  @HiveField(2)
  bool? userUpdated;


  // *** Saved vocabulary data.
  @HiveField(3)
  bool saved = false;

  @HiveField(4)
  DateTime? dateSaved;

  // Word ids saved with this lexeme.
  @HiveField(5)
  List<int> wordInstanceIds = [];

  // English definitions save with this lexeme.
  @HiveField(6)
  List<String> definitions = [];

  // True if this lexeme has been exported. 
  @HiveField(7)
  bool exported = false;


  // *** Misc data.
  // How many times a user tapped this vocab word. 
  @HiveField(8)
  int tapCount = 0;

  @HiveField(9)
  DateTime? latestTap;

  // How many times a user accessed gloss for a known word.
  @HiveField(10)
  int glossTapCount = 0;


  Vocab({
    required this.lexId,
    required this.status,
  });
}