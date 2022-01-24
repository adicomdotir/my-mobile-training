import 'package:first_flutter/test_app/counter_app.dart' as app;
import 'package:first_flutter/test_app/counter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
      await tester.pumpWidget(CounterApp());

      var btn = find.widgetWithText(ElevatedButton, 'Click');
      var finder = find.byIcon(Icons.add);
      // await tester.press(btn);
      await tester.pump(Duration(seconds: 1));

      // Ignore this line for now
      // It just verifies that the value is what we expect it to be
      expect(find.text('0'), findsOneWidget);
    });
  });
}
