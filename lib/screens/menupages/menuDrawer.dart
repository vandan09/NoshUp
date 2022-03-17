import 'package:flutter/material.dart';
import 'package:noshup_admin/utils/routes.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.menuItemPageRoute);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.food_bank,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Menu',
                      style: TextStyle(color: Colors.redAccent, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.OrderPageRoute);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Order',
                      style: TextStyle(color: Colors.redAccent, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.ProfilePageRoute);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(color: Colors.redAccent, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
