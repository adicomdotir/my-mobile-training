import 'package:first_flutter/crypto_app/ui/ui_helper/home_page_view.dart';
import 'package:first_flutter/crypto_app/ui/ui_helper/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  int defaultChoiceIndex = 0;

  final choices = ['One', 'Two', 'Three'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        actions: [ThemeSwitcher()],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: Stack(
                      children: [
                        HomePageView(controller: _pageController),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 4,
                              effect: ExpandingDotsEffect(
                                  dotWidth: 10, dotHeight: 10),
                              onDotClicked: (index) =>
                                  _pageController.animateToPage(index,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Buy'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(20),
                          primary: Colors.green),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Sell'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(20),
                          primary: Colors.red),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Wrap(
                  spacing: 8,
                  children: List.generate(
                    choices.length,
                    (index) => ChoiceChip(
                      label: Text(
                        choices[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      selected: defaultChoiceIndex == index,
                      selectedColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          defaultChoiceIndex =
                              value ? index : defaultChoiceIndex;
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
