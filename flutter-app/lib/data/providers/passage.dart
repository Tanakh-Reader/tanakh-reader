import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/constants.dart';
import 'package:tanakhreader/data/providers/providers.dart';
import 'package:hive/hive.dart';

import '../database/user_data/passage.dart';
import '../models/models.dart';
import '../database/hebrew_bible_data/hb_db_helper.dart';

import '../database/user_data/user.dart';


enum OrderBy {
  weight,
  id,
  length
}

/// A provider for the Hive [User] database. 
class PassageData with ChangeNotifier {
  static final _boxName = 'passage';
  var box = Hive.box<Passage>(_boxName);


  /// Return true if the [Passage] database is initialized.
  get isInitialized {
    return box.isNotEmpty;
  }


  void insertWeightedPassage(WeightedPassage weightedPassage) {
    var passage = Passage();
    // if (weightedPassage.sampleText == null) {
    //   print(weightedPassage.id);
    // }

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

  void insertChapter(HebrewPassage chapterPassage) {
    var passage = Passage();
    // passage.passageId = weightedPassage.id!;
    // passage.wordCount = weightedPassage.wordCount!;
    // passage.weight = weightedPassage.weight!;
    // passage.startVsId = weightedPassage.startVsId!;
    // passage.endVsId = weightedPassage.endVsId!;
    // passage.bookId = weightedPassage.bookId!;
    // passage.chapters = weightedPassage.chapters.toList();
    // passage.startVs = weightedPassage.startVs!;
    // passage.endVs = weightedPassage.endVs!;
    // passage.isChapter = weightedPassage.isChapter!;
    // passage.lexIds = weightedPassage.lexIds!.toList();
    // passage.sampleText = weightedPassage.sampleText!;

    // box.put(weightedPassage.id!, passage);
  }

  Future<void> initializePassages(int limit) async {
    if (!isInitialized) {
      List<WeightedPassage> passages = await 
        HebrewDatabaseHelper().loadPassagesData(limit);

      for (WeightedPassage p in passages) {
        insertWeightedPassage(p);
      }
    }
  }

  // Future<void> addMorePassages(int limit) async {
  //   if (!isInitialized) {
  //     List<WeightedPassage> passages = await 
  //       HebrewDatabaseHelper().loadPassagesData(limit);

  //     for (WeightedPassage p in passages) {
  //       insertWeightedPassage(p);
  //     }
  //   }
  // }
  
  List<Passage> getPassages({OrderBy order = OrderBy.weight}) {
    var passages = box.values.where(
      ((p) => !p.isChapter)).toList();
    if (order == OrderBy.id) {
      passages.sort((a, b) => a.passageId.compareTo(b.passageId));
    } else if (order == OrderBy.length) {
      passages.sort((a, b) => a.wordCount.compareTo(b.wordCount));
    } else {
      passages.sort((a, b) => a.weight!.compareTo(b.weight!));
    }
    // notifyListeners();
    return passages;
  }

  Passage getPassage(passage) {
    return box.get(passage.passageId!)!;
  }
  
  void setToVisited(passage) {
    var _passage = box.get(passage.passageId!);
    _passage!.visited = true;
    _passage.save();
    notifyListeners();
  }

  void toggleCompleted(passage) {
    var _passage = box.get(passage.passageId!);
    _passage!.completed = !_passage.completed;
    _passage.save();
    notifyListeners();
  }

  void clearData() {
    box.deleteAll(box.keys);
    notifyListeners();
  }

  void resetData() {
    for (Passage p in box.values) {
      p.visited = false;
      p.completed = false;
      p.save();
    }
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