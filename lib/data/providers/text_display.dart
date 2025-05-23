import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanakhreader/data/constants.dart';

import '../models/models.dart';
import '../database/hebrew_bible_data/hb_db_helper.dart';


class TxtTheme {
  static var normColor = Colors.white;
  static var propNounColor = Colors.grey;
  static var unknownColor = Colors.blue[200];
  static var normWeight = FontWeight.normal;
  static var selWeight = FontWeight.bold;
  static var normSize = 28.0;
  static var verseSize = 16.0;


  // The default styling for a word, changed via copyWith. 
  static var hebrewStyle = GoogleFonts.notoSerifHebrew(
      color: TxtTheme.normColor,
      fontSize: TxtTheme.normSize,
      fontWeight: TxtTheme.normWeight,
  );
}

class TextDisplay with ChangeNotifier{
  bool paragraph = false;
  bool verse = true;
  bool clause = false;
  bool phrase = false;

  void toggleParagraph() {
    paragraph = !paragraph;
    notifyListeners();
  }
  void toggleVerse() {
    verse = !verse;
    notifyListeners();
  }
  void toggleClause() {
    clause = !clause;
    notifyListeners();
  }
  void togglePhrase() {
    phrase = !phrase;
    notifyListeners();
  }
  void updateGrouping(var group) {
    // grouping = group;
    notifyListeners();
  }
}

final textDisplayProvider = ChangeNotifierProvider<TextDisplay>((ref) {
  return TextDisplay();
});

