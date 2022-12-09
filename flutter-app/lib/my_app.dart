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
import 'utils/authentication.dart';


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
            child: FutureBuilder(
                future: AuthService.initializeFirebaseUser(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return SignInScreen();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  );
                },
              ),
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
