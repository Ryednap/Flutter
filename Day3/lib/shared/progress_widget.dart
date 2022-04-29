import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class _ProgressWidget extends StatefulWidget {
  _ProgressWidget({Key? key}) : super(key: key);
  @override
  State<_ProgressWidget> createState() => __ProgressWidgetState();

}

class __ProgressWidgetState extends State<_ProgressWidget> {
  int timer = 0;
  dynamic ?tickTock;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tickTock = Timer.periodic(const Duration(microseconds: 1), (time) {
      setState(() {
        print(timer);
        ++timer;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tickTock.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 15.w,
        width: 15.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFA1D3F8),
        ),
        child: SpinKitHourGlass(
          size: 15.w,
          duration: const Duration(milliseconds: 10000),
          color: Colors.black54,
        )
      )
    );
  }
}

Future<dynamic> showProgress({required BuildContext context, required AsyncValueGetter work}) async {
  showDialog(
    context: context,
    builder: (context) => _ProgressWidget(),
    barrierDismissible: false
  );

  dynamic value = await work();
  Navigator.pop(context);
  return value;
}
