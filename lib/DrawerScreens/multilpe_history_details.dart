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
                    ),
                    Text(
                      multipleProductHistory!.type.toString(),
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
                    ),
                    Text(
                      multipleProductHistory!.date.toString(),
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
                    ),
                    Text(
                      multipleProductHistory!.bread.toString(),
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
                    ),
                    Text(
                      multipleProductHistory!.drink.toString(),
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
                    ),
                    Text(
                      multipleProductHistory!.eggs.toString(),
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
                    ),
                    Text(
                      multipleProductHistory!.meals.toString(),
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
                    ),
                    Text(
                      multipleProductHistory!.totalBill.toString(),
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
