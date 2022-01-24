import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/test_app/counter_app.dart';

void main() {
  testWidgets('counter app ...', (tester) async {
    await tester.pumpWidget(CounterApp());

    expect(find.text('0'), findsOneWidget);

    var icon = find.byType(Icon);
    await tester.press(icon);
    await tester.pump(Duration(seconds: 1));

    expect(find.text('1'), findsOneWidget);
  });
}
