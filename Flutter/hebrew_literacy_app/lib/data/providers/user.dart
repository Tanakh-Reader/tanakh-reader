import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:hive/hive.dart';

import '../database/user_data/passage.dart';
import '../database/user_data/vocab.dart';
import '../models/models.dart';
import '../database/hebrew_bible_data/hb_db_helper.dart';

import '../database/user_data/user.dart';


/// A provider for the Hive [User] database. 
class UserData with ChangeNotifier {
  static final _boxName = 'user';
  var box = Hive.box<User>(_boxName);
  var passageBox = Hive.box<Passage>('passage');
  var vocabBox = Hive.box<Vocab>('vocab');
  bool loaded = false;
  
  /// Return true if the [Vocab] database is initialized.
  bool get isInitialized {
    return box.isNotEmpty;
  }
  
  String get name {
    return user.firstName;
  }

  String get email {
    return user.email;
  }

  DateTime get dateRegistered {
    return user.dateRegistered;
  }

  User get user {
    return box.values.first;
  }

  // See if the user has just signed up.
  bool justRegistered() {
    var minutesSinceRegistered = DateTime.now()
      .difference(dateRegistered).inMinutes;
    return minutesSinceRegistered <= 1;
  }

  void clearData() {
    box.deleteAll(box.keys);
    notifyListeners();
  }

  // TODO: why is this still here?
  void load() {
    loaded = true;
    notifyListeners();
  }

  int get wordsRead {
    final completedPassages = passageBox.values.where(
      (p) => p.completed).toList();
    if (completedPassages.isEmpty) {
      return 0;
    }
    var sum = completedPassages.map(
      (p) => p.wordCount).reduce((a, b) => a + b);
    print(sum);
    return sum;
  }

  int get wordsLearned {
    final wordsLearned = vocabBox.values.where(
      (lex) => lex.status == VocabStatus.known && lex.userUpdated == true);
    return wordsLearned.length;
  }

}


final userDataProvider = ChangeNotifierProvider<UserData>((ref) {
  return UserData();
});