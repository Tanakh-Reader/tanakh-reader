import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import '../../data/providers/providers.dart';
import '../../data/models/models.dart';

class VocabScreen extends ConsumerWidget {
  VocabScreen ({ Key? key }) : super(key: key);

  static const routeName = '/vocab';
  
  Future<List<Lexeme>> _allLexemes = HebrewDatabaseHelper().getAllLexemes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Column(
      children: [
        TextButton(
          child: Text("Home"),
          onPressed: () {
            // _hebrewPassageFuture.getPassageWordsByRef(1, 2);
            // Navigator.of(context).pushNamed(HomeScreen.routeName);
            ref.read(tabManagerProvider).goToTab(Screens.home.index);
          },
        ),
        FutureBuilder(
          future: _allLexemes,
          builder: (ctx, snapshot) {
            List<Lexeme> _lexemes = snapshot.data as List<Lexeme>;
            return snapshot.connectionState == ConnectionState.waiting 
            ? const Center(
              child: CircularProgressIndicator()
            )
            : 
            // SizedBox(
            //   height: 500,
            //   child: 
              Expanded(
                child: ListView.builder(
                  itemCount: _lexemes.length,
                  itemBuilder: (ctx, int index) {
                    return Container(
                      child: Text(_lexemes[index].text!)
                    );
                  }
                ),
              // ),
            );
          }
        )
      ]
    );
  }
}