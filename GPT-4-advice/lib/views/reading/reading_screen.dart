// views/reading/read_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/models/word.dart';
import 'package:your_app/providers/reading_viewmodel_provider.dart';



class ReadScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(readingViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Genesis 1'),
      ),
      body: viewModel.when(
        data: (List<Word> words) {
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return ListTile(
                title: Text(word.text),
                subtitle: Text(word.translation),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Decrement the chapter number (ensure it doesn't go below 1)
                ref.read(initialChapterProvider).state =
                    max(1, ref.read(initialChapterProvider).state - 1);
                viewModel.fetchWords(ref.read(initialChapterProvider).state);
              },
              child: const Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                // Increment the chapter number (ensure it doesn't exceed the total number of chapters)
                ref.read(initialChapterProvider).state =
                    min(ref.read(initialChapterProvider).state + 1, totalNumberOfChapters);
                viewModel.fetchWords(ref.read(initialChapterProvider).state);
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}