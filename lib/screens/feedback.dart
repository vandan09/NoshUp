import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/GradientAppBar.dart';
import 'package:canteen_food_ordering_app/screens/navigationBar.dart';
import 'package:canteen_food_ordering_app/screens/profilePage.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

final messageController = TextEditingController();

// Future sendEmail() async {
//   final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
//   const serviceId = "service_q4njuul";
//   const templateId = "template_edu1owh  ";
//   const userId = "user_hse8Od4KVGajxeZZvRz8u";

//   final response = await http.post(url, headers: {
//     'origin': 'http://localhost',
//     'Content-Type': 'application/json'
//   }, body: {
//     "service_id": serviceId,
//     "stemplate_id": templateId,
//     "user_id": userId,
//     "template_params": {
//       "name": nameController.text,
//       "user_email": emailController.text,
//       "subject": subjectController.text,
//       "messsage": messageController.text,
//     }
//   });
//   toast('${response.statusCode}');
// }

class _FeedBackPageState extends State<FeedBackPage> {
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   messageController.clear();
  //   super.cle();
  // }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Colors.redAccent,

        // backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
              child: Column(
            children: [
              Text(
                "Tell us what you love about the app, or what we could be doing better.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  icon: Icon(Icons.feedback),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  labelText: 'Enter feedback',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> data = {
                    "message": messageController.text,
                    "user_name": authNotifier.userDetails.displayName,
                    "useer_email": authNotifier.userDetails.email,
                  };
                  Firestore.instance
                      .collection("feedback")
                      .add(data)
                      .then((value) => toast(
                            'Thank you for seeding us feedback',
                          ));
                  messageController.clear();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return NavigationBarPage(selectedIndex: 3);
                    }),
                  );
                },
                child: CustomRaisedButton(buttonText: 'Send'),
              )
            ],
          )),
        ),
      ),
    );
  }
}
