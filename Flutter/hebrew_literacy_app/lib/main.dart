import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/screens/screens.dart';

import 'data/providers/hebrew_passage.dart';

void main() {
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