import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:hive/hive.dart';

import '../models/models.dart';
import '../database/hb_db_helper.dart';

import '../database/user_data/user.dart';


/// A provider for the Hive [User] database. 
class UserData with ChangeNotifier {
  static final _boxName = 'user';
  var box = Hive.box<User>(_boxName);
  bool loaded = false;
  
  /// Return true if the [Vocab] database is initialized.
  bool get initialized {
    return box.isNotEmpty;
  }
  
  String get name {
    return user.firstName;
  }

  User get user {
    return box.values.first;
  }

  void clearData() {
    box.deleteAll(box.keys);
    notifyListeners();
  }

  // TODO: why is this still here?
  void load() {
    loaded = true;
    notifyListeners();
  }

}

final userDataProvider = ChangeNotifierProvider<UserData>((ref) {
  return UserData();
});