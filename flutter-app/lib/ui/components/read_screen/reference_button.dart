import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../data/providers/providers.dart';
import '../../../data/models/models.dart';
import '../../screens/read_screen.dart';
import 'settings/text_settings_panel.dart';

// Code inspired by https://github.com/31Carlton7/elisha/blob/master/lib/src/ui/views/bible_view/bible_view.dart

class ReferenceButton extends ConsumerWidget {
  const ReferenceButton ({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      
      final passage = ref.watch(hebrewPassageProvider);

      return Container(
        width: MediaQuery.of(context).size.width, //* 0.9,
        height: Theme.of(context).textTheme.headline3!.fontSize!,
        alignment: Alignment.center,  
        padding: const EdgeInsets.all(8.0),
        margin: EdgeInsets.only(top: 25.0),
        color: Colors.grey[800],
        // decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.all(Radius.circular(10)),
        //   color: Colors.grey[800],
        // ),
        // child: Flexible(
        //   fit: FlexFit.loose,
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.15),
              Container(
                // margin: EdgeInsets.only(),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.15,
                child: IconButton(
                  onPressed: (){},
                  icon: FaIcon(FontAwesomeIcons.angleLeft),
                  iconSize: 20,
                padding: EdgeInsets.zero,),
              ),
            
              Expanded(
                child: Text(
                  passage.book.name! + ' ' + passage.words[0].chBHS.toString(),
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.15,
                child: IconButton(
                  onPressed: (){},
                  icon: FaIcon(FontAwesomeIcons.angleRight),
                  iconSize: 20,
                padding: EdgeInsets.zero,),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.15,
                child: IconButton(
                onPressed: () async => await textSettingsPanelSheet(context),
                icon: FaIcon(FontAwesomeIcons.font),
                iconSize: 16,
                padding: EdgeInsets.zero,
              ))
            
            ],
          ),
        // ),
      );
    }
  }