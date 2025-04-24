import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/models/word.dart';
import 'package:your_app/providers/word_provider.dart';

class ReadingViewModel extends StateNotifier<AsyncValue<List<Word>>> {
  final ProviderRefBase _ref;
  int currentChapter;

  ReadingViewModel(this._ref, {this.currentChapter = 1}) : super(const AsyncValue.loading()) {
    fetchWords(currentChapter);
  }


  ReadingViewModel(this._ref) : super(const AsyncValue.loading()) {
    // Fetch words for Genesis 1 by default
    fetchWords(1);
  }

  // Fetch words for a specific chapter
  Future<void> fetchWords(int chapter) async {
    try {
      final words = await _ref.read(wordsProvider(chapter).future);
      state = AsyncValue.data(words);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Additional methods for managing user preferences or other reading-related logic can be added here
}
