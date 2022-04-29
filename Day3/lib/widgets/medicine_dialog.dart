
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ui/models/medicine_model.dart';
import 'package:home_ui/service/alarm_service.dart';
import 'package:home_ui/service/medicine_service.dart';
import 'package:home_ui/shared/progress_widget.dart';
import 'package:home_ui/shared/util.dart';
import 'package:home_ui/widgets/medicine_timeslot.dart';
import 'package:sizer/sizer.dart';
import 'package:logger/logger.dart';


class _MedicineDialog extends StatefulWidget {

  const _MedicineDialog({Key? key}) : super(key: key);

  @override
  State<_MedicineDialog> createState() => __MedicineDialogState();
}

class __MedicineDialogState extends State<_MedicineDialog> {
  final logger = Logger();

  String? countValue;
  String? medicineType;
  final DateTime _selectedDate = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _timeList = List.empty(growable: true);


  void onSave({required BuildContext context}) {
    // TODO verify this line
    while (_timeList.length > int.parse(countValue!)) {
      _timeList.removeLast();
    }

    final name = _nameController.value.text;
    final description = _descriptionController.value.text;
    final dateList = <String>[Util.parseDateTimeToString(_selectedDate)];
    final type = medicineType != null ? medicineType! : '';

    logger.i('Saving model');
    MedicineModel model = MedicineModel(
        id: 0, name: name, description: description,
        dosage: 2, type: type, timeList: _timeList, dateList: dateList,
        status: 1
    );
    logger.d("Saving Model\n$model");
    // TODO workaround need concrete implementation
    showProgress(context: context, work: () async {
      await MedicineService.postMedicine(model);
      return true;
    });

    // WARN LAZY WORK
    Navigator.of(context).pop(true);
  }

  Widget _buildMedicineTypeRadio({required String type}) {
    return NeumorphicRadio(
      style: const NeumorphicRadioStyle(
        boxShape: NeumorphicBoxShape.circle(),
      ),
      value: type,
      groupValue: medicineType,
      onChanged: (String? type) => setState(() {
        medicineType = type;
      }),
      padding: EdgeInsets.all(2.w),
      child: Text(
        type,
      )
    );
  }

  Widget _buildMedicineTimeSlotRow() {
    if (countValue == null) return const SizedBox(height: 0);
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < int.parse(countValue!); ++i)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w,),
                child: MedicineTimeSlot(
                  callback: (time) => _timeList.add(Util.parseTimeOfDayToString(time)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: NeumorphicTheme.embossDepth(context),
          boxShape: const NeumorphicBoxShape.stadium(),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        child: TextField(
          controller: _nameController,
          decoration: const InputDecoration.collapsed(hintText: 'name'),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: NeumorphicTheme.embossDepth(context),
          boxShape: const NeumorphicBoxShape.stadium(),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        child: TextField(
          textAlign: TextAlign.center,
          controller: _descriptionController,
          decoration: const InputDecoration.collapsed(hintText: 'description'),
          maxLines: 3,
        ),
      ),
    );
  }

  Widget _buildDateTimeRow() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            NeumorphicButton(
              onPressed: ()   {
                setState(() {
                  showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
                });
              },
              style: const NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                shape: NeumorphicShape.flat,
              ),
              child: FaIcon(FontAwesomeIcons.calendarPlus, size: 4.5.w, color: Colors.deepPurple),
            ),
            SizedBox(width: 2.w),
            Text("Choose Dates", style: GoogleFonts.roboto(
              fontSize: 8.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
            ),
            const Spacer(),
            Neumorphic(
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      onChanged: (String? value){
                        setState(() {
                          countValue = value;
                          while (_timeList.length > int.parse(countValue!)) {
                            _timeList.removeLast();
                          }
                        });
                      },
                      customButton: const FaIcon(FontAwesomeIcons.circleArrowDown, color: Colors.deepPurple),
                      items: ['1', '2', '3', '4'].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child:   Text(val),
                          );
                        },
                      ).toList(),
                      itemHeight: 2.5.h,
                      dropdownElevation: 2.4.h.floor(),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.h),
                          color: Colors.white60,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white70,
                              spreadRadius: .05.h,
                              blurRadius: .2.h,
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
                          ]
                      ),
                      dropdownWidth: 12.w,
                    )
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.5.w, right: 1.w),
              child: Text(
                "times",
                style: GoogleFonts.roboto(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.h)),
        child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5.h)),
          ),
          child: Container(
            height: 55.h,
            width: 75.w,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NeumorphicButton(
                  onPressed: (){
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  style: const NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle()
                  ),
                  child: const FaIcon(FontAwesomeIcons.arrowLeft),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    "Medicine Type",
                    style: GoogleFonts.roboto(fontSize: 8.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMedicineTypeRadio(type: "AB"),
                    _buildMedicineTypeRadio(type: "AV"),
                    _buildMedicineTypeRadio(type: "OT"),
                  ],
                ),
                const Spacer(),
                _buildNameField(),
                const Spacer(),
                _buildDateTimeRow(),
                const Spacer(),
                _buildMedicineTimeSlotRow(),
                const Spacer(),
                _buildDescriptionField(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(1.h)),
                          color: Colors.lightBlue,
                        ),
                        onPressed: () => onSave(context: context),
                        child: SizedBox(
                          height: 3.h,
                          width: 20.w,
                          child: Center(
                            child: Text(
                                "Save",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

Future<dynamic> buildDialog(BuildContext context) async {
  final result = await showDialog(
      context: context,
      builder: (context) {
        return const _MedicineDialog();
      }
  );
  return true;
}

