import 'package:canteen_food_ordering_app/apis/foodAPIs.dart';
import 'package:canteen_food_ordering_app/notifiers/authNotifier.dart';
import 'package:canteen_food_ordering_app/screens/cartPage.dart';
import 'package:canteen_food_ordering_app/screens/homePage.dart';
import 'package:canteen_food_ordering_app/screens/profilePage.dart';
import 'package:canteen_food_ordering_app/screens/wallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NavigationBarPage extends StatefulWidget {
  int selectedIndex;
  NavigationBarPage({@required this.selectedIndex});
  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getUserDetails(authNotifier);
    super.initState();
  }

  int len;
  int currentTab = 0;
  final List<Widget> screen = [
    ProfilePage(),
    HomePage(),
    CartPage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //-----home'0'-----
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = HomePage();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentTab == 0
                                ? Colors.redAccent
                                : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //-----Wallet'1'-----
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = WalletPage();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: currentTab == 1
                                ? Colors.redAccent
                                : Colors.grey,
                          ),
                          Text(
                            'Wallet',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //-----cart'2'-----
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = CartPage();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('carts')
                                .document(authNotifier.userDetails.uuid)
                                .collection('items')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot1) {
                              if (snapshot1.hasData &&
                                  snapshot1.data.documents.length > 0) {
                                List<String> foodIds = new List<String>();
                                Map<String, int> count = new Map<String, int>();
                                snapshot1.data.documents.forEach((item) {
                                  foodIds.add(item.documentID);
                                  count[item.documentID] = item.data['count'];
                                });
                                return Column(
                                  children: [
                                    buildCustomeBadge(
                                      len = snapshot1.data.documents.length,
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: currentTab == 2
                                            ? Colors.redAccent
                                            : Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'Cart',
                                      style: TextStyle(
                                        color: currentTab == 2
                                            ? Colors.redAccent
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: currentTab == 2
                                          ? Colors.redAccent
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'Cart',
                                      style: TextStyle(
                                        color: currentTab == 2
                                            ? Colors.redAccent
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //-----profile'3'-----
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = ProfilePage();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: currentTab == 3
                                ? Colors.redAccent
                                : Colors.grey,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget buildCustomeBadge(
    int i, {
    @required Widget child,
  }) {
    final text = i.toString();
    return Stack(
      children: [
        child,
        Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 6,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ))
      ],
    );
  }
}
