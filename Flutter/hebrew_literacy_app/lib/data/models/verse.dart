import 'package:flutter/material.dart';
import 'chapter.dart';
import 'book.dart';
import 'word.dart';

class Verse {
  int? id;
  int? number;
  Book? book;
  Chapter? chapter;
  List<Word>? words;

  Verse({
    required this.number,
    // required this.book,
    // required this.chapter,
    required this.words
  });
}
