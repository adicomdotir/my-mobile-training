import 'package:first_flutter/advanced_course/features/weather/data/models/forecast_days_model.dart';
import 'package:flutter/material.dart';

import '../utils/date_converter.dart';
import 'app_background.dart';

class DaysWeatherView extends StatefulWidget {
  Daily daily;
  DaysWeatherView({Key? key, required this.daily}) : super(key: key);

  @override
  State<DaysWeatherView> createState() => _DaysWeatherViewState();
}

class _DaysWeatherViewState extends State<DaysWeatherView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1, curve: Curves.decelerate)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform:
              Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Column(
                    children: [
                      Text(
                          DateConverter.changeDtToDateTime(widget.daily.dt)
                              .toString(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                      Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: AppBackground.setIconForMain(
                              widget.daily.weather![0].description!)),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text("${widget.daily.temp!.day!.round()}\u00B0",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white)),
                      )),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    // _fwBloc.dispose();
    // _cwBloc.dispose();
    super.dispose();
  }
}