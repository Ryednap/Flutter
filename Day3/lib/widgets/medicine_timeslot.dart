import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ui/shared/util.dart';
import 'package:sizer/sizer.dart';

class MedicineTimeSlot extends StatefulWidget {
  final void Function(TimeOfDay) callback;
  const MedicineTimeSlot({Key? key, required this.callback}) : super(key: key);

  @override
  State<MedicineTimeSlot> createState() => _MedicineTimeSlotState();
}

class _MedicineTimeSlotState extends State<MedicineTimeSlot> {
  TimeOfDay ?_time;
  final now = TimeOfDay.now().replacing(hour: 11, minute: 30);
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: (){
        setState(() {
          Navigator.of(context).push(
            showPicker(
              value: now,
              onChange: (TimeOfDay newTime) {
                setState(() {
                  _time = newTime;
                  widget.callback(_time!);
                });
              },
              elevation: 3.h,
            )
          );
        });
      },
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(1.h)),
      ),
      child: _time != null ? Text(Util.parseTimeOfDayToString(_time!), style: GoogleFonts.roboto(
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black54,
        ),
      ) : const FaIcon(FontAwesomeIcons.solidClock, color: Colors.deepPurple)
    );
  }
}
