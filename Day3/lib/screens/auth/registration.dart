import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ui/service/storage_service.dart';
import 'package:sizer/sizer.dart';

import '../../service/authentication_service.dart';
import '../../shared/progress_widget.dart';
import 'constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _visiblePassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _passwordVerifier = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$", caseSensitive: false);
  final _emailVerifier = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
    _passwordController.dispose();
    _emailController.dispose();
  }


  Widget _buildPasswordVisibilityButton() {
    return IconButton(
      icon: Icon(
          _visiblePassword ? Icons.visibility : Icons.visibility_off,
          color: const Color(0xFF84848c)
      ),
      onPressed: () {
        setState(() {
          _visiblePassword = !_visiblePassword;
        });
      },
    );
  }


  Widget _buildTextFieldWidget({
    required TextInputType keyboardType,
    required String hintText,
    required Icon prefixIcon,
    required String? Function(String?) validator,
    required TextEditingController controller
  })  {


    return Container(
        width: 80.w,
        height: 6.5.h,
        padding: EdgeInsets.only(top: .9.h, left: 3.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: cBoxShadowStyle,
          borderRadius: BorderRadius.all(Radius.circular(1.4.h)),
        ),
        child: TextFormField  (
          keyboardType: keyboardType,
          controller: controller,
          obscureText: (keyboardType == TextInputType.visiblePassword && !_visiblePassword),
          style: GoogleFonts.roboto(fontSize: 10.sp, fontWeight: FontWeight.w800, color: const Color(0xFF84848c)),
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: keyboardType == TextInputType.visiblePassword ? _buildPasswordVisibilityButton() : null,
            hintText: hintText,
            hintStyle: GoogleFonts.dmSans(fontSize: 10.sp, fontWeight: FontWeight.w700, color: const Color(0xFF84848c), shadows: cTextShadowStyle),
            border: InputBorder.none,
            errorStyle: GoogleFonts.openSans(fontSize: 7.sp, fontWeight: FontWeight.w600, color: Colors.red.shade900, shadows: cTextShadowStyle),
          ),
          autocorrect: false,
        )
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (_formKey.currentState!.validate()){
          showProgress(context: context, work: () async {
            bool value = await AuthenticationService.register(
                userName: _usernameController.value.text,
                email: _emailController.value.text,
                password: _passwordController.value.text
            );
            return value;
          }).then((value) {
            if (value) {
              StorageService.storeUser(userName: _usernameController.value.text);
              Navigator.of(context).pushNamed('/login');
            } else {
              var snackBar = SnackBar(
                content: Text(
                  'Invalid Form',
                  style: GoogleFonts.roboto(fontSize: 8.sp, color: Colors.red.shade900),
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.blue.shade200,
                elevation: 5.h,
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        }
      },
      color: Colors.black,
      height: 7.h,
      minWidth: 80.w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
      child: Text(
        "LOGIN",
        style: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.w800,
            fontSize: 12.sp,
            color: const Color(0xEEDCDCDD),
            letterSpacing: .3.w,
            shadows: cTextShadowStyle
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 8.h, left: 8.w), child: drawLogoShape()),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 22.h, left: 8.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "SIGN UP",
                          style: GoogleFonts.sourceSansPro(fontSize: 26.sp, fontWeight: FontWeight.w600, shadows: cTextShadowStyle)
                      ),
                      SizedBox(height: .2.h),
                      Text(
                        "Sign up to get started!!",
                        style: GoogleFonts.dmSans(fontSize: 11.sp, color: const Color(0xFF848c8b), fontWeight: FontWeight.w500, shadows: cTextShadowStyle),
                      ),
                      SizedBox(height: 5.h),
                      _buildTextFieldWidget(
                        keyboardType: TextInputType.name,
                        hintText: 'FULL NAME',
                        prefixIcon: Icon(Icons.person_outline_rounded,color:  Colors.black54, size: 2.5.h),
                        validator: (value) {
                          if (value == null || value.isEmpty) return ' *Required Field';
                          return null;
                        },
                        controller: _usernameController,
                      ),
                      SizedBox(height: 2.5.h),
                      _buildTextFieldWidget(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'EMAIL ADDRESS',
                        prefixIcon: Icon(Icons.mail_outline_rounded, color: Colors.black54, size: 2.5.h),
                        validator: (value) {
                          if (value == null || value.isEmpty) return ' *Required Field';
                          if(!_emailVerifier.hasMatch(value)) return ' Invalid Email address';
                          return null;
                        },
                        controller: _emailController,
                      ),
                      SizedBox(height: 2.5.h),
                      _buildTextFieldWidget(
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'PASSWORD',
                        prefixIcon: Icon(Icons.lock_rounded, color: Colors.black54, size: 2.5.h),
                        validator: (value) {
                          if (value == null || value.isEmpty) return '*Required Field';
                          if (!_passwordVerifier.hasMatch(value)) return ' Minimum 8 characters, one letter, one number';
                          return null;
                        },
                        controller: _passwordController,
                      ),
                      SizedBox(height: 2.5.h),
                      _buildTextFieldWidget(
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'CONFIRM PASSWORD',
                        prefixIcon: Icon(Icons.lock_rounded, color: Colors.black54, size: 2.5.h),
                        validator: (value) {
                          if (value == null || value.isEmpty) return '*Required Field';
                          if (!_passwordVerifier.hasMatch(value)) return ' Minimum 8 characters, one letter, one number';
                          if (_passwordController.value.text != value) return ' Password fields do not match';
                          return null;
                        },
                        controller: _confirmPasswordController,
                      ),
                      SizedBox(height: 4.h),
                      _buildSubmitButton(context),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              "Already have an account? ",
                              style: GoogleFonts.dmSans(fontSize: 13.sp, fontWeight: FontWeight.w800, color: const Color(0xFF848c8b), shadows: cTextShadowStyle)
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).popAndPushNamed('/login');
                            },
                            splashColor: Colors.white54,
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.dmSans(fontSize: 13.5.sp, fontWeight: FontWeight.bold, color: Colors.black87, shadows: cTextShadowStyle),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
