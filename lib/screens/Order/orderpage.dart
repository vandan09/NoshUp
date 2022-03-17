import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noshup_admin/firebase/apis.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  CollectionReference orderRef =
      FirebaseFirestore.instance.collection('orders');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.redAccent),
        elevation: 5,
        title: Text(
          "Order",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 25,
          ),
        ),
        toolbarHeight: 55,
        shadowColor: Colors.grey.shade600,
        backgroundColor: Colors.grey.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .orderBy("placed_at", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<dynamic> orders = snapshot.data!.docs;

                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: const Offset(
                                1.0,
                                0.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 4.0,
                            ),
                          ]),
                      child: Container(
                        child: orderDetailPage(orders[index]),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  orderDetailPage(oid) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        //token--name---time---
        Expanded(
          flex: 7,
          child: Container(
            child: Column(
              children: [
                // token
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Token- "),
                          Text(
                            "${oid['token']}",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      )
                    ]),

                //name
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Student Username- "),
                          Text(
                            "${oid['placed_by']}",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      )
                    ]),

                //del time
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Delivery Time- "),
                          Text(
                            '${oid['delivery_time']}',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Order ID- "),
                          Text(
                            '${oid['orderID']}',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      )
                    ]),
                //----line-----
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Colors.grey.shade500),
                ),
                //---------iteam name and qauntity--------

                SizedBox(
                  height: 10,
                ),
                Container(child: itemDetail(oid))
              ],
            ),
          ),
        ),
        //button
        Expanded(
            flex: 3,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 70,
                    child: RaisedButton(
                      color: oid['is_RedPre'] ? Colors.redAccent : Colors.grey,
                      onPressed: () => {
                        redPreparing_button(oid['orderID'], context),
                      },
                      onLongPress: () => {
                        redReverse_button(oid['orderID'], context),
                      },
                      child: Text(
                        "Prepering",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 78,
                    child: RaisedButton(
                      color: oid['is_OrgReady'] ? Colors.orange : Colors.grey,
                      onPressed: () => {
                        orgReady_button(oid['orderID'], context),
                      },
                      onLongPress: () => {
                        orgReverse_button(oid['orderID'], context),
                      },
                      child: Text(
                        "Ready to take",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 63,
                      child: RaisedButton(
                        color: oid['is_GrnDel'] ? Colors.green : Colors.grey,
                        onPressed: () =>
                            {grnDel_button(oid['orderID'], context)},
                        onLongPress: () => {
                          grnReverse_button(oid['orderID'], context),
                        },
                        child: Text(
                          "Delivered",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      )),
                ]))
      ],
    );
  }

  itemDetail(uid) {
    List items = uid['itemdetails'];
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.only(right: 70, left: 70),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, int i) {
            return Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Text(
                  "${items[i]["item_name"]}",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                    // flex: 2,
                    child: Text(
                  "${items[i]["count"]}",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right,
                ))
              ],
            );
          }),
    );
  }
}
