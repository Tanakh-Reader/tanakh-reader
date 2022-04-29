import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'my_app.dart';
import 'data/database/user_data/vocab.dart';
import 'data/database/user_data/user.dart';
import 'data/models/models.dart';

import 'data/providers/providers.dart';
// Delete app from simulator: rm -rf build
void main() async {
  // https://www.optisolbusiness.com/insight/flutter-offline-storage-using-hive-database
  // Initialize hive before using any boxes.
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('user');
  // await Hive.deleteBoxFromDisk('vocab');
  Hive.registerAdapter(ReadingLevelAdapter());
  Hive.registerAdapter(VocabStatusAdapter());
  Hive.registerAdapter(VocabAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('user');
  // print(Hive.box<User>('user').path);
  await Hive.openBox<Vocab>('vocab');
  // print(Hive.box<Vocab>('vocab').values);
  // await Hive.box('user').deleteFromDisk();
  // await Hive.box('vocab').deleteFromDisk();
  await Books.getBooks();
  // TODO: possibly load into a Box and check if box is empty, i.e. only call first time app opened.
  await AllLexemes.loadAllLexemes();
  // ** RiverPod treats Models like Singeltons: https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
  // "Note that we’re defining a builder that creates a new instance of SomeModel. 
  // ChangeNotifierProvider is smart enough not to rebuild SomeModel unless absolutely 
  // is no longer needed."
  runApp(ProviderScope(child: MyApp()));
}