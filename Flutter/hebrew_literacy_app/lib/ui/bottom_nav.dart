import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/providers/providers.dart';
import 'screens/screens.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  final tabManager;
  const BottomNavBar({Key? key, required this.tabManager}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    ref.read(hebrewPassageProvider);
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    // ...
    animationController.dispose();
    super.dispose();
  }

// class BottomNavBar extends StatelessWidget{
  // final tabManager;
  // BottomNavBar({ Key? key, required this.tabManager }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final hebrewPassage = ref.read(hebrewPassageProvider);
    // https://github.com/pinkeshdarji/flutter_bottom_navigation_bar/blob/master/lib/hide_on_scroll.dart
    return 
    // TODO - implement
    // https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/
    // SizeTransition(
    //     sizeFactor: animationController,
    //     axisAlignment: -1.0,
    //     child: 
        BottomNavigationBar(
          // Set the selection color of an item when tapped.
          selectedItemColor: Theme.of(context)
            .textSelectionTheme.selectionColor,
          // Sets the current index of BottomNavigationBar.
          currentIndex: widget.tabManager.selectedTab,
          onTap: (index) {
            // TODO - does this need to be here?
            if (hebrewPassage.hasSelection) {
              hebrewPassage.deselectWords();
            }
            widget.tabManager.goToTabIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Read',
            ),
            // TODO implement custom Hebrew Icon
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.font),
              label: 'Vocab',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Passages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],     
        // ),
    );
  }
}