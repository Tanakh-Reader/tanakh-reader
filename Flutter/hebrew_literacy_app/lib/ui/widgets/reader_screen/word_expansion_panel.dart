import 'package:flutter/material.dart';
import '../../../data/models/word.dart';


class WordExpansionPanel extends StatefulWidget {
  final Word hebrewWord;
  const WordExpansionPanel({ 
    Key? key,
    required this.hebrewWord
  }) : super(key: key);

  @override
  _WordExpansionPanelState createState() => _WordExpansionPanelState();
}

class _WordExpansionPanelState extends State<WordExpansionPanel> {

  bool _expanded = false;
  List<String> nouns = ['subs', 'nmpr', 'prps', 'prde', 'prin', 'adkv'];

  @override
  Widget build(BuildContext context) {
    Word word = widget.hebrewWord;
    Widget wordDisplay;
    if (nouns.contains(word.speech)) {
      wordDisplay = _nounDisplay(word);
    } else if (word.speech == 'verb') {
      wordDisplay = _verbDisplay(word);
    } else {
      wordDisplay = _otherDisplay(word);
    }

    TextStyle textColor = const TextStyle(color: Colors.white);

    return SizedBox(
      // height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList(
              // animationDuration: Duration(milliseconds: 2000),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text('${word.text} information', style: textColor),
                    );
                  },
                  body: wordDisplay,
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                ),
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text('Examples', style: textColor),
                    );
                  },
                  body: const Text('ברשית ברא אלוהים את האשמים ואת הארץ'),
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                ),
              //   ExpansionPanel(
              //     headerBuilder: (context, isExpanded) {
              //       return ListTile(
              //         title: Text('Add word to dictionary', style: textColor),
              //       );
              //     },
              //     body: const Text('ברשית ברא אלוהים את האשמים ואת הארץ'),
              //     isExpanded: _expanded,
              //     canTapOnHeader: true,
              //   ),
              ],
              dividerColor: Colors.grey[900],
              expansionCallback: (panelIndex, isExpanded) {
                _expanded = !_expanded;
                setState(() {
                });
              },
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.all(10),
              height: 40,
              width: double.infinity,
              color: Colors.grey[800],
              child: Text('Add word to dictionary', style: textColor)
            ),
          ],
        ),
      ),
    );
  }

  Widget _verbDisplay(Word word) {
    return Column(
      children: [
        Text('${word.text} occurs ${word.freqOcc} times'),
        Text('${word.glossExt}'),
        Text('${word.speech}'),
        Text('${word.person}'),
        Text('${word.vStem} stem'),
        Text('${word.vTense} tense'),
      ]
    );
  }

  Widget _nounDisplay(Word word) {
    return Column(
      children: [
        Text('${word.text} occurs ${word.freqOcc} times'),
        Text('${word.glossExt}'),
        Text('${word.speech}'),
        Text('${word.gender}, ${word.number}'),
      ]
    );
  }

  Widget _otherDisplay(Word word) {
    return Column(
      children: [
        Text('${word.text} occurs ${word.freqOcc} times'),
        Text('${word.glossExt}'),
        Text('${word.speech}'),
      ]
    );
  }
}