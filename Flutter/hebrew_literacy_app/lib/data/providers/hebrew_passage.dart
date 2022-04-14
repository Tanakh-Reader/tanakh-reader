import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';

import '../models/models.dart';
import '../database/hb_db_helper.dart';

class Passages {
  
  List<HebrewPassage> _passages = [];

  List<HebrewPassage> get passages {
    return [..._passages];
  }
  
  Future<void> loadPassages() async {
    _passages = [];
    var passages = await HebrewDatabaseHelper().getPassages();
    for (var p in passages) {
      var passage = HebrewPassage();
      await passage.getPassageWordsById(p.startWordId!, p.endWordId!);
      _passages.add(passage);
    }
  }

}

class HebrewPassage with ChangeNotifier {
  List<Word> _words = [];
  List<Lexeme> _lexemes = [];
  List<Verse> _verses = [];
  List<Clause> _clauses = [];
  List<Phrase> _phrases = [];
  Book? _book;
  bool hasSelection = false;
  List<Word> _joinedWords = [];

  List<Word> get words {
    return [..._words];
  }

  List<Lexeme> get lexemes {
    return [..._lexemes];
  }
  
  Lexeme lex(int lexId) {
    return _lexemes.firstWhere((lex) => lex.id == lexId);
  }

  // Get all of the verses in the current passage. 
  List<Verse> get verses {
    if (_verses.isNotEmpty) {
      return [..._verses];
    } else {
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
        currentVerseId += 1;
      }
    }
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

  // TODO Make cleaner
  List<Word> get joinedWords {
    _joinedWords = [];
    if (hasSelection) {
      for (var i = 0; i < _words.length; i++) {
        var j = i==0 ? i : i-1;
        if (words[i].isSelected) {
          while (words[j].trailer == null ) {
            j -= 1;
          }
          while (words[j+1].trailer == null) {
            _joinedWords.add(words[j+1]);
            j += 1;
          }
          _joinedWords.add(words[j+1]);
          break;
        }
      }
    }
    return [..._joinedWords];
  }

  void toggleWordSelection(Word word) {
    if (word.isSelected) {
      hasSelection = false;
    } else {
      hasSelection = true;
    }
    _words[
      _words.indexWhere((elem) => elem.id == word.id)
    ].toggleSelected();
    for (var w in _words) {
      if (w.isSelected && w.id != word.id) {
        w.toggleSelected();
      }
    }
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
    _lexemes = await HebrewDatabaseHelper().getSomeLexemes(book, ch, WordConstants.book);
    _verses = [];
    // _book = null;
    notifyListeners();
  }

  // Convert SQL data to your Dart Object.
  Future<void> getPassageWordsById(int startId, int endId) async {
    _words = await HebrewDatabaseHelper().getWordsByStartEndNode(startId, endId);
    _lexemes = await HebrewDatabaseHelper().getSomeLexemes(startId, endId, WordConstants.wordId);
    _verses = [];
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