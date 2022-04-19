import 'package:first_flutter/bloc_example/bloc_timer/bloc/timer_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimerState', () {
    group('TimerInitial', () {
      test('supports value comparison', () {
        expect(TimerInitial(60), TimerInitial(60));
      });
    });

    group('TimerRunPause', () {
      test('supports value comparison', () {
        expect(TimerRunPause(60), TimerRunPause(60));
      });
    });

    group('TimerRunInProgress', () {
      test('supports value comparison', () {
        expect(
          const TimerRunInProgress(60),
          const TimerRunInProgress(60),
        );
      });
    });
    group('TimerRunComplete', () {
      test('supports value comparison', () {
        expect(
          const TimerRunComplete(),
          const TimerRunComplete(),
        );
      });
    });

  });
}