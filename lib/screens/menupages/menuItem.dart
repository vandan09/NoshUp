// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noshup_admin/firebase/apis.dart';

import 'package:noshup_admin/firebase/orderDetails.dart';
import 'package:noshup_admin/helper/formatters.dart';
import 'package:noshup_admin/model/food.dart';
import 'package:noshup_admin/screens/menupages/raiseButton.dart';

import 'package:noshup_admin/utils/routes.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({Key? key}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyEdit = GlobalKey<FormState>();
  OrderDetail orderDetails = OrderDetail();
  List<Food> _foodItems = <Food>[];

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.redAccent),
        title: Text(
          "MENU",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 25,
          ),
        ),
        toolbarHeight: 55,
        elevation: 5,
        shadowColor: Colors.grey.shade600,
        backgroundColor: Colors.grey.shade200,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Container(
              height: 20,
              width: 100,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                shadowColor: Colors.redAccent,
                color: Colors.redAccent,
                elevation: 7,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return popupForm(context);
                        });
                  },
                  child: Center(
                    child: Text(
                      'Add Item',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
          child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 6),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('items').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.length > 0) {
                  _foodItems = <Food>[];
                  snapshot.data!.docs.forEach((item) {
                    _foodItems.add(Food(item.id, item['item_name'],
                        item['total_qty'], item['price']));
                  });
                  List<Food> _suggestionList = (name == '' || name == null)
                      ? _foodItems
                      : _foodItems
                          .where((element) => element.itemName
                              .toLowerCase()
                              .contains(name.toLowerCase()))
                          .toList();
                  if (_suggestionList.length > 0) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.0, left: 5, right: 5),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _suggestionList.length,
                          itemBuilder: (context, int i) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          _suggestionList[i].itemName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Text('Cost: '),
                                          Text(
                                            '${_suggestionList[i].price.toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Text('Total Quantity: '),
                                          Text(
                                            '${_suggestionList[i].totalQty.toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.redAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            fixedSize: Size(80, 35)),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return popupEditForm(context,
                                                    _suggestionList[i]);
                                              });
                                        },
                                        child: Text("Edit")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.redAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            fixedSize: Size(140, 35)),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return popupDeleteOrEmpty(
                                                    context,
                                                    _suggestionList[i]);
                                              });
                                        },
                                        child: Text("Delete/Emprty")),
                                  ]),
                            );
                          }),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text("No Items to display"),
                    );
                  }
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text("No Items to display"),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }

  //add new item
  Widget popupForm(context) {
    String? itemName;
    int? totalQty, price;
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
                  "New Food Item",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //foodname
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Not a valid name";
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [new lowerCaseFormatter()],
                  onSaved: (value) {
                    itemName = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Food Name',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    icon: Icon(
                      Icons.fastfood,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              //price
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length > 3) {
                      return "Not a valid price";
                    } else if (int.tryParse(value) == null) {
                      return "Not a valid integer";
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onSaved: (value) {
                    price = int.parse(value!);
                  },
                  cursorColor: Color.fromRGBO(255, 63, 111, 1),
                  decoration: InputDecoration(
                    labelText: 'Price in INR',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    icon: Icon(
                      Icons.attach_money,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              //Qauntity
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length > 4) {
                      return "QTY cannot be above 4 digits";
                    } else if (int.tryParse(value) == null) {
                      return "Not a valid integer";
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onSaved: (value) {
                    totalQty = int.parse(value!);
                  },
                  decoration: InputDecoration(
                    labelText: 'Total QTY',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addNewItem(itemName!, price!, totalQty!, context);
                    }
                  },
                  child: CustomRaisedButton(buttonText: 'Add Item'),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

//delet empty
  Widget popupDeleteOrEmpty(context, Food data) {
    return AlertDialog(
        content: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  deleteItem(data.id, context);
                },
                child: CustomRaisedButton(buttonText: 'Delete Item'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  editItem(data.itemName, data.price, 0, context, data.id);
                },
                child: CustomRaisedButton(buttonText: 'Empty Item'),
              ),
            ),
          ],
        ),
      ],
    ));
  }

//edit item
  Widget popupEditForm(context, Food data) {
    String itemName = data.itemName;
    int totalQty = data.totalQty, price = data.price;
    return AlertDialog(
        content: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKeyEdit,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Edit Food Item",
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
                  initialValue: itemName,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Not a valid name";
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [new lowerCaseFormatter()],
                  onSaved: (value) {
                    itemName = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Food Name',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    icon: Icon(
                      Icons.fastfood,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: price.toString(),
                  validator: (value) {
                    if (value!.length > 3) {
                      return "Not a valid price";
                    } else if (int.tryParse(value) == null) {
                      return "Not a valid integer";
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onSaved: (value) {
                    price = int.parse(value!);
                  },
                  cursorColor: Color.fromRGBO(255, 63, 111, 1),
                  decoration: InputDecoration(
                    labelText: 'Price in INR',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    icon: Icon(
                      Icons.attach_money,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: totalQty.toString(),
                  validator: (value) {
                    if (value!.length > 4) {
                      return "QTY cannot be above 4 digits";
                    } else if (int.tryParse(value) == null) {
                      return "Not a valid integer";
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onSaved: (value) {
                    totalQty = int.parse(value!);
                  },
                  cursorColor: Color.fromRGBO(255, 63, 111, 1),
                  decoration: InputDecoration(
                    labelText: 'Total QTY',
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Color.fromRGBO(255, 63, 111, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (_formKeyEdit.currentState!.validate()) {
                      _formKeyEdit.currentState!.save();
                      editItem(itemName, price, totalQty, context, data.id);
                    }
                  },
                  child: CustomRaisedButton(buttonText: 'Edit Item'),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
