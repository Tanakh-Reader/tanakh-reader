import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/ui/screens/screens.dart';


import 'bottom_nav.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class Views extends ConsumerWidget {

  static List<Widget> pages = <Widget>[
    HomeScreen(),
    ReadScreen(),
    VocabScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabManager = ref.watch(tabManagerProvider);
    return Scaffold(
      body: IndexedStack(
        index: tabManager.selectedTab, 
        children: pages),
      bottomNavigationBar: BottomNavBar(tabManager: tabManager)
    );
  }
}