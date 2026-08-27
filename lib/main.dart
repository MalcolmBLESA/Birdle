import 'package:flutter/material.dart';
import 'views/game_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          centerTitle: true,
          title: Container(
            width: 210.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              border: Border.all(
                color: const Color.fromARGB(255, 51, 142, 6),
                width: 3,
              )
            ),
            alignment: Alignment.center,
            child: const Text(
              'Birdle',
              style: TextStyle(
                color: Color.fromARGB(255, 51, 142, 6),
                fontSize: 40,
              ),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: GamePage()),
        ),
      ),
    );
  }
}