import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/database/user_data/passage.dart';
import 'package:hebrew_literacy_app/data/database/user_data/settings.dart';
import 'package:hebrew_literacy_app/data/providers/passage.dart';
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

//https://bettercoding.dev/flutter/initialization-splash/

// https://www.optisolbusiness.com/insight/flutter-offline-storage-using-hive-database

void main() async { 

  // ** RiverPod treats Models like Singeltons: https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
  // "Note that we’re defining a builder that creates a new instance of SomeModel. 
  // ChangeNotifierProvider is smart enough not to rebuild SomeModel unless absolutely 
  // is no longer needed."
  
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