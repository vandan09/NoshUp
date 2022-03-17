import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    // stops: [
                    //   0.1,
                    //   0.7
                    // ],
                    colors: [
                      Color(0xfff80759),
                      Colors.redAccent,
                    ]),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40)),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(top: 80),
              margin: EdgeInsets.fromLTRB(30, 150, 30, 50),

              height: 500,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(0.0, 0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(40)),
            ),
          ],
        ),
      ),
    );
  }
}
