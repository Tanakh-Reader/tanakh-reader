import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/viewmodels/reading_viewmodel.dart';

final readingViewModelProvider = StateNotifierProvider.autoDispose<ReadingViewModel>((ref) {
  final initialChapter = ref.watch(initialChapterProvider).state;
  return ReadingViewModel(ref, currentChapter: initialChapter);
});

final initialChapterProvider = StateProvider<int>((ref) => 1);
