import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  dynamic orderdata;

  OrderDetailsPage(this.orderdata);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = widget.orderdata['itemdetails'];

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, right: 10),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //titel
            Text(
              "Order Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //order id
            Text(
              'Order ID: ${widget.orderdata['orderID']}',
            ),
            SizedBox(
              height: 30,
            ),
            //token number
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Token: ',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    '${widget.orderdata['token']}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //item qauntity and price
            ListView.builder(
                padding: EdgeInsets.only(left: 20, right: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, int i) {
                  return new ListTile(
                    title: Text(
                      "${items[i]["item_name"]}",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("Quantity: ${items[i]["count"]}"),
                    trailing: Text(
                        "Price: ${items[i]["count"]} * ${items[i]["price"]} = ${items[i]["price"] * items[i]["count"]} INR"),
                  );
                }),
            SizedBox(
              height: 30,
            ),
            //total amount
            Text(
              "Total Amount: ${widget.orderdata['total'].toString()} INR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //del time
            Text(
              "Delivery Time: ${widget.orderdata['delivery_time']} ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //monitor status
            Container(
              child: StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('orders')
                    .document(widget.orderdata.documentID)
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot,
                ) {
                  var datas = snapshot.data;
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Text(
                          '${datas['is_RedPre'] && datas['is_OrgReady'] && datas['is_GrnDel'] ? "DELIVERED" : datas['is_RedPre'] && datas['is_OrgReady'] ? "READY TO TAKE" : datas['is_RedPre'] ? "PREPARING" : "PENDING"}',
                          style:
                              TextStyle(fontSize: 20, color: Colors.redAccent),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 20,
            ),
            // (!widget.orderdata['is_RedPre'])
            //     ? GestureDetector(
            //         onTap: () {
            //           // orderReceived(widget.orderdata.documentID, context);
            //           print(widget.orderdata.documentID);
            //         },
            //         child: CustomRaisedButton(buttonText: 'Received'),
            //       )
            //     : Text(""),
          ],
        ),
      ),
    );
  }
}
