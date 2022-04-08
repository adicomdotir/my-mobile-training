import 'package:first_flutter/mvvm_practice/screens/movies_screen.dart';
import 'package:first_flutter/mvvm_practice/viewModel/movies_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Movies MVVM Example",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: ChangeNotifierProvider(
          create: (context) => MovieListViewModel(),
          child: MovieListScreen(),
        ));
  }
}
