import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

import '../models/hebrew_word.dart';
import '../database/hebrew_bible_data/hebrew_word_data.dart';

class HebrewPassage with ChangeNotifier {
  List<HebrewWord> _words = [];
  bool hasSelection = false;

  List<HebrewWord> get words {
    return [..._words];
  }

   HebrewWord? get selectedWord {
    return _words.firstWhereOrNull(
      (word) => word.isSelected == true
    );
  }

  void toggleWordSelection(HebrewWord word) {
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
  Future<void> getHebrewWords() async {
    // final db = HebrewWordDataBaseHelper();
    _words = await HebrewWordDataBaseHelper().getHebrewWords();
    notifyListeners();
  }
}