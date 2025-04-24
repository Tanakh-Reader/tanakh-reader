import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/providers/passage.dart';
import 'package:tanakhreader/data/providers/providers.dart';
import 'package:tanakhreader/ui/components/read_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/user_data/user.dart';
import '../../../../data/providers/user.dart';



class TextGroupings extends ConsumerWidget {
 
  @override
  Widget build(BuildContext context, ref) {

    // final userData = ref.read(userDataProvider);
    final textDisplay = ref.watch(textDisplayProvider);

    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 20),
                child: 
              Text('Text Groupings', style: Theme.of(context).textTheme.titleMedium,),),
              Row(children: [
              Row(children: [ 
                   Container(
                     padding: EdgeInsets.only(right: 10),
                     width: 100,
                     child: Text('Paragraph', textAlign: TextAlign.right)),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: textDisplay.paragraph,
                  onChanged: (bool? value) {
                    // setState(() {
                      textDisplay.toggleParagraph();
                    // });
                  },
                ),]),
                
                Row(children: [Container(
                  padding: EdgeInsets.only(right: 10),
                     width: 100,
                     child: Text('Clause', textAlign: TextAlign.right)),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: textDisplay.clause,
                  onChanged: (bool? value) {
                    // setState(() {
                      textDisplay.toggleClause();
                    // });
                  },
                ),]),
                ]),
                Row(children: [

                  Row(children: [ 
                   Container(
                     padding: EdgeInsets.only(right: 10),
                     width: 100,
                     child: Text('Verse', textAlign: TextAlign.right)),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: textDisplay.verse,
                  onChanged: (bool? value) {
                    // setState(() {
                      textDisplay.toggleVerse();
                    // });
                  },
                ),
                ]),
                
                Row(children: [Container(
                     width: 100,
                     padding: EdgeInsets.only(right: 10),
                     child: Text('Phrase', textAlign: TextAlign.right),),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: textDisplay.phrase,
                  onChanged: (bool? value) {
                    // setState(() {
                      textDisplay.togglePhrase();
                    // });
                  },
                )]),
              // User Settings
                ])
            ],
          ),
    );
  }
}
