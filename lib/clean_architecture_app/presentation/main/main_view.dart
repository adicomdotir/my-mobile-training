import 'package:first_flutter/clean_architecture_app/presentation/main/home/home_page.dart';
import 'package:first_flutter/clean_architecture_app/presentation/main/notificatoins_page.dart';
import 'package:first_flutter/clean_architecture_app/presentation/main/search_page.dart';
import 'package:first_flutter/clean_architecture_app/presentation/main/settings_page.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/color_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/strings_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];
  List<String> _titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];
  var _title = 'Home';
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1_5)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: (index) {
            _currentIndex = index;
            _title = _titles[index];
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppStrings.notifications),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppStrings.settings),
          ],
        ),
      ),
    );
  }
}
