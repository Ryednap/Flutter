import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      margin: const EdgeInsets.only(top: 80.0, right: 40.0),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          onPressed: () {},
          elevation: 10.0,
          child: SvgPicture.asset('assets/images/splash_image/google.svg'),
          color: Colors.white,
        ),
      ),
    );
  }
}
