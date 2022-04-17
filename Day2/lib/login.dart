import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'design_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visiblePassword = false;

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
  }

  Widget _drawLogoShape() {
    return Stack(
      children: [
        DottedBorder(
          color: Colors.black38,
          strokeWidth: .3.h,
          borderType: BorderType.Circle,
          dashPattern: [.6.h, .6.h],
          child: Container(
            height: 8.h,
            width: 8.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: .85.h, left: 1.85.w),
          height: 6.7.h,
          width: 6.7.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.black87, width: .35.h)
          ),
        )
      ],
    );
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
          required VoidCallback onTap
        })  {


    return Container(
        width: 80.w,
        height: 6.h,
        padding: EdgeInsets.only(top: .9.h, left: 3.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: cBoxShadowStyle,
          borderRadius: BorderRadius.all(Radius.circular(1.4.h)),
        ),
        child: TextField(
          keyboardType: keyboardType,
          obscureText: (keyboardType != TextInputType.emailAddress && !_visiblePassword),
          style: GoogleFonts.roboto(fontSize: 10.sp, fontWeight: FontWeight.w800, color: const Color(0xFF84848c)),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: keyboardType != TextInputType.emailAddress ? _buildPasswordVisibilityButton() : null,
            hintText: hintText,
            hintStyle: GoogleFonts.dmSans(fontSize: 10.sp, fontWeight: FontWeight.w700, color: const Color(0xFF84848c), shadows: cTextShadowStyle),
            border: InputBorder.none
          ),
          autocorrect: false,
          onTap: (){},
        )
    );
  }

  Widget _buildSubmitButton() {
    return MaterialButton(
      onPressed: (){},
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

  Widget _buildSocialLoginButton({
        required VoidCallback onPressed,
        required IconData iconData,
      }) {

    return Container(
        height: 6.h,
        width: 6.h,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(1.5.h),
          boxShadow: cBoxShadowStyle,
        ),
        child: MaterialButton(
          onPressed: (){},
          splashColor: Colors.white54,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.5.h)),
          child: FaIcon(iconData, color: Colors.black, size: 3.h),
        )
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
              Padding(padding: EdgeInsets.only(top: 8.h, left: 8.w), child: _drawLogoShape()),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 22.h, left: 8.w),
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
                      onTap: (){}
                    ),
                    SizedBox(height: 2.5.h),
                    _buildTextFieldWidget(
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'PASSWORD',
                      prefixIcon: Icon(Icons.lock_rounded, color: Colors.black54, size: 2.5.h),
                      onTap: (){}
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
                    _buildSubmitButton(),
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
                          _buildSocialLoginButton(onPressed: (){}, iconData: FontAwesomeIcons.apple),
                          SizedBox(width: 8.w),
                          _buildSocialLoginButton(onPressed: (){}, iconData: FontAwesomeIcons.google),
                          SizedBox(width: 8.w),
                          _buildSocialLoginButton(onPressed: (){}, iconData: FontAwesomeIcons.facebookF),
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
                          onTap: (){},
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
            ],
          ),
        ),
      ),
    );
  }
}
