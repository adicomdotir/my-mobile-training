import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(CustomApp());
}

class CustomApp extends StatelessWidget {
  const CustomApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomPaint(
          painter: MyCustomPainter(),
          child: Center(child: Text('Support'),),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.orangeAccent, Colors.yellow],
      tileMode: TileMode.clamp,
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height - size.height / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }
}