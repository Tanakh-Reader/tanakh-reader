import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';

import '../models/models.dart';
import '../database/hb_db_helper.dart';


class TxtTheme {
  static var normColor = Colors.white;
  static var propNounColor = Colors.grey;
  static var unknownColor = Colors.blue[200];
  static var normWeight = FontWeight.normal;
  static var selWeight = FontWeight.bold;
  static var normSize = 28.0;
  static var verseSize = 16.0;
}

class TextDisplay with ChangeNotifier{
  bool paragraph = true;
  bool verse = true;
  bool clause = true;
  bool phrase = false;

  void updateGrouping(var group) {
    // grouping = group;
    notifyListeners();
  }
}

final textDisplayProvider = ChangeNotifierProvider<TextDisplay>((ref) {
  return TextDisplay();
});

