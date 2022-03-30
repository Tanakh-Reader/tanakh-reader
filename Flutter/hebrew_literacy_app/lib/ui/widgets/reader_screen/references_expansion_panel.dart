import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/hebrew_passage.dart';
import '../../../data/models/models.dart';

class ReferencesExpansionPanel extends StatelessWidget {
  const ReferencesExpansionPanel ({ Key? key }) : super(key: key);

//   @override
//   _ReferencesExpansionPanelState createState() => _ReferencesExpansionPanelState();
// }

// class _ReferencesExpansionPanelState extends State<ReferencesExpansionPanel> {

  @override
  Widget build(BuildContext context) {
    final passage = Provider.of<HebrewPassage>(context, listen: true);
    // print(Books.books.first.values);
    return GestureDetector(
      onTap: () async {
        // HapticFeedback.lightImpact();

        await _showBookAndChapterBottomSheet(context);
      },
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.expand(
          height: Theme.of(context).textTheme.headline4!.fontSize!
        ),

        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
          // color: Theme.of(context).inputDecorationTheme.fillColor,
          color: Colors.blueAccent
        ),
        child: Text(
          passage.book.name!,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
      
  }

  Future<void> _showBookAndChapterBottomSheet(BuildContext context) async {
      
      Widget _bookCard(Book book) {
        List chapters = List.generate(book.chapters!, (index) => index);
        Widget _chapterCard(int chapter) {
          return GestureDetector(
            onTap: () async {
              // HapticFeedback.lightImpact();
              // await ref.read(bibleRepositoryProvider).changeChapter(ref, book.id!, chapter.id!);
              // Navigator.of(context, rootNavigator: true).pop();
              Provider.of<HebrewPassage>(context, listen: false).getPassageWordsByRef(book.id!, chapter);
              print(Provider.of<HebrewPassage>(context, listen: false).book.name);
              // print(passage.)
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.secondaryVariant, width: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  chapter.toString(),
                  style: Theme.of(context).textTheme.headline6,
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
            heightFactor: 0.95,
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