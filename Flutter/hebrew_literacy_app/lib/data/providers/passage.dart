import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:hive/hive.dart';

import '../database/user_data/passage.dart';
import '../models/models.dart';
import '../database/hebrew_bible_data/hb_db_helper.dart';

import '../database/user_data/user.dart';


/// A provider for the Hive [User] database. 
class PassageData with ChangeNotifier {
  static final _boxName = 'passage';
  var box = Hive.box<Passage>(_boxName);


  /// Return true if the [Passage] database is initialized.
  get isInitialized {
    return box.isNotEmpty;
  }

  get passages {
    return box.values;
  }

  /// Return true if the [Vocab] database is initialized.
  void insertWeightedPassage(WeightedPassage weightedPassage) {
    var passage = Passage();

    passage.passageId = weightedPassage.id!;
    passage.wordCount = weightedPassage.wordCount!;
    passage.weight = weightedPassage.weight!;
    passage.startVsId = weightedPassage.startVsId!;
    passage.endVsId = weightedPassage.endVsId!;
    passage.bookId = weightedPassage.bookId!;
    passage.chapters = weightedPassage.chapters.toList();
    passage.startVs = weightedPassage.startVs!;
    passage.endVs = weightedPassage.endVs!;
    passage.isChapter = weightedPassage.isChapter!;
    passage.lexIds = weightedPassage.lexIds!.toList();
    passage.sampleText = weightedPassage.sampleText!;

    box.put(weightedPassage.id!, passage);
  }

  Future<void> initializePassages(int limit) async {
    // if (isInitialized) {
      box.deleteAll(box.keys);
      List<WeightedPassage> passages = await 
        HebrewDatabaseHelper().loadPassagesData(limit);

      for (WeightedPassage p in passages) {
        insertWeightedPassage(p);
      }
    // }

  }

  void clearData() {
    box.deleteAll(box.keys);
    notifyListeners();
  }

  // TODO: why is this still here?
  void load() {
    // loaded = true;
    notifyListeners();
  }

}

final passageDataProvider = ChangeNotifierProvider<PassageData>((ref) {
  return PassageData();
});