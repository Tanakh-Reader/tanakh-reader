
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/constants.dart';
import 'package:tanakhreader/utils/authentication.dart';

import '../../../data/providers/user.dart';
import '../../screens/profile_screen.dart';
import '../../screens/register_screen.dart';
import '../../views.dart';

class GoogleSignInButton extends ConsumerStatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends ConsumerState<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {

    // TEMP
    final userData = ref.watch(userDataProvider);
    
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
                      builder: (context) =>    userData.isInitialized
              ? Views()
              : RegisterScreen(),
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