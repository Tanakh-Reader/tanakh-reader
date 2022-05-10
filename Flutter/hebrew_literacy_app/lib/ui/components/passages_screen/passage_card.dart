import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';


import '../../../data/constants.dart';
import '../../../data/database/user_data/passage.dart';
import '../../../data/database/user_data/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../bottom_nav.dart';
import '../../../data/providers/providers.dart';
import '../../../data/models/models.dart';

class PassageCard extends ConsumerStatefulWidget {
  final Passage passage;
  PassageCard({Key? key, required this.passage}) : super(key: key);

  @override
  _DisplayPassageCard createState() => _DisplayPassageCard();
}

class _DisplayPassageCard extends ConsumerState<PassageCard> {

  bool showWidget = false;

  @override
  Widget build(BuildContext context) {
    final Passage passage = widget.passage;
    final userVocab = ref.watch(userVocabProvider);
    final userData = ref.read(userDataProvider);
    final vocab = userVocab.knownVocab;
    final passageLexemes = userVocab.lexemesByIds(passage.lexIds);
    // Exclude proper nouns from unknown vocab. 
    final Set<Lexeme> unknownVocab = passageLexemes.where(
      (l) => !vocab.contains(l.id) && l.speech != 'nmpr').toSet();
    final title = _buildTitle(passage);
    final percentMatch = (
      (1 - unknownVocab.length / passageLexemes.length) * 100).toInt();
    
    // https://stackoverflow.com/questions/43122113/sizing-elements-to-percentage-of-screen-width-height
    return Card(
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async {
               await openPassage(context, ref, passage);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(title, style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "$percentMatch% Match",
                      style: TextStyle(color: _matchColor(percentMatch)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Column(children: [
                      Align(alignment: Alignment.topLeft, child: 
                      Text("Passage length: ${passage.wordCount} words"),
                      ),
                      SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 210, child: Text("Unknown vocabulary: ${unknownVocab.length} words")),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.grey[400],
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => englishContextDialogue(context, passage, unknownVocab), 
                                  icon: FaIcon(FontAwesomeIcons.angleDown, color: Colors.grey[800],),
                                  iconSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                    ])
                    ),

                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[900],
                            ),
                    child: _buildText(passage),
                  ),
                ],
              ),
            ),
        ));
  }

  Color _matchColor(int percentMatch) {
    Color color;
    Map<String, Color> colors = {
      'easy': Colors.greenAccent,
      'medium': Colors.amber,
      'hard': Colors.redAccent
    };

    if (percentMatch >= 85) {
      color = colors['easy']!;
    } else if (percentMatch >= 70) {
      color = colors['medium']!;
    } else {
      color = colors['hard']!;
    }

    return color;
  }

  String _buildTitle(Passage passage) {
    final String bookName = Books.getBookById(passage.bookId).name!;
    final int startCh = passage.chapters.first;
    final int endCh = passage.chapters.last;
    final int startVs = passage.startVs;
    final int endVs = passage.endVs;

    return (startCh == endCh)
      ? "$bookName $startCh:$startVs-$endVs"
      : "$bookName $startCh:$startVs-$endCh:$endVs";
  }

  RichText _buildText(Passage passage) {
    int wordCount = 14;
    List<TextSpan> textSpans = [];
    int i = min(passage.sampleText!.length, wordCount);
    List<String> words = passage.sampleText!.sublist(0, i);
    // Iterate over all words in the first verse. 
    for (var i = 0; i < words.length; i++) {
      // The current word.
      textSpans.add(
        TextSpan(
          text: words[i],
          style: TxtTheme.hebrewStyle.copyWith(
            fontSize: 16,
            color: Colors.grey[300]
          )
      ));
    }

    textSpans.add( 
      TextSpan(text: " ... ",
      style: TxtTheme.hebrewStyle.copyWith(
            fontSize: 16,
            color: Colors.grey[300]
          ))
    );
    return RichText(
      text: TextSpan(
        children: 
          textSpans
      ),
      textDirection: TextDirection.rtl,
    );
  }

  openPassage(context, ref, Passage passage) async { 
    await ref
      .read(hebrewPassageProvider)
      .getPassageWordsByVsId(passage: passage, withEnglish: true);
    ref.read(tabManagerProvider).goToTab(Screens.read);
  }

  englishContextDialogue(context, Passage passage, Set<Lexeme> unknownVocab) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {

        List<Widget> lexDefinitions = unknownVocab.map<Widget>(
          (lex) => Container( 
            child: Column(
              children: [
                Row(
                  children: [
                  SizedBox(
                    width: 60,
                    child: Text('${lex.text}', textAlign: TextAlign.right,)),
                  SizedBox(width: 25,),
                  SizedBox(
                    width: 125,
                    child: Text('${lex.gloss}')),
                  SizedBox(width: 15,),
                  Text('${MORPH_MAP[lex.speech]!.substring(0,1)}', )//style: TextStyle(fontSize: 14),)
                ]),
                SizedBox(height: 15,)
              ],
            ),
          )).toList();

        return AlertDialog(
          shape: RoundedRectangleBorder( 
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          title: Text("Unknown Vocabulary", textAlign: TextAlign.center,),
          content: Container(
            width: 250,
            height: 200,
            alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: lexDefinitions
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await openPassage(context, ref, passage);
                  Navigator.pop(context);
                }, 
                child: Text('Read Passage')
              ),
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text('Dismiss')
              ),
              
            ],
      );
    }
  );


}
