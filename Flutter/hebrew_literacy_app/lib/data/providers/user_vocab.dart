import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';

import '../models/models.dart';
import '../database/hb_db_helper.dart';

enum VocabStatus {
  unkown,
  learning,
  known
}

class UserVocab with ChangeNotifier {
  Map<int, int> _vocab = {};
  bool loaded = false;

  get vocab {
    return _vocab;
  }
  List<int> get knownVocab {
    return [..._vocab.keys.where((key) => _vocab[key] == VocabStatus.known.index).toList()];
  }

  List<int> get unknownVocab {
    return [..._vocab.keys.where((key) => _vocab[key] == VocabStatus.unkown.index).toList()];
  }

  bool isKnown (Lexeme lex) {
    return _vocab[lex.id!] == VocabStatus.known.index;
  }
  void setToKnown(Lexeme lex) {
    _vocab[lex.id!] = VocabStatus.known.index;
    notifyListeners();
  }

  void setToUnknown(Lexeme lex) {
    _vocab[lex.id!] = VocabStatus.unkown.index;
    notifyListeners();
  }

  void load() {
    loaded = true;
    notifyListeners();
  }


  Future<void> setUserVocab(int freqLex) async {
    List<Lexeme> allLexemes = await HebrewDatabaseHelper().getAllLexemes();
    for (var lex in allLexemes) {
      if (lex.freqLex! >= freqLex) {
        _vocab[lex.id!] = VocabStatus.known.index;
      } else {
        _vocab[lex.id!] = VocabStatus.unkown.index;
      }
    }
    // notifyListeners();
  }
}

final userVocabProvider = ChangeNotifierProvider<UserVocab>((ref) {
  return UserVocab();
});