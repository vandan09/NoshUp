import 'dart:developer';
import 'dart:io';

import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/models/cart.dart';

import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/GradientAppBar.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<void> func() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('orders').getDocuments();
    final List<DocumentSnapshot> orderIDS = result.documents;
    return orderIDS.length;
  }

  int counter = 0;

  double sum = 0;
  int itemsCount = 0;

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
  }

  TimeOfDay time;
  String deliveryTime;
  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      deliveryTime = '$hours:$minutes';

      return '$hours:$minutes';
    }
  }

  void toast(String data) {
    Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 5,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          // flexibleSpace: GradientAppBar(),
          backgroundColor: Colors.redAccent,
        ),
        // ignore: unrelated_type_equality_checks
        body: (authNotifier.userDetails.uuid == Null)
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: Text("No Items to display"),
              )
            : cartList(context));
  }

  Widget cartList(context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('carts')
                .document(authNotifier.userDetails.uuid)
                .collection('items')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
              if (snapshot1.hasData && snapshot1.data.documents.length > 0) {
                List<String> foodIds = new List<String>();
                Map<String, int> count = new Map<String, int>();
                snapshot1.data.documents.forEach((item) {
                  foodIds.add(item.documentID);
                  count[item.documentID] = item.data['count'];
                });
                return dataDisplay(
                    context, authNotifier.userDetails.uuid, foodIds, count);
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Text("No Items to display"),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget dataDisplay(BuildContext context, String uid, List<String> foodIds,
      Map<String, int> count) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('items')
          .where(FieldPath.documentId, whereIn: foodIds)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          List<Cart> _cartItems = new List<Cart>();
          snapshot.data.documents.forEach((item) {
            _cartItems.add(Cart(
                item.documentID,
                count[item.documentID],
                item.data['item_name'],
                item.data['total_qty'],
                item.data['price']));
          });
          if (_cartItems.length > 0) {
            sum = 0;
            itemsCount = 0;
            _cartItems.forEach((element) {
              if (element.price != null && element.count != null) {
                sum += element.price * element.count;
                itemsCount += element.count;
              }
            });
            return Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _cartItems.length,
                        itemBuilder: (context, int i) {
                          return ListTile(
                            title: Text(_cartItems[i].itemName ?? ''),
                            subtitle:
                                Text('cost: ${_cartItems[i].price.toString()}'),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  (_cartItems[i].count == null ||
                                          _cartItems[i].count <= 1)
                                      ? IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              foodIds
                                                  .remove(_cartItems[i].itemId);
                                            });
                                            await editCartItem(
                                                _cartItems[i].itemId,
                                                0,
                                                context);
                                          },
                                          icon: new Icon(Icons.delete),
                                        )
                                      : IconButton(
                                          onPressed: () async {
                                            await editCartItem(
                                                _cartItems[i].itemId,
                                                (_cartItems[i].count - 1),
                                                context);
                                          },
                                          icon: new Icon(Icons.remove),
                                        ),
                                  Text(
                                    '${_cartItems[i].count ?? 0}',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  IconButton(
                                    icon: new Icon(Icons.add),
                                    onPressed: () async {
                                      await editCartItem(_cartItems[i].itemId,
                                          (_cartItems[i].count + 1), context);
                                    },
                                  )
                                ]),
                          );
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Select Delivery Time"),
                    SizedBox(
                      height: 10,
                    ),
                    //deltime
                    GestureDetector(
                      child: CustomRaisedButton(buttonText: getText()),
                      onTap: () {
                        pickTime(context);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Total ($itemsCount items): $sum INR"),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (deliveryTime == null) {
                          toast("Select Delivery time");
                        } else {
                          showAlertDialog(
                              context, "Total ($itemsCount items): $sum INR");
                        }
                      },
                      child: CustomRaisedButton(buttonText: 'Proceed to pay'),
                    ),

                    SizedBox(
                      height: 70,
                    ),
                    // GetBuilder<MyController>(
                    //   id: 'txtcount',
                    //   // ignore: missing_return
                    //   builder: (controller) {
                    //     token = '${controller.count}';
                    //   },
                    // ),
                  ],
                ));
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              child: Text("No Items to display"),
            );
          }
        } else {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Text("No Item to display"),
          );
        }
      },
    );
  }

  showAlertDialog(BuildContext context, String data) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    Widget continueButton = FlatButton(
      child: Text("Place Order"),
      onPressed: () {
        Future<void> len = func();
        Firestore.instance
            .collection('token')
            .document(formattedDate)
            .updateData({'tokenNo': FieldValue.increment(1)});
        placeOrder(context, sum, deliveryTime);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Proceed to checkout?"),
      content: Text(data),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //time picker
  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
        context: context,
        initialTime: time ?? initialTime,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget);
        });
    if (newTime == null)
      return;
    else if (newTime.hour > 16 || newTime.hour < 8) {
      toast("Invalid time! Please select time form Univeristy time-range only");
      return;
    } else if (newTime.minute <= TimeOfDay.now().minute + 20 &&
        newTime.hour == TimeOfDay.now().hour) {
      toast("Invalid time! Minimum 20 minutes need to praper the order");
      return;
    }
    setState(() => time = newTime);
  }
}
