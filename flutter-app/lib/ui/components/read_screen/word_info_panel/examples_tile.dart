import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/providers/providers.dart';

import '../../../../theme.dart';
import '../word_expansion_panel.dart';

class ExamplesTile extends ConsumerStatefulWidget {
  @override
  _ExamplesTileState createState() => _ExamplesTileState();
}

class _ExamplesTileState extends ConsumerState<ExamplesTile> {
  var examplesData;
  void loadData(future) {
    setState(() {
      examplesData = future;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final word = hebrewPassage.selectedWord;
    return ExpansionTile(
        backgroundColor: MyTheme.bgColor,
        textColor: MyTheme.selectedTileText,
        collapsedTextColor: MyTheme.greyText,
        collapsedBackgroundColor: MyTheme.bgColor,
        onExpansionChanged: (expanding) {
          if (expanding) {
            loadData(hebrewPassage.getLexSentences(word!));
          }
        },
        title: Text('EXAMPLES'),
        children: [
          Container(
            alignment: Alignment.topRight,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: examplesData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Align(
                          alignment: Alignment.center, 
                          child: CircularProgressIndicator()
                          ),
                      );
                    } else if (snapshot.hasData) {
                      return RichText(
                        text: _buildExamplesText(
                            word, snapshot.data!, hebrewPassage),
                        textDirection: TextDirection.rtl,
                      );
                    } else {
                      int freq = hebrewPassage.lex(word!.lexId!).freqLex!;
                      String msg = freq > 1000
                      ? "Examples not provided for words this common"
                      : "No other examples for ${word.text}";
                      return Text(msg);
                    }
                  }),
            ),
          ),
        ]);
  }

  TextSpan _buildExamplesText(word, examplesData, hebrewPassage) {
    List<TextSpan> examples = [];
    for (var example in examplesData) {
      var book = hebrewPassage.getBook(example.first);
      examples.add(TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
          text:
              "${book.name} ${example.first.chBHS}:${example.first.vsBHS}\n"));
      // TODO : add logic to shorten super long sentences.
      for (var i = 0; i < example.length; i++) {
        var _word = example[i];
        examples.add(TextSpan(
            text: _word.text ?? '',
            style: TxtTheme.hebrewStyle.copyWith(
              color: _word.lexId == word.lexId 
                ? Colors.blue[200]
                : Colors.white,
              fontSize: TxtTheme.normSize - 6,
                fontWeight: _word.lexId == word.lexId
                    ? TxtTheme.selWeight
                    : TxtTheme.normWeight)));
        examples.add(TextSpan(
          style: TxtTheme.hebrewStyle.copyWith(
            fontSize: TxtTheme.normSize - 6
          ),
          text: _word.trailer ?? '',
        ));
      }
      examples.add(TextSpan(
        text: " ... " + '\n\n',
      ));
    }
    return TextSpan(children: examples);
  }
}