import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';
import 'package:hebrew_literacy_app/ui/screens/register_screen.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
import 'package:hebrew_literacy_app/ui/components/read_screen/references_expansion_panel.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart' as pro;

import '../../data/database/user_data/user.dart';
import '../../data/providers/passage.dart';
import '../bottom_nav.dart';
import '../components/passages_screen/passage_card.dart';
import 'read_screen.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class PassagesScreen extends ConsumerWidget {

  // static const routeName = '/home';

  int? freqLex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO -- this rebuilds any time a function
    // is called from anywhere in the app. 
    var userVocab = ref.read(userVocabProvider);
    var userData = ref.watch(userDataProvider);
    var passageData = ref.read(passageDataProvider);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        // child: SingleChildScrollView(
        //     child: ConstrainedBox(
        //       constraints: BoxConstraints(minHeight: 200),
              child: passageData.isInitialized ?
              // Container(height: 800, child:
            
                  DisplayPassages()
                  
              // )
              : Center(child: Text("No Passages"))
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
}

var passageCards;

class DisplayPassages extends ConsumerStatefulWidget {
  DisplayPassages({ Key? key}) : super(key: key);

  @override
  _DisplayPassagesState createState() => _DisplayPassagesState();
}

class _DisplayPassagesState extends ConsumerState<DisplayPassages> {
    
  // final passages = Passages();
  bool showWidget = false;
 
  _loadPassages(var passages) {
    passageCards = passages.map<Widget>(
                (passage) => PassageCard(passage: passage)
              ).toList();
              setState(() {
                showWidget = passageCards.length > 0;
              });
  }

  @override
  Widget build(BuildContext contextpassageData) {
    print("Entering Display P");
    var userVocab = ref.read(userVocabProvider);
    var userData = ref.read(userDataProvider);
    var passageData = ref.read(passageDataProvider);
    var vocab = userVocab.knownVocab;
    if (!showWidget) {
      _loadPassages(passageData.passages);
    }
    return SizedBox(
      // height: 420,
      child: Column(
        children: <Widget>[
          
          SizedBox(height: 30,),
          Text("Hebrew Passages",
                  style: Theme.of(context).textTheme.headline5,
                  ),
          SizedBox(height: 20,),
          showWidget 
          ? Container(
            height: MediaQuery.of(context).size.height * 0.75, 
            margin: EdgeInsets.only(top: 0),
            width: MediaQuery.of(context).size.width * 0.75,
            child: ListView.separated(
              itemCount: passageCards.length,
              itemBuilder: (context, index) {
                return 
                // Consumer(
                //   builder: ((context, ref, child) {
                    
                //   }
                    
                // );
                completedPassageWrapper(
                  passageCards[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              }
            ),
          )
          : Container(),

        ]
      ),
    );
  }

  Widget completedPassageWrapper(Widget child) {
    return Stack(
      children: [
        child, 
        Align( 
          alignment: Alignment.topLeft,
          child: Padding( 
            padding: EdgeInsets.fromLTRB(24, 16, 16, 16),
            child: FaIcon(FontAwesomeIcons.check, color: Colors.greenAccent,),
          ),
        )
      ]
    );
  }
}


  
