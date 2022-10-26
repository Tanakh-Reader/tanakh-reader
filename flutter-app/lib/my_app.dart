import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/providers/user.dart';
import 'package:tanakhreader/ui/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'data/database/user_data/vocab.dart';
import 'data/models/models.dart';

import 'ui/screens/screens.dart';
import 'data/providers/providers.dart';
import 'ui/views.dart';
import 'data/database/user_data/user.dart';
import 'ui/screens/sign_in_screen.dart';


class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(userDataProvider);
    final tabManager = ref.read(tabManagerProvider);
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: SignInScreen()
            // userData.isInitialized
            //   ? Views()
            //   : RegisterScreen()
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
