// import 'package:collection/collection.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hebrew_literacy_app/data/constants.dart';
// import 'package:hebrew_literacy_app/data/providers/providers.dart';

// import '../models/models.dart';
// import '../database/hb_db_helper.dart';

// class Passages {
  
//   List<PassageText> _passages = [];

//   get passages {
//     return [..._passages];
//   }
  
//   Future<void> loadPassages() async {
//     _passages = [];
//     var passages = await HebrewDatabaseHelper().getPassages();
//     // TODO -- Fix DATA LATER nodes are misaligned
//     for (var p in passages) {
//       var passage = PassageText();
//       await passage.getPassageWordsByVsId(p);
//       _passages.add(passage);
//     }
//   }

// }

// /// A parent class that holds all of the data for a passage and 
// /// associated methods, especially for word selection.
// /// It is used primarily with widgets in the read screen
// /// where the user can engage with the data of the current
// /// passage they are reading. 
// class HebrewText with ChangeNotifier {
//   List<Word> _words = [];
//   List<Lexeme> _lexemes = [];
//   List<Verse> _verses = [];
//   List<Clause> _clauses = [];
//   List<Phrase> _phrases = [];
//   Book? _book;
//   bool hasSelection = false;
//   bool isChapter = true;

//   /// Get all words in the current passage. 
//   List<Word> get words {
//     return [..._words];
//   }
  
//   /// Get all lexemes in the current passage.
//   List<Lexeme> get lexemes {
//     return [..._lexemes];
//   }
  
//   /// Takes a lexeme id and returns the associated [Lexeme] object.
//   Lexeme lex(int lexId) {
//     return _lexemes.firstWhere((lex) => lex.id == lexId);
//   }

//   /// Get all verses in the current passage. 
//   List<Verse> get verses {
//     if (_verses.isNotEmpty) {
//       return [..._verses];
//     } else {
//       // Iterate over all words in passage from the first vsId to
//       // the last vsId and group them into verses. 
//       int currentVerseId = _words.first.vsIdBHS!;
//       int lastVerseId = _words.last.vsIdBHS!;
//       while (currentVerseId <= lastVerseId) {
//         List<Word> verseWords = _words.where(
//           (word) => word.vsIdBHS == currentVerseId).toList();
//         _verses.add(
//             Verse(
//               id: currentVerseId,
//               number: verseWords.first.vsBHS,
//               words: verseWords
//             )
//         );
//         currentVerseId += 1;
//       }
//     }
//     return [..._verses];
//   }


//   // TODO fix these places where I use !!
//   Book get book {
//     _book = Books.books.firstWhereOrNull(
//         (bk) => bk.id == _words.first.book);
//     return _book!;
//   }


//   // #############################################################################
//   // Methods dealing with selected items in the passage.

//   /// Get the selected word in the current passage. 
//   Word? get selectedWord {
//     return _words.firstWhereOrNull(
//       (word) => word.isSelected == true
//     );
//   }

//   /// Get the words that are joined to the currently selected word. 
//   /// For example, in the construct וְלַחֹ֖שֶׁךְ, if חֹ֖שֶׁךְ is the selected word,
//   /// [joinedWords] will return a list with the [Word] objects for וְ ,לַ, and חֹ֖שֶׁךְ.
//   List<Word> get joinedWords {
//     List<Word> _joinedWords = [];
//     // Only populate the list if the passage has a selected word. 
//     if (hasSelection) {
//       // Iterate over _words until we reach the selected word. 
//       for (var i = 0; i < _words.length; i++) {
//         if (_words[i].isSelected) {
//           // Index j is set to 0 if i is 0, otherwise to i - 1. 
//           var j = (i==0) ? 0 : i-1;
//           // Travel to words preceding the selection while their trailer is null,
//           // until we find the index of the first word joined to the selection.
//           while (j >= 0 && _words[j].trailer == null ) {
//             j -= 1;
//           }
//           // Update j to be the index of the first joined word.
//           j += 1;
//           // Travel from the first joined word to the last joined word and
//           // add them to _joinedWords. 
//           while (j < _words.length && _words[j].trailer == null) {
//             _joinedWords.add(_words[j]);
//             j += 1;
//           }
//           // Add the last joined word, which does not have a null trailer. 
//           _joinedWords.add(_words[j]);
//           break;
//         }
//       }
//     }
//     return [..._joinedWords];
//   }

//   /// Get the phrase of the passage's selected word. 
//   Phrase? get selectedPhrase {
//     if (selectedWord != null) {
//       var _phrase = _phrases.firstWhereOrNull(
//         (phr) => phr.id == selectedWord!.phraseId);
//       return _phrase;
//     }
//     return null;
//   }

//   /// Get the clause of the passage's selected word.
//   Clause? get selectedClause {
//     if (selectedWord != null) {
//       var _clause = _clauses.firstWhereOrNull(
//         (cl) => cl.id == selectedWord!.clauseId);
//       return _clause;
//     }
//     return null;
//   }

//   /// Takes a [Word] and toggles its isSelected attribute
//   /// to either true or false. 
//   void toggleWordSelection(Word word) {
//     // Update whether or not this passage has a selected word. 
//     if (word.isSelected) {
//       // If the passed in word is selected, we'll be deselecting it
//       // and should therefore indicate hasSelection as false.
//       hasSelection = false;
//     } else {
//       // If a user taps on a new word without deselecting the currently selected word,
//       // there will be 2+ selected words. Therefore we iterate over _words and
//       // ensure that any other selected word gets deselected. 
//       if (hasSelection) deselectOtherWords(word);
//       hasSelection = true;
//     }
//     // Find the passed in word in _words and toggle its
//     // isSelected between true and false.
//     var curIndex = _words.indexWhere((w) => w.id == word.id);
//     _words[curIndex].toggleSelected();
//     notifyListeners();
//   }

//   /// Takes [Word] and deselects all other words in passage. 
//   void deselectOtherWords(word) {
//     for (var w in _words) {
//       if (w.isSelected && w.id != word.id) {
//         w.toggleSelected();
//       }
//     }
//   }

//   /// Deselects all words in passage. 
//   /// Called when the user navigates away from the current passage. 
//   /// For example, when switching to the home screen. 
//   void deselectWords() {
//     for (var w in _words) {
//       if (w.isSelected) {
//         w.toggleSelected();
//       }
//     }
//     hasSelection = false;
//     notifyListeners();
//   }



//   // Convert SQL data to your Dart Object.
//   Future<void> getPassageWordsById(int startId, int endId) async {
//     _words = await HebrewDatabaseHelper().getWordsByStartEndNode(startId, endId);
//     // _lexemes = await HebrewDatabaseHelper().getSomeLexemes(startId, endId, WordConstants.wordId);
//     _lexemes = AllLexemes.getLexemesInPassage(words);
//     _verses = [];
//     notifyListeners();
//   }

// }



// class ChapterText extends HebrewText {
  
//   Future<void> getPassageWordsByRef(int book, int ch) async {
//     _words = await HebrewDatabaseHelper().getWordsByBookChapter(book, ch);
//     // _lexemes = await HebrewDatabaseHelper().getSomeLexemes(book, ch, WordConstants.book);
//     _lexemes = AllLexemes.getLexemesInPassage(words);
//     _verses = [];
//     // _book = null;
//     notifyListeners();
//   }
// }


// class PassageText extends HebrewText {
//   // Last verseId in the Hebrew bible. 
//   int maxVsId = 23213;
//   // Number of English verses to come before and after.
//   int pre = 5;
//   int post = 5;
//   late final Passage passage;

//   @override 
//   get words {
//     return _words.where((w) => 
//       w.vsIdBHS! >= passage.startVsId!
//       && w.vsIdBHS! <= passage.endVsId!).toList();
//   }

//   get englishPre {
//     return _words.where((w) => 
//       w.vsIdBHS! < passage.startVsId!).toList();
//   }

//   get englishPost {
//     return _words.where((w) => 
//       w.vsIdBHS! > passage.endVsId!).toList();
//   }

//   // Convert SQL data to your Dart Object.
//   Future<void> getPassageWordsByVsId(Passage passage) async {
//     // Initit
//     this.passage = passage; 
//     // Check for < Genesis 1:7 and > Malachi 4:1.
//     if (passage.startVsId! - pre < 1) {
//       pre = passage.startVsId! - 1;
//     }
//     if (passage.endVsId! + post > maxVsId) {
//       post = maxVsId - passage.endVsId!;
//     }

//     _words = await HebrewDatabaseHelper().getWordsByStartEndVsNode(
//       passage.startVsId!, passage.endVsId!, pre, post);
//     _lexemes = AllLexemes.getLexemesInPassage(words);
//     _verses = [];
//     notifyListeners();
//   }
// }



// class HebrewTextController extends ChangeNotifier {
//   var chapter;
//   var passage;
//   var parent;

//   HebrewTextController({
//     required this.chapter,
//     required this.passage,
//     required this.parent
//   });

//   void toggle() {
//     chapter.isChapter = !chapter.isChapter;
//     notifyListeners();
//   }

//   // get passage {
//   //   return isChapter ? ChapterText() : PassageText();
//   // }
// }




// final hebrewTextProvider = ChangeNotifierProvider<HebrewText>((ref) {
//   return HebrewText();
// });

// final passageTextProvider = ChangeNotifierProvider<PassageText>((ref) {
//   return PassageText();
// });

// final chapterTextProvider = ChangeNotifierProvider<ChapterText>((ref) {
//   return ChapterText();
// });


// final hebrewPassageProvider = ChangeNotifierProvider<HebrewTextController>((ref) {
//   var parent = ref.read(hebrewTextProvider);
//   var chapter = ref.read(chapterTextProvider);
//   var passage = ref.read(passageTextProvider);
//   return HebrewTextController(
//     parent: parent,
//     chapter: chapter,
//     passage: passage
//   );
// });