import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class aboutUsPage extends StatefulWidget {
  const aboutUsPage({Key key}) : super(key: key);

  @override
  State<aboutUsPage> createState() => _aboutUsPageState();
}

class _aboutUsPageState extends State<aboutUsPage> {
  static const ourstrory =
      "We are in the 3rd year and it's time for the final year project so many of us were  facing the problem of waiting in a line during the break hours in the canteen. So we came across the solution <bold>NushUp</bold> an App, where You can order your food and get in within your convenient time period.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'OUR STORY',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            new RichText(
              textAlign: TextAlign.center,
              text: new TextSpan(
                text:
                    "We are in the 3rd year and it's time for the final year project so many of us were  facing the problem of waiting in a line during the break hours in the canteen. So we came across the solution ",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'NoshUp ',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                      text:
                          "an App, where You can order your food and get in within your convenient time period. "),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text('OUR GOAL IS TO PROVIDE YOU DELICIOUS FOOD AT YOUR TIME!',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Colors.black54),
                textAlign: TextAlign.center),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () async {
                  launch('mailto:vandan8154@gmail.com');
                  // final tomail = 'vandan8154@gmail.com';
                  // final subject = 'report';
                  // final message = 'hi';
                  // final url = 'mailto:$tomail?subject=$subject?body=$message';
                  // if (await canLaunch(url)) {
                  //   await launch(url);
                  // }
                },
                child: Text('Contact us',
                    style: TextStyle(
                        // fontFamily: 'motserrat',
                        color: Colors.black,
                        fontSize: 16)),
              ),
            ),
            //--------Rate Us--------
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: InkWell(
                onTap: () {},
                child: Text('Policy',
                    style: TextStyle(
                        // fontFamily: 'motserrat',
                        color: Colors.black,
                        fontSize: 16)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
