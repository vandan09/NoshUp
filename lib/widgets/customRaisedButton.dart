import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String buttonText;

  CustomRaisedButton({@required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      decoration: BoxDecoration(
        // gradient:
        //     LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight,
        //
        //         colors: [
        //       Colors.redAccent.shade400,
        //       Colors.redAccent,
        //     ]),
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 15
            // fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
