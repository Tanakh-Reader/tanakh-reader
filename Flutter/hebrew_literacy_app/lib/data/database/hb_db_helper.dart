import 'dart:io' as io;

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../constants.dart';
import '../models/models.dart';

// https://blog.devgenius.io/adding-sqlite-db-file-from-the-assets-internet-in-flutter-3ec42c14cd44
class HebrewDatabaseHelper {
  final _dbName = 'bhsa4c_custom.db';
  final _dbVersion = 1; 
  Database? _db;

  // Load the DB if it's initialized, else initialize it. 
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDB();
    return _db!;
  }

  // Initialize the DB and write to android memory. 
  Future<Database> _initDB() async {
    // Android application path.
    // io.Directory applicationDirectory =
    //     await getApplicationDocumentsDirectory();
    // String dbPath =
    //     path.join(applicationDirectory.path, _dbName);
    
    // Get path to system directory. 
    final dbDirectory = await getDatabasesPath();
    final dbPath = path.join(dbDirectory, _dbName);
    bool dbExists = await io.File(dbPath).exists();

    if (!dbExists) {
      // Copy the DB into android storage from assets.
      ByteData data = await rootBundle.load(path.join("assets/db", _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }
   
    return await openDatabase(dbPath, version: _dbVersion);
  }


  // Get an item from the DB.
  // Future<Map<String, dynamic>> getItem(String table, int itemId) async {
  //   final db = await database;
  //   if (db == null) {
  //     throw "db is not initiated, initiate using [init(db)] function";
  //   }
  //   print('beginning query');
  //   final item = await db.query(
  //       table,
  //       columns: WordConstants().cols,
  //       where: 'id = ?',
  //       whereArgs: [itemId]
  //   );
  //   if (item != null) {
  //     return item.first;
  //   } else {
  //     throw Exception("$itemId Not found");
  //   }
  // }

  // Load all of the books in a list. 
  Future<List<Book>> getBooks() async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final books = await db.query(
        BookConstants.table,
        orderBy: "${BookConstants.bookId} ASC");
    print('getBooks ${stopwatch.elapsed} to query');
    return books.map((json) => Book.fromJson(json)).toList();
  }

  // Get a single lexeme via its ID. 
  Future<Lexeme> getLexeme(int id) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final lexeme = await db.query(
        LexemeConstants.table, 
        where: "${LexemeConstants.lexId} = ?", 
        whereArgs: [id]);
    print('getLexeme: ${stopwatch.elapsed} to query');
    return Lexeme.fromJson(lexeme.first);
  }

  /// Takes arg1 and arg1 and col
  // startId and endId may be a book and chapter. 
  Future<List<Lexeme>> getSomeLexemes(int arg1, int arg2, String col) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    // A dictionary that maps a column input to a WHERE statement.
    // If the input is book, then get the whole chapter, otherwise if wordId, get the result between two nodes. 
    String? where = {
      WordConstants.book: 'WHERE ${WordConstants.table}.${WordConstants.book} = $arg1 AND ${WordConstants.table}.${WordConstants.chBHS} = $arg2',
      WordConstants.wordId: 'WHERE ${WordConstants.table}.${WordConstants.wordId} >= $arg1 AND ${WordConstants.table}.${WordConstants.wordId} <= $arg2'
    }[col];
    // Lexeme columns to return from the joined lex-word table. 
    String columns = LexemeConstants.cols.map((col) => LexemeConstants.table + '.' + col).toList().join(', ');
    final _lexemes = await db.rawQuery(
      """SELECT $columns
      FROM ${LexemeConstants.table}
      INNER JOIN ${WordConstants.table} ON ${WordConstants.table}.${WordConstants.lexId}=${LexemeConstants.table}.${LexemeConstants.lexId}
      $where""");
    print('getSomeLexemes: ${stopwatch.elapsed} to query');
    List<Lexeme> lexemes = _lexemes.map((json) => Lexeme.fromJson(json)).toList();
    // Eliminate duplicates.
    final ids = Set();
    lexemes.retainWhere((x) => ids.add(x.id));
    return lexemes;
  }


  /// Load all lexemes from the database in a [List] of 
  /// [Lexeme] objects. 
  Future<List<Lexeme>> getAllLexemes() async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final lexemes = await db.query(
        LexemeConstants.table,
        orderBy: "${LexemeConstants.lexText} ASC");
    print('getAllLexemes: ${stopwatch.elapsed} to query');
    return lexemes.map((json) => Lexeme.fromJson(json)).toList();
  }

  // Get all words present in a chapter. 
  Future<List<Word>> getWordsByBookChapter(int book, int ch) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        where: "${WordConstants.book} = ? AND ${WordConstants.chKJV} = ?", 
        whereArgs: [book, ch],
        orderBy: "${WordConstants.wordId} ASC");
    print('getWordsByBookChapter: ${stopwatch.elapsed} to query');
    return words.map((json) => Word.fromJson(json)).toList();
  }

  // Get all words present between two nodes (inclusive). 
  Future<List<Word>> getWordsByStartEndNode(int startId, int endId) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        where: "${WordConstants.wordId} >= ? AND ${WordConstants.wordId} <= ?", 
        whereArgs: [startId, endId],
        orderBy: "${WordConstants.wordId} ASC");
    print('getWordsByStartEndNode: ${stopwatch.elapsed} to query');
    return words.map((json) => Word.fromJson(json)).toList();
  }

  // Get all words present between two verses (inclusive). 
  Future<List<Word>> getWordsByStartEndVsNode(int startId, int endId, int pre, int post) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        where: "${WordConstants.vsIdBHS} >= ? AND ${WordConstants.vsIdBHS} <= ?", 
        whereArgs: [startId-pre, endId+post],
        orderBy: "${WordConstants.wordId} ASC");
    print('getWordsByStartEndVsNode: ${stopwatch.elapsed} to query');
    return words.map((json) => Word.fromJson(json)).toList();
  }

  // Get all words present between two nodes (inclusive). 
  Future<List<Word>> getAllWords() async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        orderBy: "${WordConstants.wordId} ASC");
    print('getAllWords: ${stopwatch.elapsed} to query');
    return words.map((json) => Word.fromJson(json)).toList();
  }

  // Interacting with other DB tables
  Future<List<Lexeme>> testyTest(int startId, int endId) async {
    final stopwatch = Stopwatch()..start();
    print('start');
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        where: "${WordConstants.wordId} >= ? AND ${WordConstants.wordId} <= ?", 
        whereArgs: [startId, endId],
        orderBy: "${WordConstants.wordId} ASC");
    var _words = words.map((json) => Word.fromJson(json)).toList();
    List<Lexeme> lexemes = [];
    for (Word word in _words) {
      final lex = await db.query(
        LexemeConstants.table, 
        where: "${LexemeConstants.lexId} = ${word.lexId}");
      lexemes.add(Lexeme.fromJson(lex.first));
    }
    print('testyTest: ${stopwatch.elapsed} to query');
    return lexemes;
  }

  // Get lex clause examples for a selected word.
  Future<List<List<Word>>?> getLexSentences(Word word) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    String columns = WordConstants.cols.map((col) => WordConstants.table + '.' + col).toList().join(', ');
    final _words = await db.rawQuery(
      """SELECT $columns
      FROM ${LexSentenceConstants.table}
      INNER JOIN ${WordConstants.table} ON ${LexSentenceConstants.table}.${LexSentenceConstants.sentenceId}=${WordConstants.table}.${WordConstants.sentenceId}
      WHERE ${LexSentenceConstants.table}.${LexSentenceConstants.lexId} = ${word.lexId}
      ORDER BY ${LexSentenceConstants.sentenceWeight} ASC""");
    print('getLexClauses: ${stopwatch.elapsed} to query');
    if (_words.isEmpty) {
      return null;
    }
    // Create a list of lists, each list being a clause.
    List<Word> words = _words.map((json) => Word.fromJson(json)).toList();
    List<List<Word>> lexClauses = [];
    List<Word> lexClause = [];
    int clauseId = words.first.clauseId!;
    for (var _word in words) {
      // Don't add the clause of the indexed word.
      if (word.clauseId == clauseId) {
        continue;
      }
      else if (_word.clauseId == clauseId) {
        lexClause.add(_word);
      } else {
        lexClauses.add(lexClause);
        lexClause = [];
        clauseId = _word.clauseId!;
      }
    }
    // print(lexClauses.first.map((e) => (e.text?? '') + (e.trailer?? '')).toList().join(''));
    return lexClauses;
  }

  // Get passages
  Future<List<Passage>> getPassages() async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final passages = await db.rawQuery(
        """SELECT *
        FROM ${PassageConstants.table}
        LIMIT 5""");
    print('getPassage: ${stopwatch.elapsed} to query');
    return passages.map((json) => Passage.fromJson(json)).toList();
  }

}
