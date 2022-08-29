import 'package:first_flutter/crypto_app/ui/home_page.dart';
import 'package:first_flutter/crypto_app/ui/market_view_page.dart';
import 'package:first_flutter/crypto_app/ui/profile_page.dart';
import 'package:first_flutter/crypto_app/ui/ui_helper/bottom_nav.dart';
import 'package:first_flutter/crypto_app/ui/watch_list_page.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(controller: _pageController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchListPage()
        ],
      ),
    );
  }
}
