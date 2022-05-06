import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:expandable/expandable.dart';
import 'package:path/path.dart';
import '../../../data/database/hb_db_helper.dart';
import '../../../data/models/models.dart';
import '../../../data/models/word.dart';

// TODO
// Use https://pub.dev/packages/expandable to make a better expansionPanel

class MyTheme {
  var bgColor = Colors.grey[800];

}

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

  // List<String> nouns = ['subs', 'nmpr', 'prps', 'prde', 'prin', 'adkv'];

  @override
  Widget build(BuildContext context) {
    // Providers.
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final userVocab = ref.watch(userVocabProvider);
    // Word data.
    final word = hebrewPassage.selectedWord;
    final lex = hebrewPassage.lex(word!.lexId!);
    var joinedWords = hebrewPassage.joinedWords;

    TextStyle textColor = const TextStyle(color: Colors.white);

    return 
    /*
    FutureBuilder(
      future: wordPanelSheet(context),
      builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting 
        ? Container(child: CircularProgressIndicator(),)
        : snapshot.data as Widget
    );
  }
    
    Future<Widget> wordPanelSheet(context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
        ),
        builder: (context) {
          return FractionallySizedBox(
            // TODO CHANGE!
            heightFactor: 0.4,
            // widthFactor: Responsive.isTablet(context) ? 0.75 : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Books',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                
              ],
            ),
          );
        },
    ) as Future<Widget>;
*/
    DraggableScrollableSheet(
      initialChildSize: 0.4,
      
      maxChildSize: 0.8,
      // height: MediaQuery.of(context).size.height * 0.4,
      builder: (BuildContext context, ScrollController scrollController) {
            return 
      //       Container(
      // child: 
      SingleChildScrollView(
        controller: scrollController,
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
            // examplesTile(context, word, hebrewPassage),
            Container(height: 1.5, color: Colors.black,),
            // translationTile(word, hebrewPassage),
            Container(height: 1.5, color: Colors.black,),
            // strongsTile(context, word, hebrewPassage),
            Container(height: 1.5, color: Colors.black,),
            GestureDetector(
              onTap: () {
                userVocab.toggleSaved(lex);
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
      );
      }
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
  Widget examplesTile(context, word, hebrewPassage) => ExpansionTile(
      backgroundColor: tileColor,
      collapsedBackgroundColor: tileColor,
      title: Text('Example Sentences'),
      children: [
        Container(
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: hebrewPassage.getLexSentences(word),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Please wait, its loading...'));
                } else if (snapshot.hasData) {
                  return RichText(
                    text: _buildExamplesText(word, snapshot.data!, hebrewPassage),
                    textDirection: TextDirection.rtl,
                    );
                } else {
                  return Text("No other examples for ${word.text}");
                }
              }
            ),
          ),
        ),
      ]
  );

  TextSpan _buildExamplesText(word, examplesData, hebrewPassage) {
    List<TextSpan> examples = [];
    for (var example in examplesData) {
      var book = hebrewPassage.getBook(example.first);
      examples.add( 
        TextSpan(
          text: "${book.name} ${example.first.chBHS}:${example.first.vsBHS}\n"
        )
      );
      // TODO : add logic to shorten super long sentences. 
      for (var i = 0; i < example.length; i++) {
        var _word = example[i];
        examples.add(
          TextSpan(
            text: _word.text?? '',
            style: TextStyle(
              fontWeight: _word.lexId == word.lexId ? FontWeight.bold : FontWeight.normal
            )
          )
        );
        examples.add(
          TextSpan(
            text: _word.trailer?? '',
          )
        );
      }
      examples.add(
          TextSpan(
            text: " ... " + '\n\n',
          )
        );
    }
    return TextSpan(children: examples);
  }
  
  Widget strongsTile(context, word, hebrewPassage) {
    return ExpansionTile(
      backgroundColor: tileColor,
      collapsedBackgroundColor: tileColor,
      title: Text('Strongs Informations'),
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: FutureBuilder<List<Strongs>>( 
              future: hebrewPassage.getStrongs(word),
              builder: (context, snapshot) => 
                snapshot.connectionState == ConnectionState.done
                ? RichText(text: _buildStrongsText(snapshot.data!))
                : CircularProgressIndicator()
            ),
          )
        )
      ]
    );
  }

  TextSpan _buildStrongsText(List<Strongs> strongsData) {
    List<TextSpan> allDefinitions = [];
    allDefinitions.add( 
      TextSpan(text: "Strongs: ${strongsData.first.strongsId}\n")
    );
    for (var strongs in strongsData) {
      if (strongs != null) {
        var definitions = strongs.definition!.split('<br>');
        for (var def in definitions) {
          allDefinitions.add( 
            TextSpan(text: def + '\n')
          );
        }
      }
    }
    return TextSpan(children: allDefinitions);
  }

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


  
