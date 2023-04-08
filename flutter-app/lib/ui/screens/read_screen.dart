import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/ui/components/read_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart';

import '../components/read_screen/read_screen.dart';
import '../../data/providers/hebrew_passage.dart';
import '../../data/models/models.dart';
import '../components/read_screen/reference_button.dart';


class ReadScreen extends ConsumerWidget {
  static const routeName = '/read';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Read built");
    final hebrewPassage = ref.watch(hebrewPassageProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: 
        hebrewPassage.isLoaded ?
        Stack(
          children: [
            // Column(children: [Expanded(child: 
            Align(alignment: Alignment.centerRight,
              child: PassageDisplay()),
            // )]),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: hebrewPassage.hasSelection
            //     ? WordExpansionPanel()
            //     : const SizedBox()
            // ),
            Align( 
              alignment: Alignment.topCenter,
              child: ReferencesExpansionPanel(button: ReferenceButton())
            )
          ],
        )
        : Center(child: Text("No passages loaded..."))
    );
  }
}