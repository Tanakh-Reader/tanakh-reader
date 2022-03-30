import 'package:flutter/material.dart';
import 'package:hebrew_literacy_app/ui/widgets/reader_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart';

import '../widgets/reader_screen/reader_screen.dart';
import '../../data/providers/hebrew_passage.dart';
import '../../data/models/models.dart';


class ReaderScreen extends StatelessWidget {
  const ReaderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _hebrewPassageFuture = Provider.of<HebrewPassage>(
      context, listen: false).getPassageWordsByRef(4, 29);

    return FutureBuilder(
      future: _hebrewPassageFuture,
      builder: (ctx, snapshot) => 
      // Make sure the data is loaded. 
      snapshot.connectionState == ConnectionState.waiting 
      ? const Center(
        child: CircularProgressIndicator()
      )
      : Consumer<HebrewPassage>(
            builder: (ctx, hebrewPassage, _) {
            return Stack(
          children: [
            const PassageDisplay(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<HebrewPassage>(
                builder: (ctx, hebrewPassage, _) =>
                  hebrewPassage.hasSelection
                    ? WordExpansionPanel(hebrewWord: hebrewPassage.selectedWord!)
                    : const Text('NA',
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.normal
                      ),
                    )
              ),
            ),
            ReferencesExpansionPanel()
        ],
          );
            }
      )
    );
  }
}