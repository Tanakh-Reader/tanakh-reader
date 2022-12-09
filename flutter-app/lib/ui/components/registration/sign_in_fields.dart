
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanakhreader/ui/screens/screens.dart';
import 'package:tanakhreader/ui/screens/registration/sign_in_screen.dart';
import 'package:tanakhreader/utils/authentication.dart';


class FirstNameField extends StatelessWidget {

  const FirstNameField({
    Key? key,
    required TextEditingController firstName
    }) 
    : 
    _firstName = firstName,
    super(key: key);

  final TextEditingController _firstName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _firstName,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "First Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }
}

class EmailField extends StatelessWidget {

  const EmailField({
    Key? key,
    required TextEditingController email
    }) 
    : 
    _email = email,
    super(key: key);

  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _email,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required TextEditingController password
    }) 
    : 
    _password = password,
    super(key: key);

  final TextEditingController _password;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) {

    return TextFormField(
        obscureText: _obscureText,
        controller: widget._password,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));
  }
}
