import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        SizedBox(
          height : height,
          width : width,
          child : Image.asset('assets/images/splash_image/lib.jpg', fit : BoxFit.cover),
        ),
        Container (
          height : 100,
          width : 100,
          margin: const EdgeInsets.only(top : 30.0, right : 50),
          child : Image.asset('assets/images/splash_image/Ustore.jpeg'),
        ),
        Container (
          child : InkWell(
            child : 
          )
        )
      ],
    );
  }
}
