import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/providers/providers.dart';

import '../../../../data/models/strongs.dart';
import '../../../../theme.dart';
import '../word_expansion_panel.dart';


class ListItem {
  bool isSelected = false; //Selection property to highlight or not
  String text; //Data of the user
  ListItem(this.text); //Constructor to assign the data
}

class HebrewWordsList extends StatefulWidget {
  final hebrewData;
  HebrewWordsList({ Key? key, required this.hebrewData}) : super(key: key);

  @override
  State<HebrewWordsList> createState() => _HebrewWordsListState();
}

class _HebrewWordsListState extends State<HebrewWordsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}



class SaveWordTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final userVocab = ref.watch(userVocabProvider);
    final hebrewPassage = ref.read(hebrewPassageProvider);
    final word = hebrewPassage.selectedWord;
    final lex = hebrewPassage.lex(word!.lexId!);

    return GestureDetector(
        onTap: () async {
          userVocab.toggleSaved(lex);
          if (userVocab.isSaved(lex)) {
            var definitions = await hebrewPassage.getStrongs(word);
            if (definitions.isNotEmpty) {
              var formatted = _buildStrongsText(definitions);
              userVocab.addDefinitions(lex, formatted);
          }
          }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          height: 45,
          width: double.infinity,
          color: MyTheme.bgColor,
          child: userVocab.isSaved(lex)
              ? Text('${lex.text} is saved')
              // style: textColor)
              : Text('Add ${lex.text} to dictionary'),
          // style: textColor)),
        ));
  }

  List<String> _buildStrongsText(List<Strongs> strongsData) {
    List<String> allDefinitions = [];
    for (var strongs in strongsData) {
      if (strongs != null) {
        var definitions = strongs.definition!.split('<br>');
        for (var def in definitions) {
          allDefinitions.add(def);
        }
      }
    }
    return allDefinitions;
  }
}
/*
  englishContextDialogue(context, ref,) => showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          final hebrewPassage = ref.read(hebrewPassageProvider);
          final word = hebrewPassage.selectedWord;
          final strongsData = hebrewPassage.getStrongs(word!);
          return AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            // contentPadding: EdgeInsets.all(0),
            content: Container(
              alignment: Alignment.centerLeft,
              // height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Text("Select Hebrew Forms"),
                    FutureBuilder<List<Strongs>>(
                    future: strongsData,
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.done
                            ? _strongsText(snapshot.data!).map(
                              (def) => Row())
                            : CircularProgressIndicator()),
                    )
                    Text("Select English Translations"),

                    SizedBox(height: 20,),
                    RichText(
                      text: TextSpan(
                        children: 
                        _buildEnglishSpans(ref, false)
                      ),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.justify,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Dismiss'),
                    )
                  ],
                ),
              ),
        );
      }
    );

    List<String> _strongsText(List<Strongs> strongsData) {
    List<String> allDefinitions = [];
    for (var strongs in strongsData) {
      if (strongs != null) {
        var definitions = strongs.definition!.split('<br>');
        for (var def in definitions) {
          allDefinitions.add(def);
        }
      }
    }
    return allDefinitions;
  }
}

List<ListItem<String>> list;
@override
void initState() {
super.initState();
populateData();
}
void populateData() {
list = [];
for (int i = 0; i < 10; i++) 
    list.add(ListItem<String>("item $i"));
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("List Selection"),
),
body: ListView.builder(
itemCount: list.length,
itemBuilder: _getListItemTile,
),
);
}
Widget _getListItemTile(BuildContext context, int index) {
return GestureDetector(
onTap: () {
if (list.any((item) => item.isSelected)) {
setState(() {
list[index].isSelected = !list[index].isSelected;
});
}
},
onLongPress: () {
setState(() {
list[index].isSelected = true;
});
},
child: Container(
margin: EdgeInsets.symmetric(vertical: 4),
color: list[index].isSelected ? Colors.red[100] : Colors.white,
child: ListTile(
title: Text(list[index].data),
),
),*/