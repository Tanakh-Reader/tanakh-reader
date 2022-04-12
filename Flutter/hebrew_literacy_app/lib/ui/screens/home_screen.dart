import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
import 'package:hebrew_literacy_app/ui/widgets/read_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart' as pro;

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

    var userVocab = ref.watch(userVocabProvider);

    print("Home built");
    return SizedBox(
      height: 1200,
      child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                setVocab(context, userVocab),
                userVocab.loaded ?
                DisplayPassages(userVocab: userVocab)
                : Container()
                ,
                ReferencesExpansionPanel(
                  button: Center(
                    child: Icon(Icons.menu_book_rounded),
                  )
                ),
              ]
            ),
          ),
        ),
    );
  }

  Widget setVocab(context, userVocab) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (newText) {freqLex = int.parse(newText);}
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await userVocab.setUserVocab(freqLex);
                  userVocab.load();
                },
                child: const Text('Submit'),
              ),
            ),
          ],
    );
  }
}

var passages = Passages();

class DisplayPassages extends StatefulWidget {
  var userVocab;
  DisplayPassages({ Key? key, this.userVocab}) : super(key: key);

  @override
  State<DisplayPassages> createState() => _DisplayPassagesState();
}

class _DisplayPassagesState extends State<DisplayPassages> {
    
  // final passages = Passages();
  bool showWidget = false;

  @override
  Widget build(BuildContext context) {
    print("Entering Display P");
    var vocab = widget.userVocab.knownVocab;
    return SizedBox(
      height: 1000,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await passages.loadPassages();
              setState(() {
                showWidget = !showWidget;
                print("LOADED");
              });
            },
            child: const Text('Load Passages'),
          ),
          showWidget 
          ? Column(
                children: 
                  passages.passages.map((passage) {
                    var unknown = passage.lexemes.where((l) => !vocab.contains(l.id)).toList();
                    print("${unknown.length} / ${passage.lexemes.length}");
                    return Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
              //             ref.read(hebrewPassageProvider).getPassageWordsByRef(book.id!, chapter);
              // // Navigator.of(context).pushNamed(ReadScreen.routeName);
              //       ref.read(tabManagerProvider).goToTab(Screens.read.index);
                        },
                        child: Column(
                          children: [
                            Text(passage.book.name!),
                            Text("Words: ${passage.words.length}"),
                            Text("Match: ${((1 - unknown.length / passage.lexemes.length) * 100).toInt()}%")
                          ],
                        ),
                      ),
                    );
                  }).toList()
          )
          : Container()
        ]
      ),
    );
  }
}


  
