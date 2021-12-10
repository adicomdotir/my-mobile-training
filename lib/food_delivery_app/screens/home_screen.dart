import 'package:first_flutter/food_delivery_app/data/data.dart';
import 'package:first_flutter/food_delivery_app/screens/restaurant_screen.dart';
import 'package:first_flutter/food_delivery_app/widgets/rating_stars.dart';
import 'package:first_flutter/food_delivery_app/widgets/recent_orders.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 30,
          onPressed: () {},
        ),
        title: Text('Food Delivery'),
        actions: [
          TextButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
              },
              child: Text(
                'Cart (${currentUser.cart.length})',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ))
        ],
      ),
      body: ListView(
        children: [
           Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0.8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        width: 0.8, color: Theme.of(context).primaryColor),
                  ),
                  hintText: 'Search Food or Restaurants',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nearby Restaurants',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2),
              ),
              _buildRestaurants()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRestaurants() {
    List<Widget> restaurantList = [];
    restaurants.forEach((element) {
      restaurantList.add(GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantScreen(restaurant: element,))),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Colors.grey)),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Hero(
                    tag: element.imageUrl,
                    child: Image(
                      image: AssetImage(element.imageUrl),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(element.name,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 4,
                    ),
                    RatingStars(rating: element.rating),
                    SizedBox(
                      height: 4,
                    ),
                    Text(element.address,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 4,
                    ),
                    Text('0.2 miles away',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    });
    return Column(
      children: restaurantList,
    );
  }
}
