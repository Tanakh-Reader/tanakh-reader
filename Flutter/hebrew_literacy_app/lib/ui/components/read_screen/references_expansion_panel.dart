import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/providers.dart';
import '../../../data/models/models.dart';
import '../../screens/read_screen.dart';

// Code inspired by https://github.com/31Carlton7/elisha/blob/master/lib/src/ui/views/bible_view/bible_view.dart

wordPanelSheet(context) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  elevation: 0,
  useRootNavigator: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
  ),
  builder: (context) {
    return FractionallySizedBox(
      // TODO CHANGE!
      heightFactor: 0.4,
      // widthFactor: Responsive.isTablet(context) ? 0.75 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Books',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          SizedBox(height: 7),
          
        ],
      ),
    );
  },
);

class ReferencesExpansionPanel extends ConsumerWidget {
  Widget? button;
  ReferencesExpansionPanel ({ Key? key, required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final hebrewPassage = ref.read(hebrewPassageProvider);

    return GestureDetector(
        onTap: () async {
          // HapticFeedback.lightImpact();
          // TODO - does this need to be here?
          if (hebrewPassage.hasSelection) {
            hebrewPassage.deselectWords();
          }
          await _showBookAndChapterBottomSheet(context, ref);
        },
        child: button
    );
      
  }

  Future<void> _showBookAndChapterBottomSheet(BuildContext context, WidgetRef ref) async {
      
      Widget _bookCard(Book book) {
        List chapters = List.generate(book.chapters!, (index) => index+1);
        Widget _chapterCard(int chapter) {
          return GestureDetector(
            // Removed await from before { below
            onTap: () async {
              // HapticFeedback.lightImpact();
              await ref.read(hebrewPassageProvider).getPassageWordsByRef(book.id!, chapter);
              // Navigator.of(context).pushNamed(ReadScreen.routeName);
              ref.read(tabManagerProvider).goToTab(Screens.read);
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.secondaryVariant, width: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  chapter.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          );
        }

        return ExpansionTile(
          childrenPadding: const EdgeInsets.symmetric(horizontal: 24),
          title: Text(book.name!, style: Theme.of(context).textTheme.headline6),
          iconColor: Theme.of(context).colorScheme.primary,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: book.chapters!,
                itemBuilder: (context, index) => _chapterCard(chapters[index]),
              ),
            ),
          ],
        );
      }

      return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
        ),
        builder: (context) {
          return FractionallySizedBox(
            // TODO CHANGE!
            heightFactor: 0.6,
            // widthFactor: Responsive.isTablet(context) ? 0.75 : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Books',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                Expanded(
                  child: ListView.separated(
                    itemCount: Books.books.length,
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Divider(),
                      );
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index == 0)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Divider(),
                            ),
                          _bookCard(Books.books[index]),
                          if (index == 0)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Divider(),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
}