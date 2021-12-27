import 'dart:ui';

import 'package:first_flutter/plant_app/constants.dart';
import 'package:first_flutter/plant_app/screens/home/components/featured_plants.dart';
import 'package:first_flutter/plant_app/screens/home/components/header_with_searchbox.dart';
import 'package:first_flutter/plant_app/screens/home/components/recomend_plants.dart';
import 'package:first_flutter/plant_app/screens/home/components/title_with_more_btn.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderWithSearchBox(size: size),
          TitleWithMoreButton(
            title: 'Recomended',
            press: () {},
          ),
          RecomendsPlants(),
          TitleWithMoreButton(
            title: 'Featured Plants',
            press: () {},
          ),
          FeaturedPlants(),
          SizedBox(height: kDefaultPadding ,)
        ],
      ),
    );
  }
}
