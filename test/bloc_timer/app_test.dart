import 'dart:math';

import 'package:first_flutter/bloc_example/bloc_timer/main.dart';
import 'package:first_flutter/bloc_example/bloc_timer/timer/view/timer_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders TimerPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(TimerPage), findsOneWidget);
    });
  });
}