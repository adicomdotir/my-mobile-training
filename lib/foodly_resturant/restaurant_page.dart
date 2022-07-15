import 'package:first_flutter/foodly_resturant/components/menu_card.dart';
import 'package:first_flutter/foodly_resturant/components/restaruant_categories.dart';
import 'package:first_flutter/foodly_resturant/components/restaurant_info.dart';
import 'package:first_flutter/foodly_resturant/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './components/restaruant_categories.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/Header-image.png',
                fit: BoxFit.cover,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset('assets/icons/back.svg'),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  'assets/icons/share.svg',
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    'assets/icons/search_.svg',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: RestaurantInfo(),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: RestaurantCategories(
                  onChanged: (value) {}, selectedIndex: 0)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              List<Menu> items = demoCategoryMenus[index].items;
              return MenuCategoryItem(
                  title: demoCategoryMenus[index].category,
                  items: List.generate(
                      items.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: MenuCard(
                                image: items[index].image,
                                title: items[index].title,
                                price: items[index].price),
                          )));
            }, childCount: demoCategoryMenus.length)),
          ),
        ],
      ),
    );
  }
}
