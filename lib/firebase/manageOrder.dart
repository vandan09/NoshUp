import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noshup_admin/firebase/orderDetails.dart';
import 'package:noshup_admin/screens/menupages/menuItem.dart';

class manageOrder {
  void insertdata(
      String itemNames, String prices, String quntitys, context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OrderDetail orderDetails = OrderDetail();
    orderDetails.item_name = itemNames;
    orderDetails.price = prices;
    orderDetails.total_qty = quntitys;

    try {
      await firebaseFirestore
          .collection('items/')
          .doc()
          .set(orderDetails.toMap());

      Fluttertoast.showToast(
          msg: "Item updated successfully :) ",
          timeInSecForIosWeb: 5,
          webBgColor: "linear-gradient(to right, #530084, #ff5252)");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => MenuItem()),
          (route) => false);
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Error! $e',
          timeInSecForIosWeb: 5,
          webBgColor: "linear-gradient(to right, #530084, #ff5252)");
    }
  }

  void updateData(
      String itemNames, String prices, String quntitys, context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OrderDetail orderDetails = OrderDetail();
    orderDetails.item_name = itemNames;
    orderDetails.price = prices;
    orderDetails.total_qty = quntitys;

    try {
      await firebaseFirestore
          .collection('items/')
          .doc()
          .update(orderDetails.toMap());

      Fluttertoast.showToast(
          msg: "Item updated successfully :) ",
          timeInSecForIosWeb: 5,
          webBgColor: "linear-gradient(to right, #530084, #ff5252)");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => MenuItem()),
          (route) => false);
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Error! $e',
          timeInSecForIosWeb: 5,
          webBgColor: "linear-gradient(to right, #530084, #ff5252)");
    }
  }
}
