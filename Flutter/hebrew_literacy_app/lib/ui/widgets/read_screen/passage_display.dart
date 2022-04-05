import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/hebrew_passage.dart';
import '../../../data/models/models.dart';

// REMOVE LATER --> make theme class
import 'package:google_fonts/google_fonts.dart';



/* PassageDisplay returns a RichText containing all of the word objects that will be displayed
for a given passage. Each word is placed in a TextSpan such that its attributes can be accessed
via a gesture detector. */

class PassageDisplay extends ConsumerWidget {

  const PassageDisplay({ 
    Key? key ,
  }) : super(key: key);

//   @override
//   _PassageDisplayState createState() => _PassageDisplayState();
// }

// class _PassageDisplayState extends State<PassageDisplay> {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /* If HebrewPassage.words is populated, generate a TextSpan
    with all of the words -- otherwise display a message. */
    final _hebrewPassage = ref.watch(hebrewPassageProvider);
    return SingleChildScrollView(
      child: RichText(
        text: TextSpan(
          children: _buildTextSpans(_hebrewPassage)
        ),
        textDirection: TextDirection.rtl,
      ),
      );
  }

  /*sw
  // Create a textspan for each word in the passage.
  List<TextSpan> _buildTextSpans(HebrewPassage hebrewPassage) {

    List<TextSpan> hebrewPassageTextSpans = [];
    List<Word> hebrewWords = hebrewPassage.words;

    // Iterate over hebrewWords, converting each word into a TextSpan.
    for (int i = 0; i < hebrewWords.length; i++) {

      Color wordColor = hebrewWords[i].speech == 'nmpr' ? Colors.grey : Colors.white;
      String text = hebrewWords[i].text! + hebrewWords[i].trailer!;
      TextSpan wordTextSpan;

      // If there is a selected word
      if (hebrewWords[i].isSelected == true) {
        wordTextSpan = TextSpan(
          text: text,
          style:  TextStyle(
            color: wordColor,
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
          recognizer: TapGestureRecognizer()
          ..onTap = () {
             hebrewPassage.toggleWordSelection(hebrewWords[i]);
          }
        );
      // If there is not a selected word
      } else {
        wordTextSpan = TextSpan(
          text: text,
          style: TextStyle(
            color: wordColor,
            fontSize: 28,
            fontWeight: FontWeight.normal
          ),
          recognizer: TapGestureRecognizer()
          ..onTap = () {
             hebrewPassage.toggleWordSelection(hebrewWords[i]);
          }
        );
      } 

      hebrewPassageTextSpans.add(wordTextSpan);
    }

    return hebrewPassageTextSpans;
  }*/
  // Create a textspan for each word in the passage.
  List<TextSpan>? _buildTextSpans(HebrewPassage hebrewPassage) {

    List<TextSpan> hebrewPassageTextSpans = [];
    List<Verse> verses = hebrewPassage.verses;

    // Iterate over hebrewWords, converting each word into a TextSpan.
    for (int j = 0; j < verses.length; j++) {
      List<Word> words = verses[j].words!;
      hebrewPassageTextSpans.add(
        TextSpan(
          text: "${verses[j].number.toString()} ", 
          style: TextStyle(color:Colors.white)
          )
        );
      for (int i = 0; i < verses[j].words!.length; i++) {

        Color wordColor = words[i].speech == 'nmpr' ? Colors.grey : Colors.white;
        String text = words[i].text! + words[i].trailer!;
        TextSpan wordTextSpan;

        // If there is a selected word
        if (words[i].isSelected == true) {
          wordTextSpan = TextSpan(
            text: text,
            style:  TextStyle(
              color: wordColor,
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
            recognizer: TapGestureRecognizer()
            ..onTap = () {
              hebrewPassage.toggleWordSelection(words[i]);
            }
          );
        // If there is not a selected word
        } else {
          wordTextSpan = TextSpan(
            text: text,
            style: GoogleFonts.notoSerifHebrew(
              color: wordColor,
              fontSize: 28,
              fontWeight: FontWeight.normal
            ),
            recognizer: TapGestureRecognizer()
            ..onTap = () {
              hebrewPassage.toggleWordSelection(words[i]);
            }
          );
        } 

        hebrewPassageTextSpans.add(wordTextSpan);
      }
    }
    return hebrewPassageTextSpans;
  }
}