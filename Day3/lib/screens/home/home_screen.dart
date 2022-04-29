import 'dart:async';


import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ui/models/medicine_model.dart';
import 'package:home_ui/screens/home/constants.dart';
import 'package:home_ui/service/medicine_service.dart';
import 'package:home_ui/service/storage_service.dart';
import 'package:home_ui/shared/util.dart';
import 'package:home_ui/widgets/medicine_card.dart';
import 'package:home_ui/widgets/medicine_dialog.dart';
import 'package:home_ui/screens/home/top_cardView.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final logger = Logger();
  bool _editMode = false;
  final DateTime _selectedDate = DateTime.now();
  int medicineStatus = 0;
  late String userName;

  List<MedicineModel>? _upcomingMedicineModels;
  List<MedicineModel>? _pastMedicineModels;

  final snackBarTokenExpired = SnackBar(
    content: Text(
      'Please Sigin Again Token expired',
      style: GoogleFonts.roboto(fontSize: 8.sp, color: Colors.red.shade900),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.blue.shade200,
    elevation: 5.h,
    behavior: SnackBarBehavior.floating,
  );


  void _getMedicine() {
    MedicineService.getMedicineList(date: Util.parseDateTimeToString(DateTime.now()), status: 1)
        .then((value) => setState((){
      value == null ? ScaffoldMessenger.of(context).showSnackBar(snackBarTokenExpired)
          : _upcomingMedicineModels = value;})
    );
      
      MedicineService.getMedicineList(date: Util.parseDateTimeToString(DateTime.now()), status: 0)
          .then((value) => setState((){
        value == null ? ScaffoldMessenger.of(context).showSnackBar(snackBarTokenExpired)
            : _pastMedicineModels = value;
          }));
  }
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    _getMedicine();
    StorageService.retrieveUserName().then((value) => userName = value!);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }


  Widget _buildDateCalenderRow() {
    return Row(
      children: [
        NeumorphicIcon(
          FontAwesomeIcons.clock,
          size: 6.w,
          style:  NeumorphicStyle(
            depth: 4.h,
            intensity: 1,
            color: Colors.deepPurple,
          ),
        ),
        SizedBox(width: 4.w),
        StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: ((context, snapshot) {
            return Text(
                DateFormat("EEE d MMM, yyy\nkk:mm:ss").format(DateTime.now()),
                style: GoogleFonts.workSans(
                  fontSize: 3.5.w,
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    cTextShadow(shadowColor: Colors.grey.shade300),
                  ]
                )
            );
          }),
        ),
        SizedBox(width: 30.w),
        NeumorphicButton(
            onPressed: (){
              setState(() {
                showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2015), lastDate: DateTime(2101));
              });
            },
            child: const FaIcon(FontAwesomeIcons.circleArrowDown, color: Colors.deepPurple),
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            )
        )
      ],
    );
  }


  Widget _buildUpcomingMedicationRow() {
    return Row(
      children: <Widget>[
        Text(
            "Upcoming Medications",
            style: GoogleFonts.fredokaOne(
                fontSize: 5.3.w,
                color: Colors.pink,
                shadows: [
                  cTextShadow(shadowColor: Colors.grey.shade300),
                ]
            )
        ),
        SizedBox(width: 8.w),
        NeumorphicButton(
            onPressed: (){
              setState(() {
                _editMode ^= true;
              });
            },
            child: const FaIcon(FontAwesomeIcons.pencil, color: Colors.deepPurple),
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            )
        )
      ],
    );
  }


  Widget _buildNoMedicineScene({required String text}) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts
            .roboto(fontSize: 14.sp, color: Colors.blue.shade900, fontWeight: FontWeight.bold, shadows: [cTextShadow(shadowColor: Colors.blueGrey.shade200)],

        ),
      ),
    );
  }

  Widget _buildMedicineScene(List<MedicineModel>? modelList) {
    logger.d('Medicine Models before building $_upcomingMedicineModels');
    logger.i('Edit Mode $_editMode');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (modelList != null)
          for (MedicineModel model in modelList)
              for (String time in model.timeList!)
                MedicineCard(editMode: _editMode, id: model.id!, status: model.status!,name: model.name!,
                    dosage: model.dosage!, type: model.type!,
                    description: model.description!, upcomingTime: time, updateUiCallback: (){
                        setState(() {
                          _getMedicine();
                        });
                    }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: NeumorphicFloatingActionButton(
        onPressed: () async {
           bool result = await buildDialog(context);
           if (result) {
             setState(() {
               _getMedicine();
             });
           }
        },
        style: NeumorphicStyle(
          boxShape: const NeumorphicBoxShape.circle(),
          intensity: 1,
          shape: NeumorphicShape.flat,
          depth: 10.h,
          shadowDarkColor: Colors.blueGrey.shade400,
        ),
        child: Center(child: FaIcon(FontAwesomeIcons.circlePlus, size: 5.h, color: Colors.redAccent)),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            TopCardView.buildTopCard(context: context,
              numMedications: _upcomingMedicineModels != null ?_upcomingMedicineModels!.length : 0,
              completed: _pastMedicineModels != null ? _pastMedicineModels!.length : 0,
              name: userName,
            ),
            SizedBox(height: 4.h),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDateCalenderRow(),
                      SizedBox(height: 2.5.h,),
                      _buildUpcomingMedicationRow(),
                      SizedBox(height: 4.h),
                      if (_upcomingMedicineModels == null || _upcomingMedicineModels!.isEmpty)
                        _buildNoMedicineScene(text: "No Medication Today!! Have a good day")
                      else
                        _buildMedicineScene(_upcomingMedicineModels),

                      SizedBox(height: 4.h,),
                      Text(
                          "History of Today",
                          style: GoogleFonts.fredokaOne(
                              fontSize: 5.3.w,
                              color: Colors.orangeAccent,
                              shadows: [
                                cTextShadow(shadowColor: Colors.grey.shade300),
                              ]
                          )
                      ),
                      SizedBox(height: 3.h),
                      if (_pastMedicineModels == null || _pastMedicineModels!.isEmpty)
                        _buildNoMedicineScene(text: "Your Today's History is Empty!!")
                      else
                        _buildMedicineScene(_pastMedicineModels)
                    ],
                  )
                )
              ),
            ),
          ],
        )
      )
    );
  }
}
