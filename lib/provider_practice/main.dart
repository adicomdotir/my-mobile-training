import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyHomeWidget());
}

class Foo extends ChangeNotifier {
  String value = 'Foo';
  void changeValue() {
    value = value == 'Foo' ? 'Bar' : 'Foo';
    notifyListeners();
  }
}

class MyHomeWidget extends StatelessWidget {
  const MyHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Provider 09'),
        ),
        body: ChangeNotifierProvider<Foo>(
          create: (context) => Foo(),
          child: Consumer<Foo>(
            builder: (context, value, child) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${context.watch<Foo>().value}',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      onPressed: () {
                        context.read<Foo>().changeValue();
                      },
                      child: Text(
                        'Change Value',
                        style: TextStyle(fontSize: 20.0),
                      ))
                ],
              ));
            },
          ),
        ),
      ),
    );
  }
}
