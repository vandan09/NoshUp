import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class transactionPage extends StatefulWidget {
  const transactionPage({Key key}) : super(key: key);

  @override
  State<transactionPage> createState() => _transactionPageState();
}

class _transactionPageState extends State<transactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transaction History"),
          backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('RazorPay').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data.documents.length > 0) {
                    // List<dynamic> details = snapshot.data.documents;
                    final docs = snapshot.data.documents;
                    return Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: docs.length,
                          itemBuilder: (context, int i) {
                            final data = docs[i].data;
                            return new GestureDetector(
                              child: Card(
                                child: ListTile(
                                  // enabled: !orders[i]['is_GrnDel'],
                                  title: Text(
                                    "${data['money']}.00 INR",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "${data['paymentID']}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  trailing: Text(
                                    "${data['date']}, ${data['time']}",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        // width: MediaQuery.of(context).size.width,
                        child: Text("No transaction done yet"),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
