import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:noshup_admin/screens/menupages/menu.dart';
import 'package:noshup_admin/utils/routes.dart';
import 'package:web_ffi/web_ffi.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formkey,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.redAccent.shade400,
                    Colors.redAccent,
                  ]),
            ),
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
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //-----red part-----
                          Text(
                            "Hello",
                            style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "There",
                                style: TextStyle(
                                    fontSize: 40,
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
                              "Log in",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Expanded(
                              child: new Container(
                                  margin:
                                      EdgeInsets.only(left: 15.0, right: 32.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 50,
                                  )),
                            ),
                          ]),

                          //-----------email------------
                          Container(
                            width: 250,
                            child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
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
                                  emailController.text = value!;
                                },
                                controller: emailController),
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
                              controller: passwordController,
                              obscureText: _obscureText,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //------forget password---------
                          Container(
                            width: 250,
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, MyRoutes.ResetPasswordRoute),
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                      // fontFamily: 'motserrat',
                                      color: Colors.redAccent)),
                            ),
                          ),
                          SizedBox(height: 30),
                          //------------Login Button-------------
                          Container(
                            height: 40,
                            width: 150,
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              shadowColor: Colors.redAccent,
                              color: Colors.redAccent,
                              elevation: 7,
                              child: InkWell(
                                onTap: () => logIn(emailController.text,
                                    passwordController.text),
                                child: Center(
                                  child: Text(
                                    'Log in',
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
                          //--------------signup link-----------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Don’t have an account?',
                                  style:
                                      TextStyle(color: Colors.grey.shade600)),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, MyRoutes.SignUpRoute);
                                  },
                                  child: Text(
                                    'SIGN UP',
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

  Future<void> logIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(
                    msg: "Login Successful :)",
                    timeInSecForIosWeb: 5,
                    webBgColor: "linear-gradient(to right, #530084, #ff5252)"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MenuPage()))
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: "${e.message}",
            timeInSecForIosWeb: 5,
            webBgColor: "linear-gradient(to right, #530084, #ff5252)");
      });
    }
  }
}
