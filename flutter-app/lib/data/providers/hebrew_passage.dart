import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/constants.dart';

import '../database/user_data/passage.dart';
import '../models/models.dart';
import '../database/hebrew_bible_data/hb_db_helper.dart';


/// A class that holds all of the data for a passage.
/// It is used primarily with widgets in the read screen
/// where the user can engage with the data of the current
/// passage they are reading. 
class HebrewPassage with ChangeNotifier {

  List<Word> _words = [];
  // TODO --- consider where to implement sets instead of lists. 
  List<Lexeme> _lexemes = [];
  List<Verse> _verses = [];
  List<Clause> _clauses = [];
  List<Phrase> _phrases = [];
  Book? _book;
  Passage? _passage;
  // TODO -- temp / remove this.
  bool temp = false;
  bool hasSelection = false;
  bool isChapter = true;

  // Last verseId in the Hebrew bible. 
  int maxVsId = 23213;
  // Number of English verses to come before and after a
  // non-chapter passage.
  int pre = 3;
  int post = 2;

  /// Get the [Passage] instance.
  get passage {
    return _passage;
  }

  /// True if the passage has [Word] data. 
  get isLoaded {
    return _words.isNotEmpty;
  }

  /// Get all words in the current passage. 
  List<Word> get words {
    if (isChapter) {
      return [..._words];
    // If not a chapter, only return the words between the start
    // and end verse of the passage. 
    } else {
      return _words.where((w) => 
        w.vsIdBHS! >= _passage!.startVsId!
        && w.vsIdBHS! <= _passage!.endVsId!).toList();
    }
  }
  
  /// Get all unique [Lexeme] instances in the passage.
  List<Lexeme> get lexemes {
    return [..._lexemes];
  }

  /// Takes a lexeme id and returns a [Lexeme] instance.
  Lexeme lex(int lexId) {
    return _lexemes.firstWhere((lex) => lex.id == lexId);
  }

  /// Takes a word and returns a book.
  Book getBook(Word word) {
    return Books.books.firstWhere((book) => book.id == word.book);
  }
  
  /// Get all words before the passage's start verse, used
  /// to construct the English pre in the passage display. 
  List<Word>? get englishPre {
    if (!isChapter) {
      return _words.where((w) => 
        w.vsIdBHS! < _passage!.startVsId!).toList();
    }
  }
  

  /// Get all words after the passage's end verse, used
  /// to construct the English post in the passage display. 
  List<Word>? get englishPost {
    if (!isChapter) {
      return _words.where((w) => 
        w.vsIdBHS! > _passage!.endVsId!).toList();
    }
  }

  // TODO fix these places where I use !!
  Book get book {
    _book = Books.books.firstWhereOrNull(
        (bk) => bk.id == _words.first.book);
    return _book!;
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

  /// Takes a [Word]'s strongId and returns an instance of [Strongs]
  Future<List<Strongs>> getStrongs(Word word) async {
    List<Strongs> strongs = await HebrewDatabaseHelper().getStrongs(word);
    return strongs;
  }

  /// Takes a [Word]'s lexId and returns an example sentences with that lexeme. 
  Future<List<List<Word>>?> getLexSentences(Word word) async {
    List<List<Word>>? sentences = await HebrewDatabaseHelper().getLexSentences(word);
    return sentences;
  }


  /// Takes a book and chapter number and populates the [HebrewPassage]'s
  /// data. 
  Future<void> getPassageWordsByRef(int book, int ch) async {
    _passage = null;
    isChapter = true;
    // Query the SQL database for word nodes.
    _words = await HebrewDatabaseHelper().getWordsByBookChapter(book, ch);
    _lexemes = AllLexemes.getLexemesInPassage(words);
    _verses = [];
    notifyListeners();
  }

  /// Takes a start and end word id and populates the [HebrewPassage]'s
  /// data. 
  Future<void> getPassageWordsById(int startId, int endId) async {
    // Query the SQL database for word nodes.
    _words = await HebrewDatabaseHelper().getWordsByStartEndNode(startId, endId);
    _lexemes = AllLexemes.getLexemesInPassage(words);
    _verses = [];
    notifyListeners();
  }

  /// Takes a [Passage] instance and populates the [HebrewPassage]'s
  /// data. 
  Future<void> getPassageWordsByVsId({required Passage passage, withEnglish}) async {
    isChapter = false;
    // Save the passed in [Passage] in the HebrewPassage.
    _passage = passage; 
    int _pre = 0;
    int _post = 0;
    if (withEnglish) {
      // Check for < Genesis 1:7 and > Malachi 4:1.
      _pre = pre;
      _post = post;
      if (passage.startVsId! - pre < 1) {
        _pre = passage.startVsId! - 1;
      }
      if (passage.endVsId! + post > maxVsId) {
        _post = maxVsId - passage.endVsId!;
      }
    }
    // Query the SQL database for word nodes. 
    _words = await HebrewDatabaseHelper().getWordsByStartEndVsNode(
    startId: passage.startVsId!, endId: passage.endVsId!, pre: _pre, post: _post);
    _lexemes = AllLexemes.getLexemesInPassage(words);
    _verses = [];
    notifyListeners();
  }
}


/// A provider to track [HebrewPassage] data and update widget
/// displays when notified. 
final hebrewPassageProvider = ChangeNotifierProvider<HebrewPassage>((ref) {
  return HebrewPassage();
});

