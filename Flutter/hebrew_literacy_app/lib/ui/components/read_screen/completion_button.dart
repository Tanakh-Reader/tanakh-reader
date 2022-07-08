import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hebrew_literacy_app/data/providers/passage.dart';


import '../../../data/database/user_data/passage.dart';


class CompletionButton extends ConsumerWidget {
  final Passage passage;
  CompletionButton({required this.passage});
  
  final width = 160.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passageData = ref.watch(passageDataProvider);
    var icon = FaIcon(FontAwesomeIcons.question, size: 14,);
    Color color = Colors.blueAccent;
    if (passage.completed) {
      icon = FaIcon(FontAwesomeIcons.check, size: 14,);
      color = Colors.grey;
    }
    return GestureDetector(
      onTap: () => passageData.toggleCompleted(passage),
      child: Container(
        width: width as double,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration( 
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        alignment: Alignment.center,
        child: Container(
          width: width - 50,
          child: Row(
            children: [
            Text("Completed"),
            SizedBox(width: 20,),
            icon
            ]
          ),
        ),
      ),
    );
  }
}