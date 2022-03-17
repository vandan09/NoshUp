import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/GradientAppBar.dart';
import 'package:canteen_food_ordering_app/screens/navigationBar.dart';
import 'package:canteen_food_ordering_app/screens/profilePage.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    final nameController =
        TextEditingController(text: '${authNotifier.userDetails.displayName}');
    final phoneController =
        TextEditingController(text: '${authNotifier.userDetails.phone}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        // flexibleSpace: GradientAppBar(),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //nmae
                  TextFormField(
                    // initialValue: '${authNotifier.userDetails.displayName}',
                    controller: nameController
                      ..text = '${authNotifier.userDetails.displayName}',
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
                      if (value.length < 3) {
                        return 'Name must have atleast 3 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //phone
                  TextFormField(
                    // initialValue: '${authNotifier.userDetails.displayName}',
                    controller: phoneController
                      ..text = '${authNotifier.userDetails.phone}',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      suffixIcon: IconButton(
                        onPressed: phoneController.clear,
                        icon: Icon(Icons.clear),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      labelText: 'Enter mobile number',
                    ),
                    validator: (value1) {
                      if (value1.length < 10) {
                        return 'Contact number length must be 10';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        Firestore.instance
                            .collection('users')
                            .document(authNotifier.userDetails.uuid)
                            .updateData({
                          'displayName': '${nameController.text}',
                          'phone': '${phoneController.text}'
                        }).then((value) =>
                                toast('Profile updated successfully'));
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return NavigationBarPage(selectedIndex: 0);
                          }),
                        );
                      }
                    },
                    child: CustomRaisedButton(buttonText: 'Save change'),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
