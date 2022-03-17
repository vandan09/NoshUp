import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/forgotPassword.dart';
import 'package:canteen_food_ordering_app/screens/signup.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';

import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  User _user = new User();
  bool isSignedIn = false, showPassword = true;

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier, context);
    super.initState();
  }

  void toast(String data) {
    Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  void _submitForm() {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    RegExp regExp = new RegExp(r'^([a-zA-Z0-9_\-\.]+)@ddu.ac.in');
    if (!regExp.hasMatch(_user.email)) {
      toast("Enter a valid Email ID");
    } else if (_user.password.length < 6) {
      toast("Password must have atleast 6 characters");
    } else {
      print("Success");
      login(_user, authNotifier, context);
    }
  }

  Widget _buildLoginForm() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 55,
        ),
        //login bold black
        Container(
          child: Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.w800, color: Colors.black, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        // Email Text Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,

            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.email = value;
            },
            // cursorColor: Color.fromRGBO(255, 63, 111, 1),
            decoration: InputDecoration(
                // iconColor: Color.fromRGBO(1, 1, 1, 100),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.redAccent,
                ),
                labelText: 'Enter Email Address',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                floatingLabelStyle: TextStyle(color: Colors.redAccent),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent))),
          ),
        ), //EMAIL TEXT FIELD
        SizedBox(
          height: 20,
        ),
        // Password Text Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

          child: TextFormField(
            obscureText: showPassword,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.password = value;
            },
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.redAccent,
                ),
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.redAccent,
                    )),
                labelText: 'Password',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                // labelStyle: TextStyle(color: Colors.grey),
                floatingLabelStyle: TextStyle(color: Colors.redAccent),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Forgot Password Line
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ForgotPasswordPage();
                  },
                ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
        ),
        //LOGIN BUTTON
        GestureDetector(
            onTap: () {
              _submitForm();
            },
            child: CustomRaisedButton(
              buttonText: 'Login',
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formkey,
        child: SingleChildScrollView(
          // child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          //     Widget>[
          //   //--------Red Part----------
          //   Container(
          //     padding: EdgeInsets.fromLTRB(15, 125, 0, 0),
          //     width: MediaQuery.of(context).size.width,
          //     height: 200,
          //     color: Colors.redAccent,
          //     child: Text(
          //       'Hello',
          //       style: TextStyle(
          //           fontSize: 70,
          //           //fontFamily: Questrial,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black),
          //     ),
          //   ),
          //   Container(
          //     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //     width: MediaQuery.of(context).size.width,
          //     // height: 200,
          //     color: Colors.redAccent,
          //     child: Row(
          //       children: [
          //         Container(
          //           padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
          //           // width: 223,
          //           // height: 100,
          //           color: Colors.redAccent,
          //           child: Text(
          //             'There',
          //             style: TextStyle(
          //                 fontSize: 70,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.white),
          //           ),
          //         ),
          //         Container(
          //           padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //           // width: 137,
          //           // height: 100,
          //           color: Colors.redAccent,
          //           child: Text(
          //             '.',
          //             style: TextStyle(
          //                 fontSize: 70,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.white),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),

          //   SizedBox(height: 30),
          //   //----------log in text-----------------
          //   Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: new Container(
          //             margin: const EdgeInsets.only(left: 32.0, right: 10.0),
          //             child: Divider(
          //               color: Colors.black,
          //               height: 50,
          //             )),
          //       ),
          //       Text(
          //         "Log in",
          //         style: TextStyle(color: Colors.grey[600]),
          //       ),
          //       Expanded(
          //         child: new Container(
          //             margin: EdgeInsets.only(left: 15.0, right: 32.0),
          //             child: Divider(
          //               color: Colors.black,
          //               height: 50,
          //             )),
          //       ),
          //     ],
          //   ),
          //   Container(child: _buildLoginForm())
          // ]),
          child: Stack(
            children: [
              //upper red part

              Container(
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      // stops: [
                      //   0.1,
                      //   0.7
                      // ],
                      colors: [
                        Colors.redAccent.shade400,
                        Colors.redAccent,
                      ]),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                ),
              ),
              //nosh up at top
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(30, 60, 30, 50),
                child: Text(
                  'NoshUp',
                  style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                    fontSize: 40,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  )),
                ),
              ),
              //white box
              Container(
                // margin: EdgeInsets.only(top: 80),
                margin: EdgeInsets.fromLTRB(30, 180, 30, 50),

                height: 470,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(0.0, 0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: _buildLoginForm(),
              ),
              // SignUp Line
              Container(
                margin: EdgeInsets.fromLTRB(30, 700, 30, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Not a registered user?',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SignupPage();
                          },
                        ));
                      },
                      child: Container(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
