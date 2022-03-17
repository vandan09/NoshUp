import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:noshup_admin/screens/Registration/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateTohome();
  }

  _navigateTohome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminLoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Gradient[Colors],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.redAccent.shade400,
                Colors.redAccent,
              ]),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            )
          ],
        ),
      ),
    );
  }
}
