import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Responsive and Adaptive Login UI
/// Inspiration: https://dribbble.com/shots/16001898-Login-UI

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var width = 0.0;
  var height = 0.0;

  Widget _buildFormFieldWidget({required TextInputType keyboardType,
                                required String labelText,
                                required String hintText}) {

     return SizedBox(
         width: width / 1.25,
         child: TextField(
           keyboardType: keyboardType,
           style: TextStyle(color: Colors.black, fontSize: width / 25.0),
           autocorrect: false,
           obscureText: keyboardType == TextInputType.visiblePassword,
           decoration: InputDecoration(
               labelText: labelText,
               floatingLabelBehavior: FloatingLabelBehavior.always,
               labelStyle: GoogleFonts.roboto(fontSize: width / 25.0, color: Colors.grey),
               hintText: hintText,
               border: const OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(16)),
                   borderSide: BorderSide(color: Colors.grey, width: 1.0)
               ),
               isDense: true,
               contentPadding: EdgeInsets.only(top: height / 50.0 , left: 30, bottom: height / 25.0)
           ),
         )
     );
  }

  Widget _submitButton() {
    return MaterialButton(
        height: height / 11,
        minWidth: width / 1.6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ,
        color: Colors.lightBlueAccent,
        onPressed: (){},
        child: Text(
          "Sign In",
          style: GoogleFonts.workSans(fontWeight: FontWeight.w600, fontSize: width / 20, color: Colors.white, fontStyle: FontStyle.italic),
        )
    );
  }

  Widget _buildSocialSignInButton({required String imgLocation, required VoidCallback callback}) {
    return ElevatedButton(
        onPressed: callback,
        child: Image.asset(imgLocation, width: width / 10.0, height: height / 30.0),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.all(width / 20.0)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) return Colors.lightBlue.shade50;
          }),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                "Sign in",
                style: GoogleFonts.workSans(
                    fontSize: width / 10.0,
                    fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: height / 50.0),
              Text(
                "Enter your credentials to",
                style: GoogleFonts.ptSans(
                  fontSize: width / 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey
                )
              ),
              Center(
                child: Text(
                  "continue.",
                  style: GoogleFonts.ptSans(
                      fontSize: width / 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey
                  ),
                ),
              ),

              SizedBox(height: height / 20),
              _buildFormFieldWidget(keyboardType: TextInputType.emailAddress, labelText: "Email", hintText: "name@email.com"),
              SizedBox(height: height / 35),
              _buildFormFieldWidget(keyboardType: TextInputType.visiblePassword, labelText: "Password", hintText: ""),
              Container(
                child:InkWell(
                  child: Text(
                    "forgot your password?",
                    style: GoogleFonts.roboto(fontSize: width / 30.0, color: Colors.grey)
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) => states.contains(MaterialState.pressed) ? Colors.lightBlue.shade50 : null
                  ),
                  onTap: (){},
                ),
                alignment: Alignment.centerRight,
                margin:  EdgeInsets.only(right: width / 12, top: 8),
              ),
              SizedBox(height: height / 20.0),
              _submitButton(),
              SizedBox(height: height / 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  SizedBox(width: width / 10),
                  Expanded(child: Divider(color: Colors.grey, thickness: width / 250,)),
                  SizedBox(width: width / 60),
                  Text(
                    "Or Sign in With",
                    style: GoogleFonts.ptSans(fontSize: width / 28, color: Colors.grey),
                  ),
                  SizedBox(width: width / 60),
                  Expanded(child: Divider(color: Colors.grey, thickness: width / 250,)),
                  SizedBox(width: width / 10),
                ],
              ),
              SizedBox(height: height / 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildSocialSignInButton(imgLocation: "assets/google.png", callback: (){}),
                  SizedBox(width: width / 20.0),
                  _buildSocialSignInButton(imgLocation: "assets/facebook.png", callback: (){})
                ],
              ),
              SizedBox(height: height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text(
                    "Don't Have and Account?",
                    style: GoogleFonts.poppins(fontSize: width / 30.0, fontWeight: FontWeight.w600, color: Colors.black45)
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (states) => states.contains(MaterialState.pressed) ? Colors.lightBlue.shade50 : null
                    ),
                    onTap: (){},
                    child: Text(
                      " Sign up",
                      style: GoogleFonts.poppins(fontSize: width / 30.0, fontWeight: FontWeight.w600, color: Colors.lightBlue),
                    )
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
