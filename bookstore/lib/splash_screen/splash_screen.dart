import 'package:bookstore/splash_screen/google_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Widget companyLogo() {
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.only(top: 60.0, right: 40.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.yellowAccent.shade100.withOpacity(0.25),
            spreadRadius: 6,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/splash_image/Ustore.jpeg'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        SizedBox(
          height: height,
          width: width,
          child: Image.asset(
            'assets/images/splash_image/lib.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: companyLogo(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: const <Widget>[
                GoogleLogin(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
