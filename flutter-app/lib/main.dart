import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/database/user_data/passage.dart';
import 'package:tanakhreader/data/database/user_data/settings.dart';
import 'package:tanakhreader/data/providers/passage.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'data_init.dart';
import 'my_app.dart';
import 'data/database/user_data/vocab.dart';
import 'data/database/user_data/user.dart';
import 'data/models/models.dart';

import 'data/providers/providers.dart';
import 'splash_screen.dart';

// TODO -- firebase dependencies:
// https://firebase.google.com/docs/flutter/setup?platform=ios

//https://bettercoding.dev/flutter/initialization-splash/

// https://www.optisolbusiness.com/insight/flutter-offline-storage-using-hive-database

// TODO : implement https://api.flutter.dev/flutter/foundation/kIsWeb-constant.html
// for managing web vs app deployment. 
void main() async { 

  // ** RiverPod treats Models like Singeltons: https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
  // "Note that we’re defining a builder that creates a new instance of SomeModel. 
  // ChangeNotifierProvider is smart enough not to rebuild SomeModel unless absolutely 
  // is no longer needed."
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: 
    const FirebaseOptions(
      apiKey: "AIzaSyCNkGaA71NVsDb0TY_-1VvgG4IX3cKoy8M",
      authDomain: "tanakh-reader.firebaseapp.com",
      databaseURL: "https://tanakh-reader-default-rtdb.firebaseio.com",
      projectId: "tanakh-reader",
      storageBucket: "tanakh-reader.appspot.com",
      messagingSenderId: "797493748621",
      appId: "1:797493748621:web:ae6644e1e32edf52b453c4",
      measurementId: "G-87LVD3ECEE"
    ));

  runApp(ProviderScope(child: MyAppInit()));
}

class MyAppInit extends StatelessWidget {

  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initialization',
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return MyApp();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}