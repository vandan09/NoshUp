import 'package:flutter/material.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({Key key}) : super(key: key);

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  static const ans1 =
      'Yes,we use RazorPay for all transction \n\nRazorpay encrypts all information you share using checkout via TLS (Transport Layer Security).';
  static const ans2 = 'No,currently all our transction are online.';
  static const ans3 =
      'No,You must have to add money in wallet to order the food and as you order the food, the money will directly deduct from your wallet.';
  static const ans4 =
      'Yes,Whenever you login agian with same emailId you get that same balance.';
  static const ans5 =
      'You can select time only form University time limit that is 8AM to 4PM and you have to select delivery time minimum 20 min from current time.';

  static const ans6 =
      'Under the profile you will find out Your Orders section where you get all your order history and under that you can find all details of order along with TOKEN, ORDER ID, and Order STATUS.';
  static const ans7 =
      'In order history as per your current order you can monitor your order processs.';
  static const ans8 = 'No,currently no any way to cancle the order.';
  static const ans9 =
      'You have to take your order from canteen counter by showing TOKEN which will available under the order details.';

  static const ans10 =
      'No but you have to take your order within 30 min later then the delivery time othervise it will not be refundeble.';

  final List<Item> items = [
    Item(header: 'Is it safe to add money in NoshUp Wallet?', body: ans1),
    Item(header: 'Is there COD available?', body: ans2),
    Item(header: 'Can i order without adding money in wallet?', body: ans3),
    Item(
        header: 'Will my wallet money remain as it is if i loggedout?',
        body: ans4),
    Item(header: 'How to select delivery time?', body: ans5),
    Item(header: 'Where can i see my order details?', body: ans6),
    Item(header: 'How can i see my current order process?', body: ans7),
    Item(header: 'Is there any way to cancle the order?', body: ans8),
    Item(header: 'From where i have to take my order?', body: ans9),
    Item(
        header:
            'Is there any problem if i go later then the given delivery time?',
        body: ans9),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),

          // margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: ExpansionPanelList(
            elevation: 2,
            // expandedHeaderPadding: EdgeInsets.symmetric(vertical: 10),
            expansionCallback: (index, isExpanded) {
              setState(() => items[index].isExpanded = !isExpanded);
            },
            children: items
                .map((item) => ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) => ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        title: Text(
                          item.header,
                          style: TextStyle(fontSize: 19, color: Colors.black54),
                        ),
                      ),
                      body: ListTile(
                        title: Text(
                          item.body,
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ),
                      isExpanded: item.isExpanded,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String header;
  final String body;
  bool isExpanded;

  Item({this.header, this.body, this.isExpanded = false});
}
