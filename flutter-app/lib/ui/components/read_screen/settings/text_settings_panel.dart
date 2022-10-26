import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/constants.dart';
import 'package:tanakhreader/data/providers/passage.dart';
import 'package:tanakhreader/data/providers/providers.dart';
// import 'package:expandable/expandable.dart';
import 'package:tanakhreader/ui/screens/passages_screen.dart';
import 'package:path/path.dart';

import 'text_groupings.dart';


// TODO
// Use https://pub.dev/packages/expandable to make a better expansionPanel

class MyTheme {
  static final bgColor = Colors.grey[850];
  static final lineColor = Colors.grey[800];
  static final greyText = Colors.grey[400];
  static final textStyle = TextStyle(color: greyText);
  static final selectedTileText = Colors.white;
}

// TODO
// Make the panelSheet go from .4 size to .8 size on drag rather than
// allowing it to hangout in the middle. 


/// Used to display word information when a word is selected.
/// Takes a [context] and [ref] and returns [showModalBottomSheet]
textSettingsPanelSheet(context) => showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
          // The view can be scrolled up to maxHeight.
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          // Exits when the screen is less then minHeight.
          minHeight: MediaQuery.of(context).size.width * 0.2),
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return TextSettingsDisplay();
      },
    );

// If the space outside of the display data is tapped, exit ModalBottomSheet.
// https://www.youtube.com/watch?v=AjAQglJKcb4&t=394s&ab_channel=JohannesMilke
Widget makeDismissible({required Widget child, required context}) => GestureDetector(
  behavior: HitTestBehavior.opaque,
  onTap: () => Navigator.of(context).pop(),
  child: GestureDetector(onTap: () {}, child: child)
);

/// Used to construct the view of [wordPanelSheet].
class TextSettingsDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    // Declare providers.
    final hebrewPassage = ref.watch(hebrewPassageProvider);
    final textDisplay = ref.watch(textDisplayProvider);

    return makeDismissible(
      context: context,
      child: GestureDetector(
            // child:
              // (
                // Content can be scrolled to the full height of ModalBottomSheet.
                // This is the main visible data displayed for a selected word.
                child: DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    minChildSize: 0.3,
                    maxChildSize: 1,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                            // Give the display an outline.
                            border: Border.all(color: MyTheme.lineColor!),
                            color: MyTheme.bgColor,
                            // Make the top of the display rounded.
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15))),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Stack(
                              children: [
                              Column(
                                children: [
                                  // Grey bar to indicate the panel is draggable.
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    height: 6,
                                    width: 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[500],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                  // Word summary
                                  TextGroupings(),
                                  Container(height: 1, color: MyTheme.lineColor),
                                  
                                  
                                ],
                              ),
                              // Button to exit.
                              Positioned(
                                top: -5,
                                right: -5,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(Icons.close_rounded),
                                  iconSize: 24,
                                ),
                              )
                            ]),
                          ),
                      );
                    }),
          ),
        // ),
    );
  }
}





