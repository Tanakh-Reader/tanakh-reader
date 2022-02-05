import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../data/database/hebrew_bible_data/hebrew_word_data.dart';
import '../../../data/providers/hebrew_passage.dart';
import '../../../data/models/hebrew_word.dart';


/* PassageDisplay returns a RichText containing all of the word objects that will be displayed
for a given passage. Each word is placed in a TextSpan such that its attributes can be accessed
via a gesture detector. */

class PassageDisplay extends StatefulWidget {
  final Future<void> hebrewPassageFuture;

  const PassageDisplay({ 
    Key? key ,
    required this.hebrewPassageFuture
  }) : super(key: key);

  @override
  _PassageDisplayState createState() => _PassageDisplayState();
}

class _PassageDisplayState extends State<PassageDisplay> {

  @override
  Widget build(BuildContext context) {

    return Consumer<HebrewPassage>(
          child: const Center(
            child: Text('No text was loaded')
          ),
          builder: (ctx, hebrewPassage, child) =>
            hebrewPassage.words.isEmpty
              ? child as Widget
              : RichText(
                  text: TextSpan(
                    children: _buildTextSpans(hebrewPassage)
                  )
              )
      );
  }

  // Create a textspan for each word in the passage.
  List<TextSpan> _buildTextSpans(HebrewPassage hebrewPassage) {

    List<TextSpan> hebrewPassageTextSpans = [];
    List<HebrewWord> hebrewWords = hebrewPassage.words;

    // Iterate over hebrewWords, converting each into a TextSpan
    for (int i = 0; i < hebrewWords.length; i++) {
      // https://api.flutter.dev/flutter/painting/TextSpan-class.html
      final text = hebrewWords[i].pointedText! + hebrewWords[i].trailer!;
      TextSpan wordTextSpan;
      // If there is a selected word
      if (hebrewWords[i].isSelected == true) {
        wordTextSpan = TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        );
      // If there is not a selected word
      } else {
        wordTextSpan = TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
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
  }

}
