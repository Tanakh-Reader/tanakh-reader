import 'package:flutter/material.dart';
import '../../../data/models/hebrew_word.dart';


class WordExpansionPanel extends StatefulWidget {
  final HebrewWord hebrewWord;
  const WordExpansionPanel({ 
    Key? key,
    required this.hebrewWord
  }) : super(key: key);

  @override
  _WordExpansionPanelState createState() => _WordExpansionPanelState();
}

class _WordExpansionPanelState extends State<WordExpansionPanel> {

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    HebrewWord word = widget.hebrewWord;
    return SingleChildScrollView(
      child: ExpansionPanelList(
        // animationDuration: Duration(milliseconds: 2000),
        children: [
          ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text('${word.pointedText} information', style: TextStyle(color: Colors.black),),
                );
              },
              body: Column(
                // title: Text('Description text',style: TextStyle(color: Colors.black)),
                children: [
                  Text('${word.freqLex}'),
                  Text('${word.speech}'),
                ]
              ),
            isExpanded: _expanded,
            canTapOnHeader: true,
          ),
        ],
        dividerColor: Colors.grey,
        expansionCallback: (panelIndex, isExpanded) {
          _expanded = !_expanded;
          setState(() {
          });
        },
      ),
    );
  }
}