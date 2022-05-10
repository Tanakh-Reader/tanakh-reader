import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';

import '../word_expansion_panel.dart';

class TranslationTile extends ConsumerStatefulWidget {
  @override
  _TranslationTileState createState() => _TranslationTileState();
}

class _TranslationTileState extends ConsumerState<TranslationTile> {

  var translationData;

  void loadData(word, hebrewPassage) {
    var verse = [
      ...hebrewPassage.verses
          .firstWhere((v) => v.words.first.vsBHS == word.vsBHS)
          .words
    ];
    // This was actually removing the item from the passage! use spread ... to make a clone
    verse.removeWhere((w) => w.sortBSB == null);
    verse.sort((a, b) => a.sortBSB!.compareTo(b.sortBSB!));
    List<TextSpan> textSpan = [];
    for (var _word in verse) {
      textSpan.add(TextSpan(
          text: _word.glossBSB! + ' ',
          style: TextStyle(
            color: _word.id == word.id 
                ? Colors.blue[200]
                : Colors.white,
              fontWeight:
                  _word.id == word.id ? FontWeight.bold : FontWeight.normal)));
    }
    setState(() {
      translationData = textSpan;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final word = hebrewPassage.selectedWord;
    return ExpansionTile(
        backgroundColor: MyTheme.bgColor,
        collapsedBackgroundColor: MyTheme.bgColor,
        textColor: MyTheme.selectedTileText,
        collapsedTextColor: MyTheme.greyText,
        title: Text('VERSE TRANSLATION'),
        onExpansionChanged: (expanding) {
          if (expanding) {
            loadData(word, hebrewPassage);
          }
        },
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            child: RichText(text: TextSpan(children: translationData)),
          )
        ]);
  }
}
