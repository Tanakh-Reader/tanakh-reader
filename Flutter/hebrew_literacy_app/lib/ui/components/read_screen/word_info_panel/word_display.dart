import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';

class WordDisplay extends ConsumerStatefulWidget {
  @override
  _WordDisplayState createState() => _WordDisplayState();
}

class _WordDisplayState extends ConsumerState<WordDisplay> {
  var showGloss = false;
  void toggleGloss() {
    setState(() {
      showGloss = !showGloss;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userVocab = ref.watch(userVocabProvider);
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final word = hebrewPassage.selectedWord;
    final lex = hebrewPassage.lex(word!.lexId!);
    var joinedWords = hebrewPassage.joinedWords;

    String text = joinedWords.map((w) => w.text ?? '').toList().join(' · ');
    String morph = [
      MORPH_MAP[lex.speech],
      MORPH_MAP[lex.nameType],
      MORPH_MAP[word.vStem],
      MORPH_MAP[word.vTense],
      MORPH_MAP[word.person],
      MORPH_MAP[word.gender],
      MORPH_MAP[word.number],
      MORPH_MAP[word.state]
    ].join(', ');
    var spacingH = 8.0;
    var spacingW = 10.0;
    var innerW = 60.0;

    // Occurences formatted.
    // https://stackoverflow.com/questions/31931257/dart-how-to-add-commas-to-a-string-number
    var occurences = lex.freqLex!.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    return Container(
      // color: Colors.blue,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [ Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: innerW,
                  child: Text(
                    'Text:',
                    textAlign: TextAlign.right,
                  )),
              SizedBox(width: spacingW),
              Text('$text', style: TextStyle(fontWeight: FontWeight.bold),),
            ]),
          SizedBox(
            height: spacingH,
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                width: innerW,
                child: Text(
                  'Lemma:',
                  textAlign: TextAlign.right,
                )),
            SizedBox(width: spacingW),
            Text('${lex.text} occurs $occurences times'),
          ]),
          SizedBox(
            height: spacingH,
          ),
          Container(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: innerW,
                  child: Text(
                    'Gloss:',
                    textAlign: TextAlign.right,
                  )),
              SizedBox(width: spacingW),
              !userVocab.isKnown(lex) || showGloss
                  ? Text('${word.glossExt}')
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text('You know this word!'),
                          SizedBox(width: spacingW * 5),
                          // TODO : text button approach.
                          // TextButton(
                          //       onPressed: () => englishContextDialogue(context, hebrewPassage, unknownVocab),
                          //       child: Text("Unknown"),
                          //       style: TextButton.styleFrom(
                          //         minimumSize: Size.zero,
                          //         padding: EdgeInsets.zero,
                          //         // backgroundColor: Colors.yel[900]
                                  
                          //     ),
                          GestureDetector(
                            onTap: () {
                              userVocab.updateGlossTap(lex);
                              toggleKnownDialogue(context, ref);
                            },
                            child: Container( 
                              padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.blue[800],
                              ),
                              child: Text("SHOW GLOSS", style: TextStyle(fontSize: 12),))
                          ),
                        ])
            ]),
          ),
          SizedBox(
            height: spacingH,
          ),
          Container(
            // color: Colors.pink,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: innerW,
                  child: Text(
                    'Morph:',
                    textAlign: TextAlign.right,
                  )),
              SizedBox(width: spacingW),
              Flexible(
                  child: Text(
                '$morph',
                softWrap: true,
                maxLines: 2,
              ))
            ]),
          ),
        ]),
        // Button to toggle known/unknown vocab.
        Positioned(
              top: -5,
              right: 40,
              child: userVocab.isKnown(lex)
              ? knownIcon(userVocab, lex)
              : unknownIcon(userVocab, lex)
            )
        ]
      ),
    );
  }

  knownIcon(userVocab, lex) => IconButton(
    padding: EdgeInsets.zero,
    onPressed: () => userVocab.setToUnknown(lex), 
    // See if I can make it lightbulb on.
    // https://fontawesome.com/search?q=lightbulb&s=solid%2Cbrands
    icon: FaIcon(FontAwesomeIcons.lightbulb, color: Colors.yellow,),
    iconSize: 25,
  );

  unknownIcon(userVocab, lex) => IconButton(
    padding: EdgeInsets.zero,
    onPressed: () => userVocab.setToKnown(lex), 
    icon: FaIcon(FontAwesomeIcons.lightbulb, color: Colors.grey,),
    iconSize: 25,
  );
  


  toggleKnownDialogue(context, ref) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final userVocab = ref.read(userVocabProvider);
        final word = ref.read(hebrewPassageProvider).selectedWord;
        final lex = ref.read(hebrewPassageProvider).lex(word.lexId);
        return AlertDialog(
          shape: RoundedRectangleBorder( 
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 50),
          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
          content: Container(
            height: 75,
            child: Column(
              children: [
                Text("${word.text} :  ${word.glossExt}"),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          userVocab.setToKnown(lex);
                          Navigator.pop(context);
                        },
                        child: Text("Set to unknown")),
                    Expanded(child: SizedBox(),),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Dismiss'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}