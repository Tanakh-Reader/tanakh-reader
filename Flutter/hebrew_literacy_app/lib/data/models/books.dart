import 'package:flutter/material.dart';
import 'models.dart';
import '../database/hb_db_helper.dart';

class Books {
  static late final List<Book> books;

  static Future<void> getBooks() async {
    books = await HebrewDatabaseHelper().getBooks();
  }
}