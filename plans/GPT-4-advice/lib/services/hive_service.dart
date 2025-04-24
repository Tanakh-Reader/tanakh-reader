import 'package:hive/hive.dart';
import 'package:your_app/models/word.dart';

class HiveService {
  // Open a box to store Word objects
  Future<void> openWordsBox() async {
    await Hive.openBox<Word>('words');
  }

  // Save words to the box
  Future<void> saveWords(List<Word> words) async {
    final box = Hive.box<Word>('words');
    for (final word in words) {
      await box
