

import 'package:firebase_database/firebase_database.dart';

import '../../models/book.dart';
import '../../models/lexeme.dart';
import '../../models/strongs.dart';
import '../../models/word.dart';

// DOCS
// https://firebase.google.com/docs/firestore/query-data/queries#dart_11

class RealtimeBibleDatabaseHelper {

  // final DatabaseReference _ref = FirebaseDatabase.instance.ref('bible/');
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();


  // Load all of the books in a list. 
  Future<List<Book>> getBooks() async {

    // final snap = await _ref.child('books/').get();
    final event = await _ref.child('books/').once(DatabaseEventType.value);

    if (!event.snapshot.exists) {
      throw Exception('No book data');
    }
    final booksResults = event.snapshot.children;
    final List<Book> bookList =
        booksResults.map((json) => Book.fromJson(json.value as Map<String, dynamic>)).toList();
    return bookList;
  }

  // Get all words present in a chapter. 
  Future<List<Word>> getWordsByBookChapter(int book, int ch) async {
    
    final event = await _ref.child('bible/$book').once(DatabaseEventType.value);

    if (!event.snapshot.exists) {
      throw Exception('No chapter data');
    }
    final wordsResults = event.snapshot.children;
    final List<Word> words =
        wordsResults.map((json) => Word.fromJson(json.value as Map<String, dynamic>)).toList();
    return words;
    
  }

  /// Load all lexemes from the database in a [List] of 
  /// [Lexeme] objects. 
  Future<List<Lexeme>> getAllLexemes() async {

    final event = await _ref.child('lexemes/').once(DatabaseEventType.value);

    if (!event.snapshot.exists) {
      throw Exception('No lexemes data');
    }
    final lexemesResults = event.snapshot.children;
    final List<Lexeme> lexemeList =
        lexemesResults.map((json) => Lexeme.fromJson(json.value as Map<String, dynamic>)).toList();
    return lexemeList;

  }



  /// Take a [Word]'s strongsId and get the strong's data.
  Future<List<Strongs>> getStrongs(Word word) async {
    String strongsId = word.strongsId!;
    // Reformat string: H996 in the strongs table is H0996.
    switch (strongsId.length) {
      case 2: {
        strongsId = 'H000' + strongsId.substring(1,2);
        break;
      }
      case 3: {
        strongsId = 'H00' + strongsId.substring(1,3);
        break;
      }
      case 4: {
        strongsId = 'H0' + strongsId.substring(1,4);
        break;
      }
    }

    final event = await _ref.child('strongs/').once(DatabaseEventType.value);

    if (!event.snapshot.exists) {
      throw Exception('No strongs data');
    }
    final strongsResults = event.snapshot.children;
    final List<Strongs> strongsList =
        strongsResults.map((json) => Strongs.fromJson(json.value as Map<String, dynamic>)).toList();
    return strongsList;
  }



}