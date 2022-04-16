import 'package:first_flutter/bloc_example/bloc_counter/counter/counter.dart';
import 'package:first_flutter/bloc_example/bloc_counter/counter/view/counter_view.dart';
import 'package:first_flutter/test_app/counter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CounterPage(),
      ));
      expect(find.byType(CounterView), findsOneWidget);
    });
  });
}
