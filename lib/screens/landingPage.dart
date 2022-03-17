import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/adminHome.dart';
import 'package:canteen_food_ordering_app/screens/login.dart';
import 'package:canteen_food_ordering_app/screens/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:foodlab/api/food_api.dart';
// import 'package:foodlab/screens/login_signup_page.dart';
// import 'package:foodlab/notifier/auth_notifier.dart';
// import 'package:foodlab/screens/navigation_bar.dart';
// import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.redAccent.shade400,
                Colors.redAccent,
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('NoshUp',
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 70,
                  letterSpacing: 1.5,
                  color: Colors.white,
                )),

            // SizedBox(
            //   height: 2,
            // ),
            Text(
              "eat n' chill",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.white70,
              ),
            ),
            Text(
              "IN DHARMSINH DESAI UNIVERSIY",
              style: GoogleFonts.nunito(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.white38,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () {
                (authNotifier.user == null)
                    ? Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }))
                    : (authNotifier.userDetails == null)
                        ? print('wait')
                        // : (authNotifier.userDetails.role == 'admin')
                        //     ? Navigator.pushReplacement(context,
                        //         MaterialPageRoute(
                        //         builder: (BuildContext context) {
                        //           return AdminHomePage();
                        //         },
                        //       ))
                        : Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return NavigationBarPage(selectedIndex: 1);
                            },
                          ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(255, 63, 111, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
