import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/vocab_screen/vocab_screen.dart';
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
    final savedVocab = userVocab.savedVocab;
    return Stack(
      children:[ Column(
        children: [
              SizedBox(height: 40,),
              Center(child: Text("Saved Vocab", style: Theme.of(context).textTheme.headline5,)),
              SizedBox(height: 10),
              savedVocab.isNotEmpty
              ?
              Expanded(
                  child: ListView.builder(
                    itemCount: savedVocab.length,
                    itemBuilder: (ctx, int index) {
                      var lex = userVocab.lex(savedVocab[index]);
                      return Center(child: VocabCard(vocabWord: lex,));
                    }
                  ),
              )
              : Center(child: Text("Nothing Saved..."),)
        ]
      ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: IconButton(
            onPressed: () async => exportVocab(ref),
            icon: FaIcon(FontAwesomeIcons.shareFromSquare)),
        ),
      )
      ]
    );
  }
}
