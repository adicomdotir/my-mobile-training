import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  BlocOverrides.runZoned(
    () => runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'RobotoMono'),
      home: App(),
    )),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: CounterApp(),
    );
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Sample'),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: state.color == 2 ? Colors.redAccent : Colors.greenAccent,
                  borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.all(8),
              child: Text(
                'Counter: ' + state.counter.toString(),
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              context.read<CounterBloc>().add(Increment());
            },
          ),
          SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              context.read<CounterBloc>().add(Decrement());
            },
          ),
        ],
      ),
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(3);

  void increment() => emit(state + 1);
}

abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0, 0)) {
    on<Increment>((event, emit) => emit(CounterState(state.counter + 1, 1)));
    on<Decrement>((event, emit) => emit(CounterState(state.counter - 1, 2)));
  }
}

class CounterState {
  int counter = 0;
  int color = 0;

  CounterState(this.counter, this.color);
}

class CounterBlocTmp {
  int _cnt = 0;

  StreamController<int> _counterStateCtrl = StreamController<int>();
  StreamSink<int> get _counterStateSink => _counterStateCtrl.sink;
  Stream<int> get counter => _counterStateCtrl.stream;

  StreamController<CounterEvent> _counterEventCtrl = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get counterEventSink => _counterEventCtrl.sink;

  CounterBlocTmp() {
    _counterEventCtrl.stream.listen((event) {
      if (event is Increment) {
        _cnt += 1;
      } else if (event is Decrement) {
        _cnt -= 1;
      }

      _counterStateSink.add(_cnt);
    });
  }

  void dispose() {
    _counterStateCtrl.close();
    _counterEventCtrl.close();
  }
}

class CustomPracticeWidget extends StatefulWidget {
  const CustomPracticeWidget({ Key? key }) : super(key: key);

  @override
  _CustomPracticeWidgetState createState() => _CustomPracticeWidgetState();
}

class _CustomPracticeWidgetState extends State<CustomPracticeWidget> {
  CounterBlocTmp counterBlocTmp = CounterBlocTmp();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        initialData: 0,
        stream: counterBlocTmp.counter,
        builder: (ctx, AsyncSnapshot<int> snapshot) {
          return Text(snapshot.data.toString());
        },
      ),
    );
  }
}