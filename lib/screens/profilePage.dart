import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/models/myController.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/FAQs.dart';
import 'package:canteen_food_ordering_app/screens/aboutUs.dart';

import 'package:canteen_food_ordering_app/screens/editProfile.dart';
import 'package:canteen_food_ordering_app/screens/feedback.dart';

import 'package:canteen_food_ordering_app/screens/yourOrderPage.dart';
import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_redirect/store_redirect.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  Razorpay _razorpay;
  int money = 0;

  signOutUser() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (authNotifier.user != null) {
      signOut(authNotifier, context);
    }
  }

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      //onPrimary: Colors.black87,
      primary: Colors.redAccent,
      minimumSize: Size(88, 55),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    );
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              signOutUser();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30, right: 10),
                ),
              ],
            ),
            //icon
            Container(
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              width: 100,
              child: Icon(
                Icons.person,
                size: 70,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //name
            authNotifier.userDetails.displayName != null
                ? Text(
                    authNotifier.userDetails.displayName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text("You don't have a user name"),
            SizedBox(
              height: 10,
            ),
            //email
            authNotifier.userDetails.email != null
                ? Text(
                    authNotifier.userDetails.email,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text("You don't have a email adress"),
            SizedBox(
              height: 10,
            ),
            //phone
            authNotifier.userDetails.phone != null
                ? Text(
                    authNotifier.userDetails.phone,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text("You don't have a phone number"),

            // authNotifier.userDetails.balance != null
            //     ? Text(
            //         "Balance: ${authNotifier.userDetails.balance} INR",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 20,
            //         ),
            //       )
            //     : Text(
            //         "Balance: 0 INR",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 20,
            //         ),
            //       ),
            // SizedBox(
            //   height: 20,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     showDialog(
            //         context: context,
            //         barrierDismissible: false,
            //         builder: (BuildContext context) {
            //           return popupForm(context);
            //         });
            //   },
            //   child: CustomRaisedButton(buttonText: 'Add Money'),
            // ),
            // SizedBox(
            //   height: 30,
            // ),

            // Text(
            //   "Order History",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 20,
            //   ),
            //   textAlign: TextAlign.left,
            // ),
            // myOrders(authNotifier.userDetails.uuid),
            //-------------line---------------
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
              child: CustomRaisedButton(buttonText: 'Edit'),
            ),

            SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.black,
                  height: 30,
                )),

            //-------buttons----------
            //-----------Your orders--------------
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => yourOrderPage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.check_box_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text('Your Orders')),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            //-----------Payment and Refunds--------------

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: ElevatedButton(
            //     style: raisedButtonStyle,
            //     onPressed: () {},
            //     child: Row(
            //       children: [
            //         Icon(Icons.payment_sharp),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Expanded(child: Text('Payment and Refunds')),
            //         Icon(Icons.arrow_forward_ios)
            //       ],
            //     ),
            //   ),
            // ),
            //-----------Help--------------

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQsPage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.question_answer),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text('FAQs')),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            //-----------About--------------

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => aboutUsPage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text('About')),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),

            //------------line---------

            Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.black,
                  height: 30,
                )),

            //--------send feedback--------

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedBackPage()));
                },
                child: Text('Send Feedback',
                    style: TextStyle(
                        // fontFamily: 'motserrat',
                        color: Colors.black)),
              ),
            ),
            //--------Rate Us--------
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  StoreRedirect.redirect(
                      androidAppId: 'com.example.canteen_food_ordering_apps');
                },
                child: Text('Rate us on the play store',
                    style: TextStyle(
                        // fontFamily: 'motserrat',
                        color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget myOrders(uid) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance
  //         .collection('orders')
  //         .where('placed_by', isEqualTo: uid)
  //         .orderBy("is_delivered")
  //         .orderBy("placed_at", descending: true)
  //         .snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasData && snapshot.data.documents.length > 0) {
  //         List<dynamic> orders = snapshot.data.documents;
  //         return Container(
  //           margin: EdgeInsets.only(top: 10.0),
  //           child: ListView.builder(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: orders.length,
  //               itemBuilder: (context, int i) {
  //                 return new GestureDetector(
  //                   child: Card(
  //                     child: ListTile(
  //                         enabled: !orders[i]['is_delivered'],
  //                         title: Text("Order #${(i + 1)}"),
  //                         subtitle: Text(
  //                             'Total Amount: ${orders[i]['total'].toString()} INR'),
  //                         trailing: Text(
  //                             'Status: ${(orders[i]['is_delivered']) ? "Delivered" : "Pending"}')),
  //                   ),
  //                   onTap: () {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) =>
  //                                 OrderDetailsPage(orders[i])));
  //                   },
  //                 );
  //               }),
  //         );
  //       } else {
  //         return Container(
  //           padding: EdgeInsets.symmetric(vertical: 20),
  //           width: MediaQuery.of(context).size.width * 0.6,
  //           child: Text(""),
  //         );
  //       }
  //     },
  //   );
  // }

  Widget popupForm(context) {
    int amount = 0;
    return AlertDialog(
        content: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Deposit Money",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 63, 111, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String value) {
                    if (int.tryParse(value) == null)
                      return "Not a valid integer";
                    else if (int.parse(value) < 100)
                      return "Minimum Deposit is 100 INR";
                    else if (int.parse(value) > 1000)
                      return "Maximum Deposit is 1000 INR";
                    else
                      return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  onSaved: (String value) {
                    amount = int.parse(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Money in INR',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                    icon: Icon(
                      Icons.attach_money,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      return openCheckout(amount);
                    }
                  },
                  child: CustomRaisedButton(buttonText: 'Add Money'),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  void openCheckout(int amount) async {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    money = amount;
    var options = {
      'key': 'rzp_test_FhtmOGla17FHTz',
      'amount': money * 100,
      'name': authNotifier.userDetails.displayName,
      'description': "${authNotifier.userDetails.uuid} - ${DateTime.now()}",
      'prefill': {
        'contact': authNotifier.userDetails.phone,
        'email': authNotifier.userDetails.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void toast(String data) {
    Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    addMoney(money, context, authNotifier.userDetails.uuid);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toast("ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toast("EXTERNAL_WALLET: " + response.walletName);
    Navigator.pop(context);
  }
}
