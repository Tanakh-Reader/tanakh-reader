import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';



import 'data/models/user_vocab.dart';
import 'ui/screens/screens.dart';

import 'data/providers/hebrew_passage.dart';

void main() async {
  // https://www.optisolbusiness.com/insight/flutter-offline-storage-using-hive-database
  // Initialize hive before using any boxes.
  await Hive.initFlutter();
  // Open the peopleBox
  Hive.registerAdapter(UserVocabAdapter());
  await Hive.openBox<UserVocab>('userVocab');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => HebrewPassage()
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          body: Center(
            child: ReaderScreen(),
          ),
        ),
      ),
    );
  }
}