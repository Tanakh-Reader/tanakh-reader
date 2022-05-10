import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/providers.dart';
import '../../../data/models/models.dart';
import '../../screens/read_screen.dart';

class VocabCard extends ConsumerWidget {
  Lexeme vocabWord;
  VocabCard({Key? key, required this.vocabWord}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userVocab = ref.watch(userVocabProvider);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        userVocab.toggleSaved(vocabWord);
      },
      // https://stackoverflow.com/questions/55777213/flutter-how-to-use-confirmdismiss-in-dismissible
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsets.only(right: 10),
        child: FaIcon(FontAwesomeIcons.trashCan, color: Colors.red,),
      ),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
              Text(vocabWord.text!,
                  style: TxtTheme.hebrewStyle
                      .copyWith(fontWeight: FontWeight.bold,
                      fontSize: TxtTheme.normSize - 4)),
              SizedBox(
                height: 10,
              ),
              Text("${MORPH_MAP[vocabWord.speech]!},   ${vocabWord.gloss!}"),
            ]),
            Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => userVocab.toggleKnown(vocabWord),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.greenAccent,
                    child: userVocab.isKnown(vocabWord)
                        ? FaIcon(FontAwesomeIcons.check, color: Colors.black, size: 20,)
                        : CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.black,
                          ),
                  ),
                ))
          ])),
    );
  }
}
