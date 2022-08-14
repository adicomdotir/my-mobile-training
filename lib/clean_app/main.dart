import 'package:first_flutter/clean_app/presentation/bloc/weather_bloc.dart';
import 'package:first_flutter/clean_app/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

void main(List<String> args) {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => di.locator<WeatherBloc>(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter App',
        home: WeatherPage(),
      ),
    );
  }
}