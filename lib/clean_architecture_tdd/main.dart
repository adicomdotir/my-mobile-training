import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green.shade600)
      ),
      home: NumberTriviaPage(),
    );
  }
}
