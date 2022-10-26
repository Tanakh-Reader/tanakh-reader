import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/providers/passage.dart';
import 'package:tanakhreader/data/providers/providers.dart';
import 'package:tanakhreader/ui/components/read_screen/references_expansion_panel.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:tanakhreader/ui/screens/sign_in_screen.dart';
import 'package:tanakhreader/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


import '../../data/providers/user.dart';
import '../../data/database/user_data/user.dart';
/*
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
             ElevatedButton(
              onPressed: () {
                userData.clearData();
                userVocab.clearData();
                ref.read(passageDataProvider).resetData();
              },
              child: const Text('Clear User Data'),
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
                    userVocab.reinitializeVocab();
                    userVocab.load();
                }

              },
              child: Text(
                  'Update',
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
*/


class CustomColors {
  static final firebaseGrey = Colors.grey;
  static final firebaseNavy = Colors.blue;
  static final firebaseYellow = Colors.yellow;
  static final firebaseOrange = Colors.orange;

}


class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required auth.User user})
      : _user = user,
        super(key: key);

  final auth.User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late auth.User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: SizedBox(
          //  height: toolbarHeight,
           child: Image.asset("TITLE"),
         )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              _user.photoURL != null
                  ? ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Image.network(
                          _user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: CustomColors.firebaseGrey,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 16.0),
              Text(
                'Hello',
                style: TextStyle(
                  color: CustomColors.firebaseGrey,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                _user.displayName!,
                style: TextStyle(
                  color: CustomColors.firebaseYellow,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '( ${_user.email!} )',
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
                style: TextStyle(
                    color: CustomColors.firebaseGrey.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),
              SizedBox(height: 16.0),
              _isSigningOut
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.redAccent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isSigningOut = true;
                        });
                        await Authentication.signOut(context: context);
                        setState(() {
                          _isSigningOut = false;
                        });
                        Navigator.of(context)
                            .pushReplacement(_routeToSignInScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}