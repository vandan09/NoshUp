import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';

import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  User _user = new User();

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
    RegExp regExp = new RegExp(r'^([a-zA-Z0-9_\-\.]+)@ddu.ac.in$');
    if (!regExp.hasMatch(_user.email)) {
      toast("Enter a valid Email ID");
    } else {
      print("Success");
      forgotPassword(_user, authNotifier, context);
    }
  }

  Widget _buildForgotPasswordForm() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          child: Text(
            'Reset Password',
            style: TextStyle(
                fontWeight: FontWeight.w800, color: Colors.black, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 70,
        ),
        // Email Text Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.email = value;
            },
            cursorColor: Color.fromRGBO(255, 63, 111, 1),
            decoration: InputDecoration(
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
        ),
        SizedBox(
          height: 70,
        ),
        //Reset Password BUTTON
        GestureDetector(
            onTap: () {
              _submitForm();
            },
            child: CustomRaisedButton(
              buttonText: 'Reset Password',
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
            child: Stack(
              children: <Widget>[
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
                  margin: EdgeInsets.fromLTRB(30, 280, 30, 50),

                  height: 350,
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
                  child: _buildForgotPasswordForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
