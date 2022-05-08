import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';
import 'package:hebrew_literacy_app/ui/screens/register_screen.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
// import 'package:hebrew_literacy_app/ui/widgets/read_screen/references_expansion_panel.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart' as pro;

import '../../../data/database/user_data/user.dart';
// import '../bottom_nav.dart';
import '../../../data/providers/providers.dart';
import '../../../data/models/models.dart';

class PassageCard extends ConsumerStatefulWidget {
  HebrewPassage hebrewPassage;
  PassageCard({Key? key, required this.hebrewPassage}) : super(key: key);

  @override
  _DisplayPassageCard createState() => _DisplayPassageCard();
}

class _DisplayPassageCard extends ConsumerState<PassageCard> {
  // final passages = Passages();
  bool showWidget = false;
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(hebrewPassageProvider);
    ref.read(userVocabProvider);
    ref.read(userDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    var passage = widget.hebrewPassage;
    print("Entering Display P");
    var userVocab = ref.read(userVocabProvider);
    var userData = ref.read(userDataProvider);
    var vocab = userVocab.knownVocab;

    var unknown = passage.lexemes.where((l) => !vocab.contains(l.id)).toList();
    var word = passage.words.first;
    // https://stackoverflow.com/questions/43122113/sizing-elements-to-percentage-of-screen-width-height
    return Container(
        height: MediaQuery.of(context).size.height * 0.20,
        child: Card(
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async {
              debugPrint('Card tapped.');
              await ref
                  .read(hebrewPassageProvider)
                  .getPassageWordsByVsId(passage.passage);
              ref.read(tabManagerProvider).goToTab(Screens.read.index);
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${passage.book.abbrOSIS} ${word.chBHS}:${word.vsBHS}-${passage.words.last.vsBHS}',
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    color: Colors.black,
                    child: _buildText(passage),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(width: 50, child: Text("Words:")),
                    SizedBox(
                      width: 5,
                    ),
                    Text("${passage.words.length}"),
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(width: 50, child: Text("Match:")),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        "${((1 - unknown.length / passage.lexemes.length) * 100).toInt()}%")
                  ]),
                ],
              ),
            ),
          ),
        ));
  }

  RichText _buildText(passage) {
    int wordCount = 10;
    List<TextSpan> textSpans = [];
    num i = min(passage.words.length, wordCount);
    var words = passage.words.sublist(0, i);
    // Iterate over all words in the first verse. 
    for (var i = 0; i < words.length; i++) {
      // The current word.
      var word = words[i];
      // Add verse divisions. 

      textSpans.add(
        TextSpan(
          text: word.text,
      ));
      textSpans.add( 
        TextSpan(
          text: word.trailer,
      ));
    }
    textSpans.add( 
      TextSpan(text: " ... ")
    );
    return RichText(
      text: TextSpan(
        children: 
          textSpans
      ),
      textDirection: TextDirection.rtl,
    );
  }
}
