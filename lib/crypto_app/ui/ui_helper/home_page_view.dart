import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  final PageController controller;
  const HomePageView({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final images = [
    'assets/images/f_0.png',
    'assets/images/f_1.png',
    'assets/images/f_2.png',
    'assets/images/f_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: true,
      controller: widget.controller,
      children: [
        myPage(images[0]),
        myPage(images[1]),
        myPage(images[2]),
        myPage(images[3])
      ],
    );
  }

  Widget myPage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.fill,
      ),
    );
  }
}
