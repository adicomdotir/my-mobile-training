import 'package:flutter/material.dart';

import '../../features/weather/presentation/screens/home_screen.dart';
import 'app_background.dart';
import 'bottom_nav.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({Key? key}) : super(key: key);

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      // const BookMarkScreen(),
    ];

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(controller: pageController),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AppBackground.getBackGroundImage(), fit: BoxFit.cover),
        ),
        height: height,
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
        ),
      ),
    );
  }
}
