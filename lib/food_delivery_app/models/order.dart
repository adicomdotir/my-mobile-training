
import 'package:first_flutter/food_delivery_app/models/food.dart';
import 'package:first_flutter/food_delivery_app/models/restaurant.dart';

class Order {
  final Restaurant restaurant;
  final Food food;
  final String date;
  final int quantity;

  Order({
    required this.date,
    required this.restaurant,
    required this.food,
    required this.quantity,
  });
}
