import 'package:first_flutter/crypto_app/providers/crypto_data_provider.dart';
import 'package:first_flutter/crypto_app/providers/theme_provider.dart';
import 'package:first_flutter/crypto_app/ui/main_wrapper.dart';
import 'package:first_flutter/crypto_app/ui/ui_helper/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CryptoDataProvider(),
      ),
    ],
    child: MyMaterialApp(),
  ));
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: value.themeMode,
          debugShowCheckedModeBanner: false,
          home: Directionality(
              textDirection: TextDirection.ltr, child: MainWrapper()),
        );
      },
    );
  }
}
