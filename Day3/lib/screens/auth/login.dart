import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ui/service/authentication_service.dart';
import 'package:home_ui/shared/progress_widget.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visiblePassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
          obscureText: (keyboardType != TextInputType.emailAddress && !_visiblePassword),
          style: GoogleFonts.roboto(fontSize: 10.sp, fontWeight: FontWeight.w800, color: const Color(0xFF84848c)),
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: keyboardType != TextInputType.emailAddress ? _buildPasswordVisibilityButton() : null,
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
            bool value = await AuthenticationService.login(email: _emailController.value.text, password: _passwordController.value.text);
            return value;
          }).then((value) {
            if (value) {
                Navigator.of(context).pushNamed('/home');
            } else {
              var snackBar = SnackBar(
                content: Text(
                  'Invalid Email or Password',
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
                        "LOGIN",
                        style: GoogleFonts.sourceSansPro(fontSize: 26.sp, fontWeight: FontWeight.w600, shadows: cTextShadowStyle)
                      ),
                      SizedBox(height: .2.h),
                      Text(
                        "Sigin to continue!",
                        style: GoogleFonts.dmSans(fontSize: 11.sp, color: const Color(0xFF848c8b), fontWeight: FontWeight.w500, shadows: cTextShadowStyle),
                      ),
                      SizedBox(height: 5.h),
                      _buildTextFieldWidget(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'EMAIL ADDRESS',
                        prefixIcon: Icon(Icons.mail_outline_rounded, color: Colors.black54, size: 2.5.h),
                        validator: (value) {
                          if (value == null || value.isEmpty) return ' *Required Field';
                          print(value);
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
                        },
                        controller: _passwordController,
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 11.w),
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 10.5.sp, color: const Color(0xFF222222), shadows: cTextShadowStyle),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      _buildSubmitButton(context),
                      SizedBox(height: 3.5.h),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 10.w),
                        child: Text(
                          "Or Login With",
                          style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 10.5.sp, color: const Color(0xFF222222), shadows: cTextShadowStyle)
                        )
                      ),
                      SizedBox(height: 3.5.h),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildSocialLoginButton(onPressed: (){}, iconData: FontAwesomeIcons.apple, context: context),
                            SizedBox(width: 8.w),
                            buildSocialLoginButton(onPressed: (){}, iconData: FontAwesomeIcons.google, context: context),
                            SizedBox(width: 8.w),
                            buildSocialLoginButton(onPressed: (){}, iconData: FontAwesomeIcons.facebookF, context: context),
                          ],
                        ),
                      ),
                      SizedBox(height: 9.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.dmSans(fontSize: 13.sp, fontWeight: FontWeight.w800, color: const Color(0xFF848c8b), shadows: cTextShadowStyle)
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).popAndPushNamed('/register');
                            },
                            splashColor: Colors.white54,
                            child: Text(
                              "Sign up",
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
