import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';

import 'package:canteen_food_ordering_app/screens/orderDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:provider/provider.dart';

class yourOrderPage extends StatefulWidget {
  const yourOrderPage({Key key}) : super(key: key);

  @override
  _yourOrderPageState createState() => _yourOrderPageState();
}

class _yourOrderPageState extends State<yourOrderPage> {
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your orders"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          Text(
            "Order History",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
          ),
          myOrders(authNotifier.userDetails.uuid),
        ],
      )),
    );
  }

  Widget myOrders(uid) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('orders')
          .where('placed_uid', isEqualTo: uid)
          .orderBy("is_GrnDel")
          .orderBy("placed_at", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          List<dynamic> orders = snapshot.data.documents;
          return Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, int i) {
                  return new GestureDetector(
                    child: Card(
                      child: ListTile(
                          enabled: !orders[i]['is_GrnDel'],
                          title: Text("Order #${(i + 1)}"),
                          subtitle: Text(
                              'Total Amount: ${orders[i]['total'].toString()}   INR'),
                          trailing: Text(
                              'Status: ${orders[i]['is_RedPre'] && orders[i]['is_OrgReady'] && orders[i]['is_GrnDel'] ? "DELIVERED" : orders[i]['is_RedPre'] && orders[i]['is_OrgReady'] ? "READY TO TAKE" : orders[i]['is_RedPre'] ? "PREPARING" : "PENDING"}')),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(orders[i])));
                    },
                  );
                }),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(""),
          );
        }
      },
    );
  }
}
