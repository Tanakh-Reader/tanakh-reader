
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanakhreader/ui/components/registration/sign_in_fields.dart';
import 'package:tanakhreader/ui/screens/screens.dart';
import 'package:tanakhreader/utils/authentication.dart';



// TODO maybe add context as well ?
class RegisterButton extends StatelessWidget {

  const RegisterButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController email,
    required TextEditingController password,
    }) 
    : 
    _formKey = formKey,
    _email = email,
    _password = password,
    super(key: key);

  final TextEditingController _email;
  final TextEditingController _password;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return  Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
          
              User result = await _auth.registerEmailPassword(LoginUser(email: _email.text,password: _password.text));
              if (result.uid == null) { //null means unsuccessfull authentication
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // content: Text(result.code),
                                                content: Text(result.uid),

                      );
                    });
          }
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
