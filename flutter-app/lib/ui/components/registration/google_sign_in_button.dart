
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanakhreader/constants.dart';
import 'package:tanakhreader/utils/authentication.dart';

import '../../screens/profile_screen.dart';
import '../../views.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : GestureDetector(
              onTap: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await AuthService.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Views(),
                      // UserInfoScreen(
                      //   user: user,
                      // ),
                    ),
                  );
                }
            
              },
              // TODO: add theme conditional 
              child: Image(
                      image: lightGoogleSignInButton,
                      height: 50,
                    
                ),
              ),
            );
  }
}