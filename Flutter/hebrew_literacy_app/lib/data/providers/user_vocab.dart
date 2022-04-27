import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hebrew_literacy_app/data/constants.dart';
import 'package:hebrew_literacy_app/data/providers/providers.dart';

import '../models/models.dart';
import '../database/hb_db_helper.dart';

enum VocabStatus {
  unkown,
  learning,
  known,
}

class Vocab {
  int lexId;
  int status;
  bool saved;

  Vocab(
    this.lexId,
    this.status,
    this.saved
  );
}

class UserVocab with ChangeNotifier {
  Map<int, Map<String,dynamic>> _vocab = {};
  bool loaded = false;
  String saved = "saved";
  String status = "status";

  Lexeme lex(int lexId) {
    return AllLexemes.lexemes.firstWhere((lex) => lex.id == lexId);
  }
  
  get vocab {
    return _vocab;
  }
  List<int> get knownVocab {
    return [..._vocab.keys.where((key) => _vocab[key]![status] == VocabStatus.known.index).toList()];
  }

  List<int> get unknownVocab {
    return [..._vocab.keys.where((key) => _vocab[key]![status] == VocabStatus.unkown.index).toList()];
  }

  List<int> get savedVocab {
     return [..._vocab.keys.where((key) => _vocab[key]![saved]).toList()];
  }

  bool isKnown (Lexeme lex) {
    return _vocab[lex.id!]![status] == VocabStatus.known.index;
  }

  bool isSaved (Lexeme lex) {
    return _vocab[lex.id!]![saved];
  }

  void toggleSaved(int lexId) {
    _vocab[lexId]![saved] = !_vocab[lexId]![saved];
    notifyListeners();
  }

  void setToKnown(Lexeme lex) {
    _vocab[lex.id!]![status] = VocabStatus.known.index;
    notifyListeners();
  }

  void setToUnknown(Lexeme lex) {
    _vocab[lex.id!]![status] = VocabStatus.unkown.index;
    notifyListeners();
  }

  void load() {
    loaded = true;
    notifyListeners();
  }



  Future<void> setUserVocab(int freqLex) async {
    for (var lex in AllLexemes.lexemes) {
      _vocab[lex.id!] = {status:VocabStatus.unkown.index, saved:false};
      if (lex.freqLex! >= freqLex) {
        _vocab[lex.id!]![status] = VocabStatus.known.index;
      }
    }
    // notifyListeners();
  }

}

final userVocabProvider = ChangeNotifierProvider<UserVocab>((ref) {
  return UserVocab();
});