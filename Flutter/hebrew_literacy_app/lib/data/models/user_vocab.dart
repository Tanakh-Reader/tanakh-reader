import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'user_vocab.g.dart';

// flutter packages pub run build_runner build
enum Status {
  unkown,
  learning,
  known
}

@HiveType(typeId: 0)
class UserVocab extends HiveObject {

  @HiveField(0)
  int? lexId;

  @HiveField(1)
  int? status;

  @HiveField(2)
  int? tapCount;
}