import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/hebrew_passage.dart';
import '../../../data/models/models.dart';

// REMOVE LATER --> make theme class
import 'package:google_fonts/google_fonts.dart';


/* PassageDisplay returns a RichText containing all of the word objects that will be displayed
for a given passage. Each word is placed in a TextSpan such that its attributes can be accessed
via a gesture detector. */

class PassageDisplay extends ConsumerWidget {

  PassageDisplay({ 
    Key? key ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /* If HebrewPassage.words is populated, generate a TextSpan
    with all of the words -- otherwise display a message. */
    final _hebrewPassage = ref.watch(hebrewPassageProvider);
    // TODO REMOVE!
    return Column(
      children: [
        SizedBox(height: 65,),
        Expanded(
          child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              children: _buildTextSpans(_hebrewPassage, ref)
            ),
            textDirection: TextDirection.rtl,
          ),
      ),
        ),
      ]
    );
  }

  
  // Create a textspan for each word in the passage.
  List<TextSpan>? _buildTextSpans(HebrewPassage hebrewPassage, ref) {

    var textDisplay = ref.watch(textDisplayProvider);
    var userVocab = ref.watch(userVocabProvider);
    List<TextSpan> hebrewPassageTextSpans = [];
    List<Verse> verses = hebrewPassage.verses;
    
    // Iterate over verses in passage, converting each word into a TextSpan.
    for (int i = 0; i < verses.length; i++) {
      List<Word> words = verses[i].words!;
      // Add verse number.
      hebrewPassageTextSpans.add(
        TextSpan(
          children:[
            WidgetSpan(
              alignment: PlaceholderAlignment.bottom,
              child: Text(
                " ${verses[i].number.toString()} ",
                style: _wordStyle.copyWith(
                  fontSize: TxtTheme.verseSize,    
                  fontWeight: FontWeight.bold
                )
              )
            )
           ]
        )
      );
      List<Word> joinedWords = [];
      // Iterate over words.
      int clauseId = verses[0].words!.first.clauseId!;
      for (int k = 0; k < verses[i].words!.length; k++) {
        Word word = words[k];
        if (word.trailer == null) {
          joinedWords.add(word);
          continue;
        } else if (k > 0 && words[k-1].trailer == null) {
          joinedWords.add(word);
          for (var _word in joinedWords) {
            Lexeme lex = hebrewPassage.lex(_word.lexId!);
            Color wordColor = (lex.speech == 'nmpr' && lex.freqLex! < 100) ? TxtTheme.propNounColor : TxtTheme.normColor;
            if (lex.speech != 'nmpr' && !userVocab.isKnown(lex)) {
              wordColor = TxtTheme.unknownColor!;
            }
            // TextDecoration decor = userVocab.isKnown(lex) ? TxtTheme.normDecor : TxtTheme.unknownDecor;
            FontWeight weight = joinedWords.any((w) => w.isSelected) ? TxtTheme.selWeight : TxtTheme.normWeight;
            var _wordSpan = TextSpan(
              text: _word.text ?? '',
              style:_wordStyle.copyWith(
                color: wordColor,
                fontWeight: weight,
                // decoration: decor
              ),
              recognizer: TapGestureRecognizer()
              ..onTap = () {
                hebrewPassage.toggleWordSelection(word);
              }
            );
            hebrewPassageTextSpans.add(_wordSpan);
          }
          var _trailerSpan = TextSpan(
            text: word.trailer,
            style: _wordStyle
          );
          hebrewPassageTextSpans.add(_trailerSpan);
          joinedWords = [];
        } else {
          var _wordSpan = _createWordSpan(word, userVocab, hebrewPassage);
          var _trailerSpan = TextSpan(
            text: word.trailer,
            style: _wordStyle
          ); 
          hebrewPassageTextSpans.add(_wordSpan);
          hebrewPassageTextSpans.add(_trailerSpan);
        }
        if (word.id == verses[i].words!.last.id) {
          hebrewPassageTextSpans.add(TextSpan(text: '\n'));
        }
        // if (textDisplay.grouping == TextGroup.clause) {
        //   if (word.clauseId != clauseId) {
        //     clauseId += 1;
        //     hebrewPassageTextSpans.add(TextSpan(text: '\n'));
        //   }
        // }
      }
    }
    return hebrewPassageTextSpans;
  }

  var _wordStyle = GoogleFonts.notoSerifHebrew(
      color: TxtTheme.normColor,
      fontSize: TxtTheme.normSize,
      fontWeight: TxtTheme.normWeight,
      decoration: TxtTheme.normDecor,
      decorationColor: TxtTheme.decorColor,
  );

  TextSpan _createWordSpan(word, userVocab, hebrewPassage) {
    Lexeme lex = hebrewPassage.lex(word.lexId!);
    Color wordColor = (lex.speech == 'nmpr' && lex.freqLex! < 100) ? TxtTheme.propNounColor : TxtTheme.normColor;
    if (lex.speech != 'nmpr' && !userVocab.isKnown(lex)) {
      wordColor = TxtTheme.unknownColor!;
    }
    TextDecoration decor = userVocab.isKnown(lex) ? TxtTheme.normDecor : TxtTheme.unknownDecor;
    FontWeight weight = word.isSelected ? TxtTheme.selWeight : TxtTheme.normWeight;
    return TextSpan(
      text: word.text ?? '',
      style:_wordStyle.copyWith(
        color: wordColor,
        fontWeight: weight,
        // decoration: decor
      ),
      recognizer: TapGestureRecognizer()
      ..onTap = () {
        hebrewPassage.toggleWordSelection(word);
      }
    );
  }

}