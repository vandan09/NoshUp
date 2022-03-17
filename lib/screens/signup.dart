import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/models/user.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();

  User _user = new User();
  bool isSignedIn = false, showPassword = true, showConfirmPassword = true;

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
    RegExp regExp = new RegExp(r'^([a-zA-Z0-9_\-\.]+)@ddu.ac.in$');
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (_user.displayName.length < 3) {
      toast("Name must have atleast 3 characters");
    } else if (!regExp.hasMatch(_user.email)) {
      toast("Enter a valid Email ID");
    } else if (_user.phone.length != 10) {
      toast("Contact number length must be 10");
    } else if (int.tryParse(_user.phone) == null) {
      toast("Contact number must be a number");
    } else if (_user.password.length < 6) {
      toast("Password must have atleast 6 characters");
    } else if (_passwordController.text.toString() != _user.password) {
      toast("Confirm password does'nt match your password");
    } else {
      print("Success");
      _user.role = "user";
      _user.balance = 0.0;
      signUp(_user, authNotifier, context);
    }
  }

  Widget _buildSignUPForm() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Container(
          child: Text(
            'Sign Up',
            style: TextStyle(
                fontWeight: FontWeight.w800, color: Colors.black, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        // User Name Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.displayName = value;
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.redAccent,
                ),
                labelText: 'Username',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                floatingLabelStyle: TextStyle(color: Colors.redAccent),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Email Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.email = value;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Color.fromRGBO(255, 63, 111, 1),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.redAccent,
                ),
                labelText: 'Enter email address',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                floatingLabelStyle: TextStyle(color: Colors.redAccent),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //Phone Number Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              _user.phone = value;
            },
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            cursorColor: Color.fromRGBO(255, 63, 111, 1),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.redAccent,
                ),
                labelText: 'Enter mobile number',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                floatingLabelStyle: TextStyle(color: Colors.redAccent),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Password Field
        Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
                obscureText: showPassword,
                validator: (String value) {
                  return null;
                },
                onSaved: (String value) {
                  _user.password = value;
                },
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                cursorColor: Color.fromRGBO(255, 63, 111, 1),
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
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.redAccent,
                        )),
                    labelText: 'Password',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    floatingLabelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent))))),
        SizedBox(
          height: 20,
        ),
        // Confirm Password Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            validator: (String value) {
              return null;
            },
            obscureText: showConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            controller: _passwordController,
            cursorColor: Color.fromRGBO(255, 63, 111, 1),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.redAccent,
                ),
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showConfirmPassword = !showConfirmPassword;
                      });
                    },
                    child: Icon(
                      showConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.redAccent,
                    )),
                labelText: 'Confirm Password',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                floatingLabelStyle: TextStyle(color: Colors.redAccent),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent))),
          ),
        ),

        SizedBox(
          height: 30,
        ),
        // Sign Up Button
        GestureDetector(
            onTap: () {
              _submitForm();
            },
            child: CustomRaisedButton(
              buttonText: 'Sign up',
            )),
        SizedBox(
          height: 20,
        ),
        // Login Line
      ],
    );
  }

  String scanResult;
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
                child: Stack(children: <Widget>[
                  //upper red part

                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
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
                    margin: EdgeInsets.fromLTRB(30, 140, 30, 50),

                    height: 530,
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
                    child: _buildSignUPForm(),
                  ),
                  // SignUp Line
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 700, 30, 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
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
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Text(
                              'Log In ',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            )));
  }
}
