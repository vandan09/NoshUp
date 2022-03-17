import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noshup_admin/firebase/adminData.dart';
import 'package:noshup_admin/firebase/apis.dart';
import 'package:noshup_admin/model/auth.dart';
import 'package:noshup_admin/screens/Profile/Profile.dart';
import 'package:noshup_admin/screens/menupages/raiseButton.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    final nameController =
        TextEditingController(text: '${loggedInAdmin.uname}');

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.redAccent),
        elevation: 5,
        title: Text(
          "Edit profile",
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
                  TextFormField(
                    // initialValue: '${authNotifier.userDetails.displayName}',
                    controller: nameController..text = '${loggedInAdmin.uname}',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      suffixIcon: IconButton(
                        onPressed: nameController.clear,
                        icon: Icon(Icons.clear),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      labelText: 'Enter name',
                    ),
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'Name must have atleast 3 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('admin')
                            .doc(user!.uid)
                            .update({
                          'uname': '${nameController.text}',
                        }).then((value) =>
                                toast('Profile updated successfully'));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ProfilePage();
                          }),
                        );
                      }
                    },
                    child: CustomRaisedButton(buttonText: 'Save change'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
