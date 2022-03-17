import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noshup_admin/model/auth.dart';
import 'package:noshup_admin/model/user.dart';
// import 'package:noshup_admin/model/auth.dart';

import 'package:noshup_admin/screens/Registration/login.dart';

void toast(String data) {
  Fluttertoast.showToast(
      msg: data,
      timeInSecForIosWeb: 5,
      webBgColor: "linear-gradient(to right, #530084, #ff5252)");
}

addNewItem(
    String itemName, int price, int totalQty, BuildContext context) async {
  // pr = new ProgressDialog(context,
  //     type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  // pr.show();
  try {
    CollectionReference itemRef =
        FirebaseFirestore.instance.collection('items');
    await itemRef
        .doc()
        .set({"item_name": itemName, "price": price, "total_qty": totalQty})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    // pr.hide().then((isHidden) {
    //   print(isHidden);
    // });
    toast("Failed to add to new item!");
    print(error);
    return;
  }
  // pr.hide().then((isHidden) {
  //   print(isHidden);
  // });
  Navigator.pop(context);
  toast("New Item added successfully!");
}

deleteItem(String id, BuildContext context) async {
  try {
    CollectionReference itemRef =
        FirebaseFirestore.instance.collection('items');
    await itemRef
        .doc(id)
        .delete()
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    // pr.hide().then((isHidden) {
    //   print(isHidden);
    // });
    toast("Failed to edit item!");
    print(error);
    return;
  }
  // pr.hide().then((isHidden) {
  //   print(isHidden);
  // });
  Navigator.pop(context);
  toast("Item edited successfully!");
}

editItem(String itemName, int price, int totalQty, BuildContext context,
    String id) async {
  // pr = new ProgressDialog(context,
  //     type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  // pr.show();
  try {
    CollectionReference itemRef =
        FirebaseFirestore.instance.collection('items');
    await itemRef
        .doc(id)
        .set({"item_name": itemName, "price": price, "total_qty": totalQty})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    // pr.hide().then((isHidden) {
    //   print(isHidden);
    // });
    toast("Failed to edit item!");
    print(error);
    return;
  }
  // pr.hide().then((isHidden) {
  //   print(isHidden);
  // });
  Navigator.pop(context);
  toast("Item edited successfully!");
}

signOut(AuthNotifier authNotifier, BuildContext context) async {
  await FirebaseAuth.instance.signOut();

  authNotifier.setUser;
  // ignore: avoid_print
  print('log out');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (BuildContext context) {
      return const AdminLoginPage();
    }),
  );
}

//red
redPreparing_button(String id, BuildContext context) async {
  try {
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('orders');

    await ordersRef
        .doc(id)
        .update({'is_RedPre': true})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    toast("Failed to mark as received!");
    print(error);
    return;
  }
  toast("Messege sent successfully fot PREPARING!");
}

//Red Reverse
redReverse_button(String id, BuildContext context) async {
  try {
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('orders');

    await ordersRef
        .doc(id)
        .update({'is_RedPre': false})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    toast("Failed to mark as received!");
    print(error);
    return;
  }
  toast("Change it to FALSE!");
}

//org
orgReady_button(String id, BuildContext context) async {
  try {
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('orders');

    await ordersRef
        .doc(id)
        .update({'is_OrgReady': true})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    toast("Failed to mark as received!");
    print(error);
    return;
  }
  toast("Messege sent successfully for READY TO TAKE!");
}

//orange reverse
orgReverse_button(String id, BuildContext context) async {
  try {
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('orders');

    await ordersRef
        .doc(id)
        .update({'is_OrgReady': false})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    toast("Failed to mark as received!");
    print(error);
    return;
  }
  toast("Change it to FALSE!");
}

//green
grnDel_button(String id, BuildContext context) async {
  try {
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('orders');

    await ordersRef
        .doc(id)
        .update({'is_GrnDel': true})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    toast("Failed to mark as received!");
    print(error);
    return;
  }
  toast("Messege sent successfully DELIVERED!");
}

//green reverse
grnReverse_button(String id, BuildContext context) async {
  try {
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('orders');

    await ordersRef
        .doc(id)
        .update({'is_GrnDel': false})
        .catchError((e) => print(e))
        .then((value) => print("Success"));
  } catch (error) {
    toast("Failed to mark as received!");
    print(error);
    return;
  }
  toast("Change it to FALSE!");
}
