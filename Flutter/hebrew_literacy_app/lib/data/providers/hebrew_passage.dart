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
    // TODO -- Fix DATA LATER nodes are misaligned
    for (var p in passages) {
      var passage = HebrewPassage();
      await passage.getPassageWordsById(p.startWordId!, p.endWordId!);
      _passages.add(passage);
    }
  }

}


/// A class that holds all of the data for a passage.
/// It is used primarily with widgets in the read screen
/// where the user can engage with the data of the current
/// passage they are reading. 
class HebrewPassage with ChangeNotifier {
  List<Word> _words = [];
  List<Lexeme> _lexemes = [];
  List<Verse> _verses = [];
  List<Clause> _clauses = [];
  List<Phrase> _phrases = [];
  Book? _book;
  bool hasSelection = false;

  /// Get all words in the current passage. 
  List<Word> get words {
    return [..._words];
  }
  
  List<Lexeme> get lexemes {
    return [..._lexemes];
  }
  
  Lexeme lex(int lexId) {
    return _lexemes.firstWhere((lex) => lex.id == lexId);
  }

  /// Get all verses in the current passage. 
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


  // #############################################################################
  // Methods dealing with selected items in the passage.

  /// Get the selected word in the current passage. 
  Word? get selectedWord {
    return _words.firstWhereOrNull(
      (word) => word.isSelected == true
    );
  }

  /// Get the words that are joined to the currently selected word. 
  /// For example, in the construct וְלַחֹ֖שֶׁךְ, if חֹ֖שֶׁךְ is the selected word,
  /// [joinedWords] will return a list with the [Word] objects for וְ ,לַ, and חֹ֖שֶׁךְ.
  List<Word> get joinedWords {
    List<Word> _joinedWords = [];
    // Only populate the list if the passage has a selected word. 
    if (hasSelection) {
      // Iterate over _words until we reach the selected word. 
      for (var i = 0; i < _words.length; i++) {
        if (_words[i].isSelected) {
          // Index j is set to 0 if i is 0, otherwise to i - 1. 
          var j = (i==0) ? 0 : i-1;
          // Travel to words preceding the selection while their trailer is null,
          // until we find the index of the first word joined to the selection.
          while (j >= 0 && _words[j].trailer == null ) {
            j -= 1;
          }
          // Update j to be the index of the first joined word.
          j += 1;
          // Travel from the first joined word to the last joined word and
          // add them to _joinedWords. 
          while (j < _words.length && _words[j].trailer == null) {
            _joinedWords.add(_words[j]);
            j += 1;
          }
          // Add the last joined word, which does not have a null trailer. 
          _joinedWords.add(_words[j]);
          break;
        }
      }
    }
    return [..._joinedWords];
  }

  /// Get the phrase of the passage's selected word. 
  Phrase? get selectedPhrase {
    if (selectedWord != null) {
      var _phrase = _phrases.firstWhereOrNull(
        (phr) => phr.id == selectedWord!.phraseId);
      return _phrase;
    }
    return null;
  }

  /// Get the clause of the passage's selected word.
  Clause? get selectedClause {
    if (selectedWord != null) {
      var _clause = _clauses.firstWhereOrNull(
        (cl) => cl.id == selectedWord!.clauseId);
      return _clause;
    }
    return null;
  }

  /// Takes a [Word] and toggles its isSelected attribute
  /// to either true or false. 
  void toggleWordSelection(Word word) {
    // Update whether or not this passage has a selected word. 
    if (word.isSelected) {
      // If the passed in word is selected, we'll be deselecting it
      // and should therefore indicate hasSelection as false.
      hasSelection = false;
    } else {
      // If a user taps on a new word without deselecting the currently selected word,
      // there will be 2+ selected words. Therefore we iterate over _words and
      // ensure that any other selected word gets deselected. 
      if (hasSelection) deselectOtherWords(word);
      hasSelection = true;
    }
    // Find the passed in word in _words and toggle its
    // isSelected between true and false.
    var curIndex = _words.indexWhere((w) => w.id == word.id);
    _words[curIndex].toggleSelected();
    notifyListeners();
  }

  /// Takes [Word] and deselects all other words in passage. 
  void deselectOtherWords(word) {
    for (var w in _words) {
      if (w.isSelected && w.id != word.id) {
        w.toggleSelected();
      }
    }
  }

  /// Deselects all words in passage. 
  /// Called when the user navigates away from the current passage. 
  /// For example, when switching to the home screen. 
  void deselectWords() {
    for (var w in _words) {
      if (w.isSelected) {
        w.toggleSelected();
      }
    }
    hasSelection = false;
    notifyListeners();
  }


  // #############################################################################
  // Methods dealing the Hebrew Database.

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



class AllLexemes {
  static late final List<Lexeme> lexemes;

  static Future<void> loadAllLexemes() async {
    lexemes = await HebrewDatabaseHelper().getAllLexemes();
  }
}