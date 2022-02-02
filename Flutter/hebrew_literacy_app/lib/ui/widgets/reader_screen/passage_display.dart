import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/* PassageDisplay returns a RichText containing all of the word objects that will be displayed
for a given passage. Each word is placed in a TextSpan such that its attributes can be accessed
via a gesture detector. */

class PassageDisplay extends StatefulWidget {
  const PassageDisplay({ Key? key }) : super(key: key);

  @override
  _PassageDisplayState createState() => _PassageDisplayState();
}

class _PassageDisplayState extends State<PassageDisplay> {

  // Create a textspan for each word in the passage.
  List<TextSpan> createTextSpans(){
    final string = """Text seems like it should be so simple, but it really isn't.""";
    final arrayStrings = string.split(" ");
    List<TextSpan> arrayOfTextSpan = [];
    for (int index = 0; index < arrayStrings.length; index++){
      final text = arrayStrings[index] + " ";
      final span = TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
        ),
        recognizer: TapGestureRecognizer()..onTap = () => print("The word touched is $text")
      );
      arrayOfTextSpan.add(span);
    }
    return arrayOfTextSpan;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          children: createTextSpans()
        )
    );
  }
}