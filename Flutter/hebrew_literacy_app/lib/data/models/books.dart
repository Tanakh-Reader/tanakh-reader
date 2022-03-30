import 'package:flutter/material.dart';
import 'models.dart';
import '../database/hb_db_helper.dart';

class Books {
  static List<Book> _books = [];

  static List<Book> get books {
    return [..._books];
  } 

  static Future<void> getBooks() async {
    _books = await HebrewDatabaseHelper().getBooks();
  }
}