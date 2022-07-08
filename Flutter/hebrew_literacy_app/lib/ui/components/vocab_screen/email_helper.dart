import 'dart:convert';

import 'package:hebrew_literacy_app/data/providers/providers.dart';
import 'package:hebrew_literacy_app/data/providers/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';


import '../../../data/models/models.dart';

final String WORD = "word";
final String DEFINITION = "definition";

void exportVocab(ref) async {
  
  final UserVocab userVocab = ref.read(userVocabProvider);
  final UserData user = ref.read(userDataProvider);

  final List<Lexeme> savedVocab = userVocab.lexemesByIds(userVocab.savedVocab);
  List<Lexeme> newExports = savedVocab.where(
    (lex) => !userVocab.isExported(lex)).toList();

  if (newExports.isEmpty) {
    return null;
  }

  // final String directory = (await getApplicationSupportDirectory()).path;
  // final path = "$directory/vocabExport.csv";
  // final File file = File(path);
  // List<List<dynamic>> rows = [];

  // rows.add([WORD, DEFINITION]);
  // for (Lexeme vocab in savedVocab) {
  //   rows.add([vocab.text, vocab.gloss]);
  // }
  // String csv = const ListToCsvConverter().convert(rows);
  // await file.writeAsString(csv);

  String vocabString = "";
  for (Lexeme vocab in newExports.sublist(0, newExports.length-1)) {
    var defs = userVocab.getDefinitions(vocab);
    var defText = '';
    if (defs.isNotEmpty) {
      for (var def in defs) {
        defText += def + ';';
      }
    }
    if (defText == '') {
      defText += vocab.gloss!;
    }
    vocabString += vocab.text! + '`' + defText + '|';
  }
  var defs = userVocab.getDefinitions(newExports.last);
    var defText = '';
    if (defs.isNotEmpty) {
      for (var def in defs) {
        defText += def + ';';
      }
    }
    if (defText == '') {
      defText += newExports.last.gloss!;
    }
  vocabString += newExports.last.text! + '`' + defText;

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final serviceId = "service_vt2l92h";
  final templateId = "template_6rl1i5g";
  final userId = "_rR_8RKjteeeJB-Qb";
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json'
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      // 'user_id':
      'template_params': {
        'user_name': user.name,
        'user_email': user.email,
        'vocab': vocabString,
        // 'file': [
        //   {'path': file.path, 'type': 'application/csv', 'name': 'vocab.csv'}
        // ]
      }
    }),
  );

  // Update that the newly exported vocab were exported. 
  if (response.body == 'OK') {
    for (Lexeme lex in newExports) {
      userVocab.setToExported(lex);
    }
  }
  print(response.body);


}