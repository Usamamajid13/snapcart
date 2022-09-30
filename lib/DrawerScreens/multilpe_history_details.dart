import 'package:flutter/material.dart';
import 'package:snapcart/Model/multiple_product_history.dart';

import '../Utils/app_utils.dart';

class MultipleHistoryDetailsScreen extends StatefulWidget {
  var details;
  MultipleHistoryDetailsScreen(this.details, {Key? key}) : super(key: key);

  @override
  State<MultipleHistoryDetailsScreen> createState() =>
      _MultipleHistoryDetailsScreenState();
}

class _MultipleHistoryDetailsScreenState
    extends State<MultipleHistoryDetailsScreen> {
  var utils = AppUtils();
  MultipleProductHistory? multipleProductHistory;
  @override
  void initState() {
    multipleProductHistory = widget.details!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff966FD6),
        title: const Text('Product Details'),
        elevation: 10.0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Type",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      multipleProductHistory!.type.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      multipleProductHistory!.date.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Bread Bill",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      multipleProductHistory!.bread.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Drink Bill",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      multipleProductHistory!.drink.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Eggs Bill",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      multipleProductHistory!.eggs.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Food Deals Bill",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      multipleProductHistory!.meals.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Bill",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      multipleProductHistory!.totalBill.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
