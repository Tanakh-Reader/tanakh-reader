import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';
import 'package:hebrew_literacy_app/ui/screens/register_screen.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
import 'package:hebrew_literacy_app/ui/widgets/read_screen/references_expansion_panel.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart' as pro;

import '../../data/database/user_data/user.dart';
import '../bottom_nav.dart';
import 'read_screen.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen ({ Key? key }) : super(key: key);

  static const routeName = '/home';

  int? freqLex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO -- this rebuilds any time a function
    // is called from anywhere in the app. 
    var userVocab = ref.read(userVocabProvider);
    var userData = ref.watch(userDataProvider);
    ref.read(hebrewPassageProvider).getPassageWordsByRef(1, 1);

    print("Home built");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: 800,
        width: double.infinity,
        // child: SingleChildScrollView(
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(minHeight: 200),
              child: userData.initialized ?
              Container(height: 450, child:
            
                  Text("HELLO!")
                  
              )
              : RegisterScreen()
                  // ReferencesExpansionPanel(
                    // button: Center(
                    //   child: Icon(Icons.menu_book_rounded),
                    // )
                  // ),
                
              ),
            // ),
          // ),
      
    );
  }
 
  // Widget setVocab(context, userVocab) {
  //   return Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           SizedBox(height: 60,),
  //           Text('Enter the lexical range you have memorized.'),
  //           SizedBox(
  //             width: 200,
  //             child: TextField(
  //               onChanged: (newText) {freqLex = int.parse(newText);}
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 16.0),
  //             child: ElevatedButton(
  //               onPressed: () async {
  //                 await userVocab.initializeVocab(freqLex);
  //                 userVocab.load();
  //               },
  //               child: const Text('Submit'),
  //             ),
  //           ),
  //         ],
  //   );
  // }
}

