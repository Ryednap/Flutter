
import 'package:flutter/material.dart';
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