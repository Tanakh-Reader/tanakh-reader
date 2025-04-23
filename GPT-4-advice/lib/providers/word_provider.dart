import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/models/word.dart';

final wordProvider = Provider.autoDispose.family<List<Word>, int>((ref, chapter) {
  return ref.watch(_words(chapter));
});

final _words = FutureProvider.autoDispose.family<List<Word>, int>((ref, chapter) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('words')
      .where('chapter', isEqualTo: chapter)
      .get();

  return querySnapshot.docs.map((doc) => Word.fromJson(doc.data())).toList();
});
