import 'package:first_flutter/bloc_example/bloc_timer/ticker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Ticker', () {
    const ticker = Ticker();
    test('ticker emits 3 ticks from 2-0 every second', () {
      expectLater(ticker.tick(ticks: 3), emitsInAnyOrder(<int>[0, 1, 2]));
    });
  });
}