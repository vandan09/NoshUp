import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noshup_admin/firebase/userData.dart';
import 'package:noshup_admin/screens/Registration/login.dart';

import 'package:noshup_admin/utils/routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  final usernameController = new TextEditingController();

  final emailEditingController = new TextEditingController();
  final mobilenoController = new TextEditingController();

  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formkey,
          child: Container(
            color: Colors.redAccent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 560,
                  width: 325,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //-----red part-----

                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "!",
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          //-----------username------------
                          Container(
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.redAccent,
                                ),
                                labelText: 'Enter username',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                floatingLabelStyle:
                                    TextStyle(color: Colors.redAccent),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                usernameController.text = value!;
                              },
                              controller: usernameController,
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //----------email-------
                          Container(
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.redAccent,
                                ),
                                labelText: 'Enter your email',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                floatingLabelStyle:
                                    TextStyle(color: Colors.redAccent),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                }
                                if (!RegExp("^[a-zA-Z0-9+_.-]+@gmail.com")
                                    .hasMatch(value)) {
                                  return "Please enter a valid email";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                emailEditingController.text = value!;
                              },
                              controller: emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //----Password------------
                          Container(
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.redAccent,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.redAccent,
                                    )),
                                labelText: 'Password',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                floatingLabelStyle:
                                    TextStyle(color: Colors.redAccent),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                } else if (value.length < 6) {
                                  return "Password length should be atleast 6";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                passwordEditingController.text = value!;
                              },
                              controller: passwordEditingController,
                              obscureText: _obscureText,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //------confirm passsword-----
                          Container(
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.redAccent,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.redAccent,
                                    )),
                                labelText: 'Confirm Password',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                floatingLabelStyle:
                                    TextStyle(color: Colors.redAccent),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                } else if (confirmPasswordEditingController
                                        .text !=
                                    passwordEditingController.text) {
                                  return "Password don't match";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                confirmPasswordEditingController.text = value!;
                              },
                              controller: confirmPasswordEditingController,
                              obscureText: _obscureText,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          //------------Sign up Button-------------
                          Container(
                            height: 40,
                            width: 150,
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              shadowColor: Colors.redAccent,
                              color: Colors.redAccent,
                              elevation: 7,
                              child: InkWell(
                                onTap: () {
                                  signUp(
                                    emailEditingController.text,
                                    passwordEditingController.text,
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        //fontFamily: 'motserrat',
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //----------log in link----------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Already have an account?',
                                  style:
                                      TextStyle(color: Colors.grey.shade600)),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, MyRoutes.loginPage);
                                  },
                                  child: Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      //fontFamily: 'motserrat',
                                    ),
                                  ))
                            ],
                          )
                        ]),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(
              msg: e!.message,
              timeInSecForIosWeb: 5,
              webBgColor: "linear-gradient(to right, #530084, #ff5252)");
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.uname = usernameController.text;
    userModel.email = user!.email;
    userModel.mobileno = mobilenoController.text;

    await firebaseFirestore
        .collection("admin")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully :) ",
        timeInSecForIosWeb: 5,
        webBgColor: "linear-gradient(to right, #530084, #ff5252)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => AdminLoginPage()),
        (route) => false);
  }
}
