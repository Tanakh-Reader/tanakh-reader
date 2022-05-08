import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';

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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(userDataProvider);
    ref.read(userVocabProvider);
  }

  String dropdownValue = DROPDOWN;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userData = ref.read(userDataProvider);
    final userVocab = ref.read(userVocabProvider);

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
                      child: Column(children: [
                        Text('Hebrew Literacy App', style: TextStyle(fontSize: 25),),
                        SizedBox(height: 20,),
                        Icon(Icons.menu_book_rounded, size: 50,),
                      ])
                  )
                )
              ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
                controller: firstNameController,
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                ),
                controller: lastNameController,
              ),
            ),
            SizedBox(height: 20,),
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
            SizedBox(height: 100,),
            TextButton(
              onPressed: () async {
                var box = Hive.box<User>(NAME);
                print(dropdownValue);
                if (firstNameController.text.isNotEmpty 
                  && lastNameController.text.isNotEmpty
                  && dropdownValue != DROPDOWN) {
                    box.deleteAll(box.keys);
                    var level = READING_LEVELS.keys.firstWhere(
                      (k) => READING_LEVELS[k] == dropdownValue);
                    var user = User(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: '',
                      readingLevel: level
                    );
                    box.add(user);
                    userData.load();
                    await userVocab.initializeVocab();
                    userVocab.load();
                }

              },
              child: Text(
                'Register',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
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
