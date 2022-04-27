import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/ui/widgets/read_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart';

import '../widgets/read_screen/read_screen.dart';
import '../../data/providers/hebrew_passage.dart';
import '../../data/models/models.dart';
import '../widgets/read_screen/reference_button.dart';


class ReadScreen extends ConsumerWidget {
  const ReadScreen({ Key? key}) : super(key: key);

  static const routeName = '/read';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Read built");
    final hebrewPassage = ref.watch(hebrewPassageProvider);
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [Expanded(child: PassageDisplay())]),
          Align(
            alignment: Alignment.bottomCenter,
            child: hebrewPassage.hasSelection
              ? WordExpansionPanel()
              : const SizedBox()
          ),
          ReferencesExpansionPanel(button: ReferenceButton())
        ],
      ),
    );
  }
}