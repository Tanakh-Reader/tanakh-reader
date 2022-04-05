import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../database/hb_db_helper.dart';

class HebrewPassage with ChangeNotifier {
  List<Word> _words = [];
  List<Verse> _verses = [];
  List<Clause> _clauses = [];
  List<Phrase> _phrases = [];
  Book? _book;
  bool hasSelection = false;

  List<Word> get words {
    return [..._words];
  }

  
  
  // Get all of the verses in the current passage. 
  List<Verse> get verses {
    // if (_verses.isEmpty && _words.isNotEmpty) {
      // Iterate over all words in passage from the first vsId to
      // the last vsId and group them into verses. 
      int currentVerseId = _words.first.vsIdBHS!;
      int lastVerseId = _words.last.vsIdBHS!;
      while (currentVerseId <= lastVerseId) {
        List<Word> verseWords = _words.where(
          (word) => word.vsIdBHS == currentVerseId).toList();
        _verses.add(
            Verse(
              id: currentVerseId,
              number: verseWords.first.vsBHS,
              words: verseWords
            )
        );
        currentVerseId = currentVerseId + 1;
      }
    // }
    return [..._verses];
  }

  // TODO fix these places where I use !!
  Book get book {
    _book = Books.books.firstWhereOrNull(
        (bk) => bk.id == _words.first.book);
    return _book!;
  }

  // Get the selected word in the current passage. 
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
  Future<void> getPassageWordsByRef(int book, int ch) async {
    _words = await HebrewDatabaseHelper().getWordsByBookChapter(book, ch);
    _verses = [];
    // _book = null;
    notifyListeners();
  }

  // Convert SQL data to your Dart Object.
  Future<void> getPassageWordsById(int startId, int endId) async {
    _words = await HebrewDatabaseHelper().getWordsByStartEndNode(startId, endId);
    notifyListeners();
  }
}

final hebrewPassageProvider = ChangeNotifierProvider<HebrewPassage>((ref) {
  return HebrewPassage();
});

final passageTextProvider = FutureProvider.autoDispose.family<HebrewPassage, Future>((ref, fxn) async {
  // final hebrewPassage = ref.watch(hebrewPassageProvider);
  await fxn;
  print("Finished");
  return ref.watch(hebrewPassageProvider);
});