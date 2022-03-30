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
  Future<Map<String, dynamic>> getItem(String table, int itemId) async {
    final db = await database;
    if (db == null) {
      throw "db is not initiated, initiate using [init(db)] function";
    }
    print('beginning query');
    final item = await db.query(
        table,
        columns: WordConstants().cols,
        where: 'id = ?',
        whereArgs: [itemId]
    );
    if (item != null) {
      return item.first;
    } else {
      throw Exception("$itemId Not found");
    }
  }

  Future<List<Book>> getBooks() async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final books = await db.query(
        BookConstants.table,
        orderBy: "${BookConstants.id} ASC");
    print('getBooks ${stopwatch.elapsed} to query');
    return books.map((json) => Book.fromJson(json)).toList();
  }

  Future<Lexeme> getLexeme(int id) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final lexeme = await db.query(
        LexemeConstants.table, 
        where: "${LexemeConstants.id} = ?", 
        whereArgs: [id]);
    print('getLexeme: ${stopwatch.elapsed} to query');
    return Lexeme.fromJson(lexeme.first);
  }

  Future<List<Lexeme>> getAllLexemes(int id) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final lexemes = await db.query(
        LexemeConstants.table,
        orderBy: "${LexemeConstants.text} ASC");
    print('getAllLexemes: ${stopwatch.elapsed} to query');
    return lexemes.map((json) => Lexeme.fromJson(json)).toList();
  }

  Future<List<Word>> getWordsByBookChapter(int book, int ch) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        where: "${WordConstants.book} = ? AND ${WordConstants.chKJV} = ?", 
        whereArgs: [book, ch],
        orderBy: "${WordConstants.id} ASC");
    print('getWordsByBookChapter: ${stopwatch.elapsed} to query');
    return words.map((json) => Word.fromJson(json)).toList();
  }

  Future<List<Word>> getWordsByStartEndNode(int startId, int endId) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        where: "${WordConstants.id} >= ? AND ${WordConstants.id} <= ?", 
        whereArgs: [startId, endId],
        orderBy: "${WordConstants.id} ASC");
    print('getWordsByStartEndNode: ${stopwatch.elapsed} to query');
    return words.map((json) => Word.fromJson(json)).toList();
  }

  // Interacting with other DB tables
  Future<List<Word>> testyTest(int startId, int endId) async {
    final stopwatch = Stopwatch()..start();
    final db = await database;
    final words = await db.query(
        WordConstants.table, 
        where: "${WordConstants.id} >= ? AND ${WordConstants.id} <= ?", 
        whereArgs: [startId, endId],
        orderBy: "${WordConstants.id} ASC");
    print('testyTest: ${stopwatch.elapsed} to query');
    var _words = words.map((json) => Word.fromJson(json)).toList();
    for (Word word in _words) {
      final lex = await db.query(
        LexemeConstants.table, 
        where: "${LexemeConstants.id} = ${WordConstants.lexId}");
      }
      // _lex = w
    return words.map((json) => Word.fromJson(json)).toList();
  }
}
