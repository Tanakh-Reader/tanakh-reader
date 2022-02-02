import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'ui/screens/screens.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ReaderScreen(),
        ),
      ),
    );
  }
}