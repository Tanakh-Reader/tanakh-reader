import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:hebrew_literacy_app/ui/widgets/read_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import '../../data/providers/user.dart';
import '../../data/database/user_data/user.dart';

var NAME = 'user';
Map<ReadingLevel, String> READING_LEVELS = {
  ReadingLevel.beginner: "Beginner", // 103 lexemes
  ReadingLevel.elementary: "Elementary", // 249 lexemes
  ReadingLevel.intermediate: "Intermediate", // 433 lexemes
  ReadingLevel.advanced: "Advanced", // 740 lexemes
  ReadingLevel.expert: "Expert" // 1162 lexemes
};

final DROPDOWN = "Reading Level";

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(userDataProvider);
    ref.read(userVocabProvider);
    ref.read(textDisplayProvider);
  }

  String dropdownValue = DROPDOWN;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userData = ref.read(userDataProvider);
    final userVocab = ref.read(userVocabProvider);
    final textDisplay = ref.read(textDisplayProvider);

    var a = DropdownMenuItem<String>(
                    value: DROPDOWN,
                    child: Text(DROPDOWN),
    );
    List<DropdownMenuItem<String>> vals = ReadingLevel.values
                    .map((value) {
                  String name = "${READING_LEVELS[value]} (${LEX_MAP[value]}+ occurences)";
                  return DropdownMenuItem<String>(
                    value: READING_LEVELS[value] as String,
                    child: Text("$name"),
                  );
                }).toList();
    vals.add(a);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  // PUT APP LOGO HERE
                  child: Container(
                      width: 250,
                      height: 150,
                      child:  Text('User Settings', style: TextStyle(fontSize: 25),),
                      )
                  )
                
              ),
            
            SizedBox(height: 20,),
            Text("Current Level: ${READING_LEVELS[userData.user.readingLevel]}"),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down_rounded),
              elevation: 16,
              style: const TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: vals,
            ),
            SizedBox(height: 20,),
            TextButton(
              onPressed: () {
                var box = Hive.box<User>(NAME);
                if (true) {
                    var user = userData.user;
                    var level = READING_LEVELS.keys.firstWhere(
                      (k) => READING_LEVELS[k] == dropdownValue);
                    user.readingLevel = level;
                    user.save();
                    userVocab.reInitializeVocab();
                    userVocab.load();
                }

              },
              child: Text(
                  'Update',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Text('verse'),
              Checkbox(
                value: textDisplay.verse,
                onChanged: (bool? value) {
                  setState(() {
                    textDisplay.toggleVerse();
                  });
                },
              ),
              Text('clause'),
              Checkbox(
                // checkColor: Colors.white,
                // fillColor: MaterialStateProperty.resolveWith(getColor),
                value: textDisplay.clause,
                onChanged: (bool? value) {
                  setState(() {
                    textDisplay.toggleClause();
                  });
                },
              ),
              Text('phrase'),
              Checkbox(
                value: textDisplay.phrase,
                onChanged: (bool? value) {
                  setState(() {
                    textDisplay.togglePhrase();
                  });
                },
              )
            // User Settings
          ],
        ),
      ),
    );
    /* https://docs.flutter.dev/cookbook/forms/retrieve-input
    @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  */
  }
}
