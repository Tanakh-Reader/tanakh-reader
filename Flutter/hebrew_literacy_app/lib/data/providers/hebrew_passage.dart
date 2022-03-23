import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

import '../models/word.dart';
import '../database/hb_db_helper.dart';

class HebrewPassage with ChangeNotifier {
  List<Word> _words = [];
  bool hasSelection = false;

  List<Word> get words {
    return [..._words];
  }

  Word? get selectedWord {
    return _words.firstWhereOrNull(
      (word) => word.isSelected == true
    );
  }

  void toggleWordSelection(Word word) {
    hasSelection = !hasSelection;
    _words[
      _words.indexWhere((elem) => elem.id == word.id)
    ].toggleSelected();
    
    notifyListeners();
  }

  void deselectWord() {
    if (selectedWord != null) {
      toggleWordSelection(selectedWord!);
    }
  }

  // Convert SQL data to your Dart Object.
  Future<void> getHebrewWords(int startId, int endId) async {
    _words = await HebrewDatabaseHelper().getWordsByStartEndNode(startId, endId);
    notifyListeners();
  }
}