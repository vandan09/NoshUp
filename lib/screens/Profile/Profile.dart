import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noshup_admin/firebase/adminData.dart';
import 'package:noshup_admin/firebase/apis.dart';
import 'package:noshup_admin/model/auth.dart';
import 'package:noshup_admin/screens/Profile/editProfile.dart';
import 'package:noshup_admin/screens/Registration/login.dart';
import 'package:noshup_admin/screens/menupages/menu.dart';

import 'package:noshup_admin/utils/routes.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  AdminModel loggedInAdmin = AdminModel();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    super.initState();
    FirebaseFirestore.instance
        .collection("admin")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInAdmin = AdminModel.fromMap(value.data());
      setState(() {});
    });
  }

  signOutUser() {
    toast('Log out Successfully');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return const AdminLoginPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final user = UserPreferences.myUser;
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.redAccent),
        elevation: 5,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 25,
          ),
        ),
        toolbarHeight: 55,
        shadowColor: Colors.grey.shade600,
        backgroundColor: Colors.grey.shade200,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  //-------------personal  info--------------
                  Text(
                    "Personal Information",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${loggedInAdmin.uname}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  //--------email----------
                  Text(
                    "${loggedInAdmin.email}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 4,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Center(child: buildEditButton()),

                  //---------------line------------
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.grey.shade400,
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  //----------------help-------------
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Text('Help',
                          style: TextStyle(
                              // fontFamily: 'motserrat',
                              color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //--------------about---------
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Text('About',
                          style: TextStyle(
                              // fontFamily: 'motserrat',
                              color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //-----------send feedback
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Text('Send feedback',
                          style: TextStyle(
                              // fontFamily: 'motserrat',
                              color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //----------logout-------------
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: InkWell(
                      onTap: () {
                        signOutUser();
                      },
                      child: Text('Log out',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//---------editbutton---------
  Widget buildEditButton() => Center(
        child: Container(
          height: 40,
          width: 120,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            shadowColor: Colors.redAccent,
            color: Colors.redAccent,
            elevation: 7,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
              child: Center(
                child: Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.white,
                      //fontFamily: 'motserrat',
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      );
}
