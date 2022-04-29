
import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ui/screens/home/constants.dart';
import 'package:home_ui/service/medicine_service.dart';
import 'package:home_ui/service/service_settings.dart';
import 'package:sizer/sizer.dart';
import 'package:logger/logger.dart';

import '../service/alarm_service.dart';
import '../shared/util.dart';

class MedicineCard extends StatefulWidget {
  final bool editMode;
  final int id;
  final int status;
  final String name;
  final String type;
  final double dosage;
  final String upcomingTime;
  final String description;
  final VoidCallback updateUiCallback;

  const MedicineCard({Key? key, required this.editMode, required this.id, required this.status, required this.name,
    required this.upcomingTime, required this.description, required this.updateUiCallback, required this.dosage, required this.type}) : super(key: key);

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  late bool editMode;
  late int id;
  late int status;
  late String name;
  late String upcomingTime;
  late String description;
  late Timer timer;
  final logger = Logger();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editMode = widget.editMode;
    id = widget.id;
    name = widget.name;
    upcomingTime = widget.upcomingTime;
    description = widget.description;
    status = widget.status;

    if (status == 0) return;
    TimeOfDay realTime = Util.parseStringToTimeOfDay(upcomingTime);
    DateTime now = DateTime.now();
    timer = AlarmService.setAlarm(
        work: () async {
           await MedicineService.postRingTime(name: name, dosage: "2", description: description, type: widget.type);
            await MedicineService.updateMedicineStatus(id: id, status: 0);
            setState(() {

            });
            },
        when: Duration(seconds: (realTime.hour - now.hour) * 60 * 60 + (realTime.minute - now.minute) * 60),
        id: realTime.hour * 60 * 60 + realTime.minute * 60
    );
  }

  @override
  Widget build(BuildContext context) {
    ServiceSettings.logger.d('Building model $editMode');

    editMode = widget.editMode;
    id = widget.id;
    name = widget.name;
    upcomingTime = widget.upcomingTime;
    description = widget.description;

    return Padding(
      padding: EdgeInsets.only(bottom: 2.5.h),
      child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(2.h)),
            shape: NeumorphicShape.flat,
            color: const Color(0xB0DCDDDC),
            depth: 1.8.h,
          ),
          child: Container(
              height: 19.h,
              width: 81.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.h),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 4.w,top: 1.h, right: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        NeumorphicIcon(
                          FontAwesomeIcons.pills,
                          size: 3.h,
                          style: const NeumorphicStyle(
                              color: Colors.amber
                          ),
                        ),
                        const Spacer(),

                        editMode ? NeumorphicButton(
                          onPressed: (){},
                          drawSurfaceAboveChild: true,
                          style: const NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            shape: NeumorphicShape.flat,

                          ),
                          child: FaIcon(
                            FontAwesomeIcons.edit,
                            size: 2.h,
                            color: Colors.blue,
                          ),
                        ) : const SizedBox(width: 0),
                        NeumorphicButton(
                          onPressed: () async {
                            bool result;
                            if (editMode) {
                               result = await MedicineService.deleteMedicine(id: id);
                            } else {
                              result = await MedicineService.updateMedicineStatus(id: id, status: 0);
                            }
                            ServiceSettings.logger.d('Update status $result');
                            if (result) {
                              setState(() {
                                    widget.updateUiCallback();
                              });
                            }
                          },
                          drawSurfaceAboveChild: true,
                          style: const NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            shape: NeumorphicShape.flat,

                          ),
                          child: FaIcon(
                            editMode ? FontAwesomeIcons.circleMinus : FontAwesomeIcons.check,
                            size: 2.h,
                            color: editMode ? Colors.deepPurple : status == 0 ? Colors.green.shade900 : Colors.green.shade400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          name,
                          style: GoogleFonts.heebo(
                              fontSize: 12.sp,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFA0E3371),
                              shadows: [cTextShadow(shadowColor: Colors.grey.shade400)]
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        NeumorphicIcon(
                            FontAwesomeIcons.clockRotateLeft,
                            size: 2.h,
                            style: const NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                              color: Colors.purple,
                            )
                        ),
                        SizedBox(width: 1.5.w),
                        Text(
                            upcomingTime,
                            style: GoogleFonts.heebo(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFA5C0E71),
                                shadows: [cTextShadow(shadowColor: Colors.grey.shade400)]
                            )
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              description,
                              style: GoogleFonts.lobster(
                                  fontSize: 9.5.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFA71230E),
                                  letterSpacing: 0.5.sp,
                                  shadows: [cTextShadow(shadowColor: Colors.grey.shade400)]
                              ),
                            ),
                            const Spacer(),
                          ],
                        )
                    ),
                    const Spacer(),
                  ],
                ),
              )
          )
      ),
    );
  }
}