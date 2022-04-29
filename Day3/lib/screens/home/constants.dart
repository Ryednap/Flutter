
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

BoxShadow cTextShadow ({required Color shadowColor}) {
  return BoxShadow(
    color: shadowColor,
    spreadRadius: 0.05.h,
    blurRadius: 0.3.h,
    offset: Offset(0.2.h, 0.3.h),
  );
}

