import 'package:cleanarchitecureflutter/injector.dart';
import 'package:flutter/material.dart';
import 'features/number_trivia/presentation/views/number_trivia_page.dart';
import 'injector.dart' as di;

void main(List<String> args) async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Trivia',
      home: NumberTriviaPage(),
    );
  }
}
