import 'package:first_flutter/flutter_app_testing/models/favorites.dart';
import 'package:first_flutter/flutter_app_testing/screens/favorites.dart';
import 'package:first_flutter/flutter_app_testing/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(TestingApp());
}

class TestingApp extends StatelessWidget {
  const TestingApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (ctx) => Favorites(),
      child: MaterialApp(
        title: 'Testing Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          FavoritesPage.routeName: (ctx) => FavoritesPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}