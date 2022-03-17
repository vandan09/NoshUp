import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noshup_admin/firebase/apis.dart';
import 'package:noshup_admin/model/auth.dart';
import 'package:noshup_admin/model/user.dart';
import 'package:noshup_admin/utils/routes.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formkey = GlobalKey<FormState>();
  Users? _user = new Users();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    // initializeCurrentUser(authNotifier, context);
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

  final auth = FirebaseAuth.instance;

  void _submitForm() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();

    RegExp regExp = RegExp(r'^([a-zA-Z0-9_\-\.]+)@gmail.com$');
    if (!regExp.hasMatch(_user!.email!)) {
      toast("Enter a valid Email ID");
    } else {
      toast("Reset Password link shared to ${email.text}");

      auth.sendPasswordResetEmail(email: email.text);
    }
  }

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
                        height: 65,
                      ),
                      Container(
                          height: 515,
                          width: 325,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //-----red part-----
                                Text(
                                  "Reset",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    // Text(
                                    //   "!",
                                    //   style: TextStyle(
                                    //       fontSize: 45,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.redAccent),
                                    // ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: new Container(
                                        margin: const EdgeInsets.only(
                                            left: 32.0, right: 10.0),
                                        child: Divider(
                                          color: Colors.black,
                                          height: 50,
                                        )),
                                  ),
                                  Text(
                                    "Please enter your email id",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Expanded(
                                    child: new Container(
                                        margin: EdgeInsets.only(
                                            left: 15.0, right: 32.0),
                                        child: Divider(
                                          color: Colors.black,
                                          height: 50,
                                        )),
                                  ),
                                ]),
                                SizedBox(
                                  height: 20,
                                ),

                                //----Password------------
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 32.0),
                                  child: Column(children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.redAccent,
                                          ),
                                          labelText: 'Enter your email',
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          floatingLabelStyle: TextStyle(
                                              color: Colors.redAccent),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.redAccent))),
                                      validator: (value) {
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _user!.email = value!;
                                        email.text = value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),

                                    //--------Button--------------
                                    SizedBox(height: 40),
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
                                            _submitForm();
                                          },
                                          child: Center(
                                            child: Text(
                                              'Reset',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  //fontFamily: 'motserrat',
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ))
                    ]))));
  }
}
