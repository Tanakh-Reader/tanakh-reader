import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class VocabScreen extends ConsumerWidget {
  VocabScreen ({ Key? key }) : super(key: key);

  static const routeName = '/vocab';
  // final x = HebrewDatabaseHelper().testyTest2(1, 400);
  // Future<List<Lexeme>> _someLex = HebrewDatabaseHelper().testyTest(1, 400);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var userVocab = ref.watch(userVocabProvider);
    return Column(
      children: [

        // FutureBuilder(
        //   future: _allLexemes,
        //   builder: (ctx, snapshot) {
        //     List<Lexeme> _lexemes = snapshot.data as List<Lexeme>;
        //     return snapshot.connectionState == ConnectionState.waiting 
        //     ? const Center(
        //       child: CircularProgressIndicator()
        //     )
        //     : 
            // SizedBox(
            //   height: 500,
            //   child: 
            SizedBox(height: 100,),
            Center(child: Text("Saved Vocab"),),
            SizedBox(height: 10),
            userVocab.savedVocab.isNotEmpty
            ?
            Expanded(
              child: ListView.builder(
                itemCount: userVocab.savedVocab.length,
                itemBuilder: (ctx, int index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text('${userVocab.lex(userVocab.savedVocab[index]).text}',
                        textAlign: TextAlign.right, textDirection: TextDirection.rtl,),
                      ),
                      SizedBox(width: 20,),
                      SizedBox(
                        width: 80,
                        child: Text('${userVocab.lex(userVocab.savedVocab[index]).gloss}')
                      ),
                      SizedBox(width: 100,),
                      GestureDetector(
                        onTap: () {
                          userVocab.toggleSaved(userVocab.savedVocab[index]);
                        },
                        child: Text("Toggle")
                      )
                    ]
                    );
                  // );
                }
              ),
              // ),
            )
            : Center(child: Text("Nothing Saved..."),)
          // }
        // )
      ]
    );
  }
}
