

import 'package:firebase_database/firebase_database.dart';

import '../../models/book.dart';

class FirebaseBibleDatabaseHelper {

  final DatabaseReference _ref = FirebaseDatabase.instance.ref('bible/');

  // Load all of the books in a list. 
  Future<List<Book>> getBooks() async {
    final event = await _ref.child('books/').once(DatabaseEventType.value);

    if (!event.snapshot.exists) {
      throw Exception('No book data');
    }

    final List<dynamic> bookList = event.snapshot.value as List<dynamic>;
    final List<Book> mappedBooks =
        bookList.map((json) => Book.fromJson(json)).toList();

  return mappedBooks;
}

  // // Get a single lexeme via its ID. 
  // Future<Lexeme> getLexeme(int id) async {
  //   final stopwatch = Stopwatch()..start();
  //   final db = await database;
  //   final lexeme = await db.query(
  //       LexemeConstants.table, 
  //       where: "${LexemeConstants.lexId} = ?", 
  //       whereArgs: [id]);
  //   print('getLexeme: ${stopwatch.elapsed} to query');
  //   return Lexeme.fromJson(lexeme.first);
  // }
  // Future<Object?> getUserByUserId(String userId) async {

  //   final snapshot = await _ref.child(userId).get();

  //   if (snapshot.exists) {
  //       return snapshot.value;
  //   } else {
  //       return null;
  //   }
  // }


}