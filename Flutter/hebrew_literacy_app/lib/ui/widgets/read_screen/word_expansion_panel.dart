import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:path/path.dart';
import '../../../data/database/hb_db_helper.dart';
import '../../../data/models/models.dart';
import '../../../data/models/word.dart';


class WordExpansionPanel extends ConsumerStatefulWidget {

  @override
  _WordExpansionPanelState createState() => _WordExpansionPanelState();
}

class _WordExpansionPanelState extends ConsumerState<WordExpansionPanel> {

  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(hebrewPassageProvider);
    ref.read(userVocabProvider);
  }

  bool _expanded = false;
  // List<String> nouns = ['subs', 'nmpr', 'prps', 'prde', 'prin', 'adkv'];

  @override
  Widget build(BuildContext context) {
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final userVocab = ref.watch(userVocabProvider);
    final word = hebrewPassage.selectedWord;
    final lex = hebrewPassage.lex(word!.lexId!);
    // var temp = HebrewDatabaseHelper().getLexClauses(word!);
    var joinedWords = hebrewPassage.joinedWords;
    print(joinedWords.first.text);


    TextStyle textColor = const TextStyle(color: Colors.white);

    return SizedBox(
      // height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Word summary
            GestureDetector(
              onTap: () {
                hebrewPassage.deselectWords();
              },
              child: Container(
                color: tileColor,
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 130,
                child: _wordDisplay(word, joinedWords, hebrewPassage, userVocab)
              ),
            ),
            Container(height: 1.5, color: Colors.black,),
            // examplesTile(temp),
            translationTile(word, hebrewPassage),
            Container(height: 1.5, color: Colors.black,),
            GestureDetector(
              onTap: () {
                userVocab.toggleSaved(lex.id!);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                height: 40,
                width: double.infinity,
                color: Colors.grey[800],
                child: userVocab.isSaved(lex)
                ? Text('${lex.text} is saved', style: textColor)
                : Text('Add ${lex.text} to dictionary', style: textColor)
              ),
            ),
            Container(height: 1.5, color: Colors.black,),
            GestureDetector(
              onTap: () {
                if (userVocab.isKnown(lex)) {
                  userVocab.setToUnknown(lex);
                } else {
                  userVocab.setToKnown(lex);
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                height: 40,
                width: double.infinity,
                color: Colors.grey[800],
                child: userVocab.isKnown(lex)
                ? Text('Don\'t know this word?', style: textColor)
                : Text('Know this word?', style: textColor)
              ),
            ),
            Container(height: 1.5, color: Colors.black,),
          ],
        ),
      ),
    );
  }

  Widget _wordDisplay(word, joinedWords, hebrewPassage, userVocab) {
    Lexeme lex = hebrewPassage.lex(word.lexId!);
    print(lex.text);
    String text = joinedWords.map((w) => w.text ?? '').toList().join(' · ');
    String morph = [MorphMap[lex.speech], MorphMap[lex.nameType], 
      MorphMap[word.vStem], MorphMap[word.vTense], MorphMap[word.person],
      MorphMap[word.gender], MorphMap[word.number], MorphMap[word.state]].join(', ');
    var spacingH = 4.0;
    var spacingW = 10.0;
    var innerW = 60.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: innerW,
              child: Text('Text:', textAlign: TextAlign.right,)
            ),
            SizedBox(width: spacingW),
            Text('$text'),
          ]),
        SizedBox(height: spacingH,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: innerW,
              child: Text('Lemma:', textAlign: TextAlign.right,)
            ),
            SizedBox(width: spacingW),
            Text('${lex.text} occurs ${lex.freqLex} times'),
          ]),
        SizedBox(height: spacingH,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: innerW,
              child: Text('Gloss:', textAlign: TextAlign.right,)
            ),
            SizedBox(width: spacingW),
            !userVocab.isKnown(lex)
            ? Text('${word.glossExt}')
            : Text('You know this word!'),
          ]),
        SizedBox(height: spacingH,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: innerW,
              child: Text('Morph:', textAlign: TextAlign.right,)
            ),
            SizedBox(width: spacingW),
            Flexible(
              child: Text('$morph', softWrap:true, maxLines: 2,)
            )
          ]
        ),
      ]
    );
  }
  
  var tileColor = Colors.grey[800];
  Widget examplesTile(temp) => ExpansionTile(
      backgroundColor: tileColor,
      collapsedBackgroundColor: tileColor,
      title: Text('Example Sentences'),
      children: [
        Container(
          height: 200,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: temp,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Please wait its loading...'));
                } else if (snapshot.hasData) {
                  var data = snapshot.data as List<List<Word>>;
                  return Column(
                    children: data.map((clause) => 
                    Column(children: [
                      Text("${clause.first.book}:${clause.first.chBHS}:${clause.first.vsBHS}"),
                      Text(clause.map((e) => (e.text?? '') + (e.trailer?? '')).toList().join(''))
                    ])
                    ).toList()
                  );
                } else {
                  return Text("No examples");
                }
              }
            ),
          ),
        ),
      ]
  );

  Widget translationTile(word, hebrewPassage) {

    List<Word> verse = [...hebrewPassage.verses.firstWhere((v) => v.words.first.vsBHS == word.vsBHS).words];
    // This was actually removing the item from the passage! use spread ... to make a clone
    verse.removeWhere((w) => w.sortBSB == null);
    verse.sort((a, b) => a.sortBSB!.compareTo(b.sortBSB!));
    List<TextSpan> textSpan = [];
    for (var _word in verse) {
      textSpan.add(
        TextSpan(
          text: _word.glossBSB! + ' ',
          style: TextStyle(
            fontWeight: _word.id == word.id ? FontWeight.bold : FontWeight.normal
          )
      ));
    }
    return ExpansionTile(
      backgroundColor: tileColor,
      collapsedBackgroundColor: tileColor,
      title: Text('English Translation'),
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: RichText(text: TextSpan(children: textSpan)),
        )
      ]
  );
  }

}


  
