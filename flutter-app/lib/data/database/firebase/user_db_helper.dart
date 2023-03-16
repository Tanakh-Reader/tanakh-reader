

import 'package:firebase_database/firebase_database.dart';

class FirebaseUserDatabaseHelper {

  final DatabaseReference _ref = FirebaseDatabase.instance.ref('users/');


  Future<Object?> getUserByUserId(String userId) async {

    final snapshot = await _ref.child(userId).get();

    if (snapshot.exists) {
        return snapshot.value;
    } else {
        return null;
    }
  }

  // Future<void> addNewUser(RegisteredUser user) async {
    
  //   await _ref.child(user.id).set({
  //     "firstName": user.firstName,
  //     "lastName": user.lastName,
  //   });

  // }

}
