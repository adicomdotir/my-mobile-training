import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent {}

class LoadCwEvent extends HomeEvent {
  final String cityName;
  LoadCwEvent(this.cityName);
}
