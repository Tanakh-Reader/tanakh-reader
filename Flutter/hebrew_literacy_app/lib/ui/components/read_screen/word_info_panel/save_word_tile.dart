import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';

import '../word_expansion_panel.dart';

class SaveWordTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final userVocab = ref.watch(userVocabProvider);
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final word = hebrewPassage.selectedWord;
    final lex = hebrewPassage.lex(word!.lexId!);

    return GestureDetector(
        onTap: () {
          userVocab.toggleSaved(lex);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          color: MyTheme.bgColor,
          child: userVocab.isSaved(lex)
              ? Text('${lex.text} is saved')
              // style: textColor)
              : Text('Add ${lex.text} to dictionary'),
          // style: textColor)),
        ));
  }
}