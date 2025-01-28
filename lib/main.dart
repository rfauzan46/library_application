import 'package:flutter/material.dart';
import 'package:library_application/constants/color_constant.dart';
import 'package:library_application/screens/home_screen.dart';
import 'package:library_application/screens/selected_book_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: kMainColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: HomeScreen(),
      routes: {
        '/homeScreen':(_)=>HomeScreen(),
      },
    );
  }
}
