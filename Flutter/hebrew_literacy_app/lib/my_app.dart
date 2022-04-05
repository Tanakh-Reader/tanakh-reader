import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'data/models/user_vocab.dart';
import 'data/models/models.dart';

import 'ui/screens/screens.dart';
import 'data/providers/providers.dart';
import 'ui/views.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => HebrewPassage(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TabManager())
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Views(),
          ),
        ),
        routes: {
          // HomeScreen.routeName: (ctx) => HomeScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ReadScreen.routeName: (ctx) => ReadScreen(),
          VocabScreen.routeName: (ctx) => VocabScreen()
        },
      ),
    );
  }
}
