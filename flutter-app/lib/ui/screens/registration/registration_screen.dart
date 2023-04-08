import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tanakhreader/data/database/firebase-realtime/bible_db_helper.dart';
import 'package:tanakhreader/ui/components/registration/email_sign_in_button.dart';
import 'package:tanakhreader/ui/components/registration/registration_fields.dart';
import 'package:tanakhreader/ui/screens/screens.dart';
import 'package:tanakhreader/utils/authentication.dart';

import '../../components/registration/google_sign_in_button.dart';
import '../../components/registration/register_button.dart';
import '../profile_screen.dart';
import 'registration_screen.dart';
import 'sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';


class RegisteredUser {

  String id;
  String firstName;
  String lastName;

  RegisteredUser({
    required this.id,
    required this.firstName,
    required this.lastName
  });

}

// Returns true if email address is in use.
Future<bool> checkIfEmailInUse(String emailAddress) async {
  try {
    // Fetch sign-in methods for the email address
    final list =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

    // In case list is not empty
    if (list.isNotEmpty) {
      // Return true because there is an existing
      // user using the email address
      return true;
    } else {
      // Return false because email adress is not in use
      return false;
    }
  } catch (error) {
    // Handle error TODO
    // ...
    return true;
  }
}

class UserDB {

  final DatabaseReference _ref = FirebaseDatabase.instance.ref('users/');


  Future<Object?> getUserByUserId(String userId) async {

    final snapshot = await _ref.child(userId).get();

    if (snapshot.exists) {
        return snapshot.value;
    } else {
        return null;
    }
  }

  Future<void> addNewUser(RegisteredUser user) async {
    
    await _ref.child(user.id).set({
      "firstName": user.firstName,
      "lastName": user.lastName,
    });

  }

}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phoneNumber = TextEditingController();

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _fullFormKey = GlobalKey<FormState>();

  // final AuthService _auth = AuthService();
  
  final UserDB _userDB = UserDB();
  

  bool emailEntered = false;
  bool emailInUse = false;
  bool userFullyRegistered = false;

  @override
  Widget build(BuildContext context) {
    // final txtbutton = TextButton(
    //     onPressed: () {
    //       // TODO : navigate to register screen
    //       Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => SignInScreen()),
    //       );
    //     },
    //     child: const Text('Sign In'));

    final bdb = RealtimeBibleDatabaseHelper();
    print("CALLING FUNCTION");
    bdb.getBooks();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register Demo Page'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !emailEntered
              ? Form(
                  key: _emailFormKey,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            EmailField(email: _email),
                            // Next Button. 
                            TextButton(
                                onPressed: () async {
                                  if (_emailFormKey.currentState!.validate()) {
                                    emailInUse =
                                        await checkIfEmailInUse(_email.text);
                                    // var user = await 
                                    // userFullyRegistered = await _userDB.getUserByUserId(userId);
                                    // Take user to SignIn screen if the email is already registered.
                                    if (emailInUse) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => SignInScreen(
                                            email: _email,
                                          ),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        emailEntered = !emailEntered;
                                      });
                                    }
                                  }
                                },
                                child: Text('Next')),
                                Text('Contine with X Account'),
                                GoogleSignInButton()
                          ])))
              : Form(
                  key: _fullFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => setState(() {
                                        emailEntered = !emailEntered;
                                      }), 
                          child: Text('Back')),
                        const SizedBox(height: 25.0),
                        EmailField(email: _email),
                        const SizedBox(height: 25.0),
                        FirstNameField(firstName: _firstName),
                        const SizedBox(height: 25.0),
                        LastNameField(lastName: _lastName),
                        const SizedBox(height: 25.0),
                        PhoneNumberField(phoneNumber: _phoneNumber),
                        const SizedBox(height: 25.0),
                        PasswordField(password: _password),
                        const SizedBox(height: 25.0),
                        RegisterButton(
                            formKey: _emailFormKey,
                            email: _email,
                            password: _password),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
          
        ],
      ),
    );
  }
}
