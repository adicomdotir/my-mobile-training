import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/widgets/main_wrapper.dart';
import 'features/weather/presentation/bloc/home_bloc.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///  init locator
  await setup();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiBlocProvider(providers: [
      BlocProvider(create: (_) => locator<HomeBloc>()),
    ], child: MainWrapper()),
  ));
}
