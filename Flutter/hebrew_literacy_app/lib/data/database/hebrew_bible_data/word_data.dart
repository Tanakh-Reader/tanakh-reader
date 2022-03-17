import 'dart:io' as io;

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../models/word.dart';


// https://blog.devgenius.io/adding-sqlite-db-file-from-the-assets-internet-in-flutter-3ec42c14cd44
class HebrewWordDataBaseHelper {
  // final _dbName = 'bhsa.sqlite';
  final _dbName = 'bhsa_words.db';
  final _dbVersion = 1; 
  Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      print('db not null');
      return _db!;
    }
    print('entering initDB');
    _db = await _initDB(); // only initialize if not created already
    return _db!;
  }

  Future<Database> _initDB() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    print('dir loaded: $applicationDirectory');
    String dbPath =
        path.join(applicationDirectory.path, _dbName);

    print('dbPath loaded: $dbPath');
    bool dbExists = await io.File(dbPath).exists();

    if (!dbExists) {
      // Copy from asset
      print('collecting bytes');
      ByteData data = await rootBundle.load(path.join("assets/db", _dbName));
      print("bytes loaded");
      print("length: ${data.lengthInBytes}");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(dbPath, version: _dbVersion);
  }


  // get all the words from Hebrew db
  Future<List<Word>> getHebrewWords() async {
    final db = await database;
    if (db == null) {
      throw "db is not initiated, initiate using [init(db)] function";
    }
    List<Map<String, dynamic>>? words;
    print('beginning query');
    await db.transaction((txn) async {
      words = await txn.query(
        "word",
        columns: [
          "_id",
          "freq_lex",
          "g_cons_utf8",
          "g_word_utf8",
          "trailer_utf8",
          "gloss",
          "gn",
          "nu",
          "ps",
          "sp",
          "vs",
          "vt"
        ],
        where: '_id < 300'
      );
    });
    print('query finished');
    return words!.map((e) => Word.fromJson(e)).toList();
  }
}