import 'package:first_flutter/bloc_example/bloc_timer/bloc/timer_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimerEvent', () {

    group('TimerStarted', () {
      test('supports value comparision', () {
        expect(TimerStarted(duration: 60), TimerStarted(duration: 60));
      });
    });

    group('TimerPaused', () {
      test('supports value comparision', () {
        expect(TimerPaused(), TimerPaused());
      });
    });


    group('TimerResumed', () {
      test('supports value comparision', () {
        expect(TimerResumed(), TimerResumed());
      });
    });

    group('TimerReset', () {
      test('supports value comparison', () {
        expect(TimerReset(), TimerReset());
      });
    });

    group('TimerTicked', () {
      test('supports value comparision', () {
        expect(TimerTicked(duration: 60), TimerTicked(duration: 60));
      });
    });

  });
}