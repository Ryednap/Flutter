
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

final cBoxShadowStyle = <BoxShadow>[
  BoxShadow(
    color: Colors.white70,
    spreadRadius: .2.h,
    blurRadius: .7.h,
    offset: Offset(.1.h, -.3.h),
    blurStyle: BlurStyle.normal,
  ),
  BoxShadow(
    color: Colors.black12,
    spreadRadius: .1.h,
    blurRadius: .8.h,
    offset: Offset(.8.h, .8.h),
    blurStyle: BlurStyle.normal,
  )
];

final cTextShadowStyle = [
  BoxShadow(
    color: Colors.white54,
    spreadRadius: .05.h,
    blurRadius: .15.h,
    offset: Offset(-.1.h, .1.h),
  )
];

Widget drawLogoShape() {
  return Stack(
    children: [
      DottedBorder(
        color: Colors.black38,
        strokeWidth: .3.h,
        borderType: BorderType.Circle,
        dashPattern: [.6.h, .6.h],
        child: Container(
          height: 8.h,
          width: 8.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
        ),
      ),

      Container(
        margin: EdgeInsets.only(top: .85.h, left: 1.85.w),
        height: 6.7.h,
        width: 6.7.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: Colors.black87, width: .35.h)
        ),
      )
    ],
  );
}


Widget buildSocialLoginButton({
  required VoidCallback onPressed,
  required IconData iconData,
  required BuildContext context
}) {

  return Container(
      height: 6.h,
      width: 6.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(1.5.h),
        boxShadow: cBoxShadowStyle,
      ),
      child: MaterialButton(
        onPressed: (){},
        splashColor: Colors.white54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.5.h)),
        child: FaIcon(iconData, color: Colors.black, size: 3.h),
      )
  );
}

