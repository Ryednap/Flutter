import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

abstract class TopCardView {

  static Widget _buildUserAvatar() {
    return NeumorphicButton(
        onPressed: (){},
        margin: EdgeInsets.all(3.h),
        padding: EdgeInsets.zero,
        style: const NeumorphicStyle(
          boxShape:  NeumorphicBoxShape.circle(),
          border: NeumorphicBorder(
            width: 2,
            color: Colors.blueGrey,
          ),
          shape: NeumorphicShape.flat,
          depth: 20,
          lightSource: LightSource.topLeft,
          color: Colors.grey,
          shadowDarkColor: Colors.black87,
        ),
        child: CircleAvatar(
          minRadius: 3.h,
          maxRadius: 3.h,
          backgroundImage: const AssetImage("assets/avatar.png.png"),
        )
    );
  }

  static List<Widget> _buildSalutation({required String name}) {
    return [
      Text(
        name,
        style: GoogleFonts.heebo(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            shadows: [
              cTextShadow(shadowColor: Colors.blueGrey.shade200)
            ]
        ),
      ),
      Text(
          "Good Morning",
          style: GoogleFonts.satisfy(
              fontSize: 16.sp,
              color: Colors.purple,
              shadows: [
                cTextShadow(shadowColor: Colors.purpleAccent.shade100)
              ]
          )
      )
    ];
  }

  static List<Widget> _buildMedicationProgress({required int numMedications, required int completed}) {
    return [
      SizedBox(
        width: 60.w,
        child: NeumorphicProgress(
          height: 2.h,
          percent: completed / (completed + numMedications),
          curve: Curves.bounceOut,
        ),
      ),
      SizedBox(width: 5.w),
      Text(
        "$completed/${numMedications + completed}",
        style: GoogleFonts.workSans(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue
        ),
      ),
      SizedBox(width: 1.w),
      Text(
          "meds",
          style: GoogleFonts.workSans(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          )
      )
    ];
  }

  static Widget buildTopCard({required BuildContext context, required int numMedications,
    required int completed, required String name}) {
    return Container(
      margin: EdgeInsets.only(top: 2.5.h),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(3.h)),
          depth: 20,
          lightSource: LightSource.topLeft,
          intensity: 0.8,
        ),
        child: Container(
          width: 92.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(3.h)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: _buildUserAvatar(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h, left: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildSalutation(name: name),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Text(
                          "Daily Medication Progress",
                          style: GoogleFonts.concertOne(
                              fontSize: 16.sp,
                              color: Colors.black54,
                              shadows: [
                                cTextShadow(shadowColor: Colors.grey.shade400),
                              ]
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildMedicationProgress(numMedications: numMedications, completed: completed)
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}