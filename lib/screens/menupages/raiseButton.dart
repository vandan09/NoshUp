import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String buttonText;

  CustomRaisedButton({required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
