import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';
import 'package:hebrew_literacy_app/ui/widgets/read_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart' as pro;

import '../bottom_nav.dart';
import 'read_screen.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen ({ Key? key }) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Home built");
    return ReferencesExpansionPanel(
      button: Center(
        child: Icon(Icons.menu_book_rounded),
      ),
    );
  }
}


  
