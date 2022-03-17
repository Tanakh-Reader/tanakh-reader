import 'package:flutter/material.dart';
import 'word.dart';

class Lexeme {
  int? id;
  int? freqLex; // freq_lex
  String? consText; // g_cons_utf8
  String? pointedText; // g_word_utf8
  String? gloss; // gloss
  String? gender; // gn
  String? speech; // sp
  String? vbStem; // vs
  bool isSelected = false;
}