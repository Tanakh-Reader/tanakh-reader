import 'package:hebrew_literacy_app/ui/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'data/database/user_data/vocab.dart';
import 'data/models/models.dart';

import 'ui/screens/screens.dart';
import 'data/providers/providers.dart';
import 'ui/views.dart';
import 'data/database/user_data/user.dart';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // vocabBox = 
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            // child: RegisterScreen()
            child: Views(),
          ),
        ),
        routes: {
          // HomeScreen.routeName: (ctx) => HomeScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ReadScreen.routeName: (ctx) => ReadScreen(),
          VocabScreen.routeName: (ctx) => VocabScreen()
        },
    );
  }
}
