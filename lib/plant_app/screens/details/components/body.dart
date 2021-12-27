import 'package:first_flutter/plant_app/constants.dart';
import 'package:first_flutter/plant_app/screens/details/components/icon_card.dart';
import 'package:first_flutter/plant_app/screens/details/components/image_and_icons.dart';
import 'package:first_flutter/plant_app/screens/details/components/title_and_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          ImageAndIcons(size: size),
          TitleAndPrice(
            title: 'Angelica',
            country: 'Russia',
            price: 440,
          ),
          SizedBox(height: kDefaultPadding,),
          Row(
            children: [
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20)
                    )
                  ),
                  onPressed: () {}, child: Text('Buy Now', style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),), color: kPrimaryColor,),
              ),
              Expanded(child: FlatButton(onPressed: () {}, child: Text('Description')))
            ],
          ),
          SizedBox(height: kDefaultPadding * 2,)
        ],
      ),
    );
  }
}
