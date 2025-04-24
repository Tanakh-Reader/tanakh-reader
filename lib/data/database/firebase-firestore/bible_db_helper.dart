

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/book.dart';
import '../../models/lexeme.dart';
import '../../models/strongs.dart';
import '../../models/word.dart';

// DOCS
// https://firebase.google.com/docs/firestore/query-data/queries#dart_11

class FirestoreBibleDatabaseHelper {

  // final DatabaseReference _ref = FirebaseDatabase.instance.ref('bible/');
  final FirebaseFirestore _db = FirebaseFirestore.instance;



  // Load all of the books in a list. 
  Future<List<Book>> getBooks() async {

    final ref = _db.collection('books').doc('data');

    return ref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final books = (data['books'] as List<dynamic>).cast<Map<String, dynamic>>();
        return books.map((json) => Book.fromJson(json)).toList();
      },
      onError: (e) => print("Error getting document: $e"),
    );

  }

  // Get all words present in a chapter. 
  Future<List<Word>> getWordsByBookChapter(int book, int ch) async {
    
    final ref = _db.collection('bible').doc(book.toString()).collection('chapters').doc(ch.toString());
    
    return ref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final words = (data['words'] as List<dynamic>).cast<Map<String, dynamic>>();
        return words.map((json) => Word.fromJson(json)).toList();
      },
      onError: (e) => print("Error getting document: $e"),
    );

  }

  /// Load all lexemes from the database in a [List] of 
  /// [Lexeme] objects. 
  Future<List<Lexeme>> getAllLexemes() async {

    final ref = _db.collection('lexemes').doc('data');
        
    return ref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final lexemes = (data['lexemes'] as List<dynamic>).cast<Map<String, dynamic>>();
        return lexemes.map((json) => Lexeme.fromJson(json)).toList();
      },
      onError: (e) => print("Error getting document: $e"),
    );
    
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

    final ref = _db.collection('strongs').doc(strongsId);
    
    // TODO -- how to match LIKE -- where: "${StrongsConstants.strongsId} LIKE ?", 
    // for instances e.g., H9888a
    ref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return [ Strongs.fromJson(data) ];
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return []; 
  }



}