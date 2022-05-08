import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      MorphMap[lex.speech],
      MorphMap[lex.nameType],
      MorphMap[word.vStem],
      MorphMap[word.vTense],
      MorphMap[word.person],
      MorphMap[word.gender],
      MorphMap[word.number],
      MorphMap[word.state]
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
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                        GestureDetector(
                          onTap: () => toggleKnownDialogue(context, ref),
                          child: Container( 
                            padding: EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 4),
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
    );
  }

  toggleKnownDialogue(context, ref) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final userVocab = ref.read(userVocabProvider);
        final word = ref.read(hebrewPassageProvider).selectedWord;
        final lex = ref.read(hebrewPassageProvider).lex(word.lexId);
        return AlertDialog(
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
                          if (userVocab.isKnown(lex)) {
                            userVocab.setToUnknown(lex);
                          } else {
                            userVocab.setToKnown(lex);
                          }
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