import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/transactionHistory.dart';

import 'package:canteen_food_ordering_app/widgets/customRaisedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final _formKey = GlobalKey<FormState>();
  Razorpay _razorpay;
  int money = 0;
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
    _razorpay = new Razorpay();
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
      elevation: 10,
      primary: Colors.redAccent,
      minimumSize: Size(88, 55),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    );
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    double balance = authNotifier.userDetails.balance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            //white box main
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 10,
                    spreadRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.topCenter,
                  ),
                  //head
                  Text(
                    "NoshUp Wallet",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //------------tagline--------------
                  Text(
                    'Making digital transactions easy\n with one-click checkout',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //red box
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                    // height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        authNotifier.userDetails.balance != null
                            ? Text(
                                "Balance: ${authNotifier.userDetails.balance} INR",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                "Balance: 0 INR",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        //add money
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return popupForm(context);
                                });
                          },
                          child: CustomRaisedButton(buttonText: 'Add Money'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => transactionPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            'Transaction History',
                            style: TextStyle(fontSize: 16),
                          )),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Bottompart1(),
            SizedBox(
              height: 20,
            ),
            Bottompart2(),
            SizedBox(
              height: 10,
            ),

            // authNotifier.userDetails.balance>balance
          ],
        ),
      ),
    );
  }

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
                    color: Colors.redAccent,
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
                  onSaved: (String value) {
                    amount = int.parse(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Money in INR',
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
      'key': 'rzp_test_tov6t9QpG7niqa',
      'amount': num.parse(money.toString()) * 100,
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

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    DateTime now = DateTime.now();
    String formattedDate1 = DateFormat('kk:mm:ss').format(now);
    String formattedDate2 = DateFormat('dd MMM yy').format(now);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    addMoney(money, context, authNotifier.userDetails.uuid);
    DocumentReference razorPayRef =
        Firestore.instance.collection('RazorPay').document();

    await razorPayRef
        .setData({
          'money': money,
          'userID': authNotifier.userDetails.uuid,
          'paymentID': response.paymentId,
          'collectionID': razorPayRef.documentID,
          'time': formattedDate1,
          'date': formattedDate2,
        })
        .then((value) => toast('Creted response'))
        .catchError(() {
          toast('Error');
        });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toast("ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toast("EXTERNAL_WALLET: " + response.walletName);
    Navigator.pop(context);
  }

  Bottompart1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              spreadRadius: 10,
            )
          ],
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                //-----------wallet image------------
                Row(
                  children: [
                    Container(
                      //padding: EdgeInsets.all(0), // Border width
                      decoration: BoxDecoration(
                        //color: Colors.indigo.shade100,
                        shape: BoxShape.circle,
                      ),

                      child: ClipOval(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            'images/OneClick.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "One-click checkout",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "No need to wait for OTPs-payment\nget processed instantly",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Bottompart2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 10,
                spreadRadius: 10,
              )
            ]),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                //-----------secure image------------
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: SizedBox(
                          height: 50,
                          width: 50, // Image radius
                          child: Image.asset(
                            'images/Safeicon.jpg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "Safe and secure",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Stay protected with bank-grade security\nwhile making payments",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
