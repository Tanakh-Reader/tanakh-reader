
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanakhreader/ui/components/registration/email_sign_in_button.dart';
import 'package:tanakhreader/ui/components/registration/sign_in_fields.dart';
import 'package:tanakhreader/ui/screens/screens.dart';
import 'package:tanakhreader/utils/authentication.dart';

import '../../components/registration/google_sign_in_button.dart';
import '../profile_screen.dart';
import 'registration_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

    bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final txtbutton = TextButton(
        onPressed: () {
          // TODO : navigate to register screen
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => RegistrationScreen()
          ),
      );
        },
        child: const Text('New? Register here'));

    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Demo Page'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          
                  EmailField(email: _email),
                  const SizedBox(height: 25.0),
                  PasswordField(password: _password),
                  txtbutton,
                  const SizedBox(height: 35.0),
                  EmailSignInButton(formKey: _formKey, email: _email, password: _password),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
              
            GoogleSignInButton()
                 
            ],
          ),
      ); 
  }
}