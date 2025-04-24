import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/database/user_data/passage.dart';
import 'package:tanakhreader/data/database/user_data/settings.dart';
import 'package:tanakhreader/data/providers/passage.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'my_app.dart';
import 'data/database/user_data/vocab.dart';
import 'data/database/user_data/user.dart';
import 'data/models/models.dart';

import 'data/providers/providers.dart';

//https://bettercoding.dev/flutter/initialization-splash/

// https://www.optisolbusiness.com/insight/flutter-offline-storage-using-hive-database


// Delete app from simulator: rm -rf build

int PASSAGE_MODULE_SIZE = 100;

class Init {
  static Future initialize() async {
    await _registerServices();
    await _loadData();
  }

  static _registerServices() async {
    // await Hive.deleteBoxFromDisk('user');
    await Hive.initFlutter();
    Hive.registerAdapter(ReadingLevelAdapter());
    Hive.registerAdapter(VocabStatusAdapter());
    Hive.registerAdapter(VocabAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PassageAdapter());
    Hive.registerAdapter(SettingsAdapter());
    await Hive.openBox<Passage>('passage');
    await Hive.openBox<User>('user');
    await Hive.openBox<Settings>('settings');
    await Hive.openBox<Vocab>('vocab');
  }

  static _loadData() async {
    await Books.getBooks();
    await AllLexemes.loadAllLexemes();
    // PassageData().clearData();
    // await PassageData().initializePassages(PASSAGE_MODULE_SIZE);
  }
}