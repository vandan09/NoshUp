import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noshup_admin/firebase/adminData.dart';
import 'package:noshup_admin/firebase/apis.dart';
import 'package:noshup_admin/helper/responsive.dart';
import 'package:noshup_admin/screens/menupages/menuDrawer.dart';
import 'package:noshup_admin/screens/menupages/top_appBar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int total = 0;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();

    FirebaseFirestore.instance
        .collection("admin")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInAdmin = AdminModel.fromMap(value.data());
      setState(() {});
    });
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  AdminModel loggedInAdmin = AdminModel();

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              iconTheme: IconThemeData(color: Colors.redAccent),
              toolbarHeight: 67,
              backgroundColor: Colors.grey.shade200,
              shadowColor: Colors.grey,
              elevation: 10,
              centerTitle: true,
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 70),
              child: TopBarContents()),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child: Center(
            child: Container(
              // height: MediaQuery.of(context).size.height - 100  ,
              // decoration: BoxDecoration(
              //   color: Colors.redAccent.withOpacity(0.1),
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(10),
              //   ),
              // ),
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //welcome name
                      Text(
                        "Welcom ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${loggedInAdmin.uname}",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "!",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 110,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //total order
                      Container(
                        height: 150,
                        width: 180,
                        // padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                        decoration: BoxDecoration(
                            color: Color(0XFFFBD8D8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(5.0, 10),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Total order',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('token')
                                    .doc('${formattedDate}')
                                    .snapshots(),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot,
                                ) {
                                  var datas = snapshot.data;
                                  if (snapshot.hasData) {
                                    return Text(
                                      '${datas!['tokenNo']}',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.redAccent),
                                    );
                                  } else {
                                    return Text(
                                      "Reset Token for Today.",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.redAccent),
                                    );
                                  }
                                }),
                            SizedBox(
                              height: 25,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: 180,
                                child: Text(
                                  '${formattedDate}',
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      //earing
                      Container(
                        height: 150,
                        width: 180,
                        // padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                        decoration: BoxDecoration(
                            color: Color(0XFFFBD8D8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(5.0, 10),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Total earning',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('orders')
                                  .where('todayDate', isEqualTo: formattedDate)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.docs.length > 0) {
                                  List<dynamic> orders = snapshot.data!.docs;
                                  total = 0;
                                  for (int ind = 0;
                                      ind < orders.length;
                                      ind++) {
                                    total =
                                        total + (orders[ind]['total']) as int;
                                  }
                                  return Container(
                                    // margin: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      '${total}.00',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.redAccent),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.redAccent),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: 180,
                                child: Text(
                                  '${formattedDate}',
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      //total user
                      Container(
                        height: 150,
                        width: 180,
                        // padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                        decoration: BoxDecoration(
                            color: Color(0XFFFBD8D8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(5.0, 10),
                                blurRadius: 15.0,
                                spreadRadius: 0.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Total users',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.docs.length > 0) {
                                  List<dynamic> orders = snapshot.data!.docs;
                                  // total = 0;
                                  // for (int ind = 0;
                                  //     ind < orders.length;
                                  //     ind++) {
                                  //   total =
                                  //       total + (orders[ind]['total']) as int;
                                  // }
                                  return Text(
                                    '${orders.length}',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.redAccent),
                                  );
                                } else {
                                  return Container(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.redAccent),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //dark date container
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: 180,
                                child: Text(
                                  'Till ${formattedDate}',
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  //reset button

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        minimumSize: Size(120, 50),
                      ),
                      onPressed: () {
                        var now = new DateTime.now();
                        var formatter = new DateFormat('dd-MM-yyyy');
                        String formattedDate = formatter.format(now);
                        FirebaseFirestore.instance
                            .collection('token')
                            .doc('${formattedDate}')
                            .set({'tokenNo': 0, 'date': formattedDate}).then(
                                (value) => toast('Reset to token 0'));
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
