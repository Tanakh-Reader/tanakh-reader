import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../database/hb_db_helper.dart';

class HebrewPassage with ChangeNotifier {
  List<Word> _words = [];
  List<Verse> _verses = [];
  List<Clause> _clauses = [];
  List<Phrase> _phrases = [];
  bool hasSelection = false;

  List<Word> get words {
    return [..._words];
  }
  
  List<Verse> get verses {
    if (_verses.isEmpty) {
      int? currentVerse = _words.first.vsBHS;
      int? endVerse = _words.last.vsBHS;
      while (currentVerse! <= endVerse!) {
        List<Word> verseWords = _words.where(
          (word) => word.vsBHS == currentVerse).toList();
        _verses.add(
            Verse(
              number: currentVerse,
              words: verseWords
            )
        );
        currentVerse = currentVerse + 1;
      }
    }
    return [..._verses];
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