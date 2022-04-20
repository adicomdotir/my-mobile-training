import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:first_flutter/bloc_example/bloc_timer/bloc/timer_bloc.dart';
import 'package:first_flutter/bloc_example/bloc_timer/timer/view/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

extension on WidgetTester {
  Future<void> pumpTimerView(TimerBloc timerBloc) {
    return pumpWidget(MaterialApp(
      home: BlocProvider.value(
        value: timerBloc,
        child: TimerView(),
      ),
    ));
  }
}

void main() {
  late TimerBloc timerBloc;

  setUp(() {
    timerBloc = MockTimerBloc();
  });

  tearDown(() => reset(timerBloc));

  group('TimerPage', () {
    testWidgets('renders TimerView', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TimerPage(),
      ));
      expect(find.byType(TimerView), findsOneWidget);
    });
  });

  group('TimerView', () {
    testWidgets('renders initial Timer view', (tester) async {
      when(() => timerBloc.state).thenReturn(() => TimerInitial(60));
      await tester.pumpTimerView((timerBloc));
      expect(find.text('01:00'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('renders pause and reset button when timer is in progress', (tester) async {
      when(() => timerBloc.state).thenReturn(() => TimerRunInProgress(59));
      await tester.pumpTimerView(timerBloc);
      expect(find.text('00:59'), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.replay), findsOneWidget);
    });


    
  });
}
