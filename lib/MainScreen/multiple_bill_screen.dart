import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_material/ticket_material.dart';

import '../Constants/constants.dart';

class BillScreen extends StatefulWidget {
  final scannedBill;
  const BillScreen(this.scannedBill, {Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  void initState() {
    print(widget.scannedBill.toString());
    getPreviousBills();
    super.initState();
  }

  List<String> listOfBills = [];
  getPreviousBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var oldBills = prefs.getStringList("bills");
    if (oldBills != null) {
      listOfBills = oldBills;
      listOfBills.add(widget.scannedBill);
      prefs.setStringList("bills", listOfBills);
    } else {
      listOfBills.add(widget.scannedBill);
      prefs.setStringList("bills", listOfBills);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff966FD6),
        title: const Text('Bill'),
        elevation: 10.0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            for (int i = 0; i < listOfBills.length; i++)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TicketMaterial(
                  height: 50,
                  colorBackground: purpleColor,
                  leftChild: Center(child: Text(widget.scannedBill)),
                  rightChild: Icon(Icons.emoji_food_beverage_rounded),
                ),
              ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TicketMaterial(
                height: 50,
                colorBackground: Colors.white,
                leftChild: Center(child: Text(widget.scannedBill)),
                rightChild: Icon(Icons.emoji_food_beverage_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
