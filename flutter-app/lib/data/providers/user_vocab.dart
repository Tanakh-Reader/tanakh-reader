import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanakhreader/data/constants.dart';
import 'package:tanakhreader/data/providers/providers.dart';
import 'package:hive/hive.dart';

import '../models/models.dart';
import '../database/hebrew_bible_data/hb_db_helper.dart';

import '../database/user_data/vocab.dart';

import '../database/user_data/user.dart';

// 
Map<ReadingLevel, int> LEX_MAP = {
  ReadingLevel.beginner: 200, // 249 lexemes
  ReadingLevel.elementary: 100, // 433 lexemes
  ReadingLevel.intermediate: 70, // 579 lexemes
  ReadingLevel.advanced: 50, // 740 lexemes
  ReadingLevel.expert: 30 // 1162 lexemes
};

/// Used for adding words to the dictinary. 
class TextItem {
  int id;
  String text;

  TextItem({
    required this.id,
    required this.text
  });
}

/// A provider for the Hive [Vocab] database. 
/// This allows the app to dynamically track user vocabulary
/// and to rebuild specified widgets when vocab data updates. 
class UserVocab with ChangeNotifier {
  static final _boxName = 'vocab';
  var vocabBox = Hive.box<Vocab>(_boxName);
  bool loaded = false;

  
  /// Return true if the [Vocab] database is initialized.
  get isInitialized {
    return vocabBox.isNotEmpty;
  }

  /// TODO : fix documentation
  /// Takes a [lexical frequency] specified by the [UserBox] database
  /// after the user creates their profile. and populates the [Vocab] database
  /// with all lexemes, setting lexemes with lex.freqLex >= [freqLex] to
  /// known. 
  Future<void> initializeVocab() async {
    var user = Hive.box<User>('user').values.first;
    int freqLex = LEX_MAP[user.readingLevel]!;
    // Make sure the data isn't already initialized. 
    if (vocabBox.isEmpty) {
      // Loop overall all lexemes and store their ids as keys
      // mapped to [Vocab] instances in the database. 
      for (var lex in AllLexemes.lexemes) {
        // Set _status to known if the lexemes frequency is known by the user.
        var _status = lex.freqLex! >= freqLex
          ? VocabStatus.known
          : VocabStatus.unkown;
        // Create a [Vocab] instance and store it in the database. 
        var vocab = Vocab(
          lexId: lex.id!,
          status: _status,
        );
        vocabBox.put(lex.id!, vocab);
      }
    }
    // Otherwise, reinitialized
    reinitializeVocab();
  }

  /// Function for user to reset the default known vocab.
  /// Same as [initializeVocab], but updates values rather than creating them. 
  void reinitializeVocab() {
    var user = Hive.box<User>('user').values.first;
    int freqLex = LEX_MAP[user.readingLevel]!;
    if (vocabBox.isNotEmpty) {
      for (var lex in AllLexemes.lexemes) {
        var _vocab = vocabBox.get(lex.id);
        // Only update words that the user hasn't toggled.
        if (!(_vocab!.userUpdated == true)) {
          var _status = lex.freqLex! >= freqLex
            ? VocabStatus.known
            : _vocab.status;
          _vocab.status = _status;
          _vocab.save();
        }
      }
    } else {
      print('Vocab not initialized');
    }
  }
  
  /// Return a [Lexeme] instance given a [lexId]. 
  Lexeme lex(int lexId) {
    return AllLexemes.lexemes.firstWhere((lex) => lex.id == lexId);
  }

  /// Get a list of all lex ids where the status is set to known.
  List<int> get knownVocab {
    var allVocab = vocabBox.values;
    List<int> _knownVocab = [];
    // Loop over all stored [Vocab] instances and find known lexemes. 
    for (Vocab v in allVocab) {
      if (v.status == VocabStatus.known) {
        _knownVocab.add(v.lexId);
      }
    }
    return _knownVocab;
  }

  /// Get a list of all lex ids where [saved] is set to true.
  List<int> get savedVocab {
    var allVocab = vocabBox.values;
    List<int> _savedVocab = [];
    // Loop over all stored [Vocab] instances and find saved lexemes.
    for (Vocab v in allVocab) {
      if (v.saved) {
        _savedVocab.add(v.lexId);
      }
    }
    return _savedVocab;
  }

  List<int> wordInstanceIds(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    return _vocab!.wordInstanceIds;
  }

  List<String> definitions(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    return _vocab!.definitions;
  }

  DateTime dateSaved(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    return _vocab!.dateSaved!;
  }

  /// Given a set of lexeme Ids, return lexeme objects.
  List<Lexeme> lexemesByIds(List<int> lexIds) {
    final _lexIds = lexIds.toSet();
    return AllLexemes.lexemes.where((lex) => _lexIds.contains(lex.id)).toList();
  }

  /// Take a [Lexeme] instance and return [true] if its 
  /// stored [status] attribute is set to known.
  bool isKnown (Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    return _vocab!.status == VocabStatus.known;
  }

  /// Take a [Lexeme] instance and return [true] if its 
  /// stored [saved] attribute is set to true.
  bool isSaved (Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    return _vocab!.saved;
  }

  /// Take a [Lexeme] instance and return [true] if its 
  /// stored [exported] attribute is set to true.
  bool isExported (Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    return _vocab!.exported;
  }

  /// Toggle a [Lexeme]'s [saved] attribute in the database and save it. 
  void toggleSaved(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    // If toggling to true, then update dateSaved
    if (_vocab!.saved == false) {
      _vocab.dateSaved = DateTime.now();
    }
    _vocab.saved = !_vocab.saved;
    _vocab.save();
    notifyListeners();
  }

  /// Set a [Lexeme]'s [status] attribute to known in the database and save it. 
  void setToKnown(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.userUpdated = true;
    _vocab.status = VocabStatus.known;
    _vocab.save();
    notifyListeners();
  }

  /// Set a [Lexeme]'s [status] attribute to unknown in the database and save it. 
  void setToUnknown(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.userUpdated = true;
    _vocab.status = VocabStatus.unkown;
    _vocab.save();
    notifyListeners();
  }

  /// Toggle between unknown and known. 
  void toggleKnown(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.userUpdated = true;
    isKnown(lex) 
    ? _vocab.status = VocabStatus.unkown
    : _vocab.status = VocabStatus.known;
    _vocab.save();
    notifyListeners();
  }

  void setToExported(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.exported = true;
  }

  void updateLexTap(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.tapCount += 1;
    _vocab.latestTap = DateTime.now();
    _vocab.save();
  }

  void updateGlossTap(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.glossTapCount += 1;
    _vocab.save();
  }

  Future<void> addDefinitions(Lexeme lex, List<String> definitions) async {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.definitions += definitions;
    _vocab.save();
  }

  List<String> getDefinitions(Lexeme lex) {
    var _vocab = vocabBox.get(lex.id!);
    return _vocab!.definitions;
  }

  void addWordInstanceIds(Lexeme lex, List<int> wordInstanceIds) {
    var _vocab = vocabBox.get(lex.id!);
    _vocab!.wordInstanceIds += wordInstanceIds;
    _vocab.save();
  }

  // TODO: why is this still here?
  void load() {
    loaded = true;
    notifyListeners();
  }

  void clearData() {
    vocabBox.deleteAll(vocabBox.keys);
    notifyListeners();
  }


}

final userVocabProvider = ChangeNotifierProvider<UserVocab>((ref) {
  return UserVocab();
});