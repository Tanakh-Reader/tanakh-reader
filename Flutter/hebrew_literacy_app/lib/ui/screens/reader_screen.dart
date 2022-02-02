import 'package:flutter/material.dart';

import '../widgets/reader_screen/reader_screen.dart';


class ReaderScreen extends StatelessWidget {
  const ReaderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PassageDisplay();
  }
}