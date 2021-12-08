import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  int rating;
  RatingStars({ required this.rating });

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (var i = 0; i < this.rating; i++) {
      stars += '⭐';
    }
    return Text(stars);
  }
}