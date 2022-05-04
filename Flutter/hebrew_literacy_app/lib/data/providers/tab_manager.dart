import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Screens {
  home,
  read,
  vocab,
  passages,
  profile,
}

class TabManager extends ChangeNotifier {
  // selectedTab keeps track of which tab the user tapped.
  int selectedTab = Screens.home.index;

  // goToTab is a simple function that modifies the current tab index.
  void goToTab(index) {
    // Stores the index of the new tab the user tapped.
    selectedTab = index;
    // Calls notifyListeners() to notify all widgets listening to this state.
    notifyListeners();
  }
  
}

final tabManagerProvider = ChangeNotifierProvider<TabManager>((ref) {
  return TabManager();
});