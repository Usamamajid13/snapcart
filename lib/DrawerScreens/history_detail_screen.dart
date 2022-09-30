import 'package:flutter/material.dart';
import 'package:snapcart/Model/single_product_model.dart';
import '../Utils/app_utils.dart';

class HistoryDetailScreen extends StatefulWidget {
  var details;
  HistoryDetailScreen(this.details, {Key? key}) : super(key: key);

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  var utils = AppUtils();
  SingleProductHistory? singleProductHistory;
  @override
  void initState() {
    singleProductHistory = widget.details!;
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
                      singleProductHistory!.type.toString(),
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
                      singleProductHistory!.date.toString(),
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
                      singleProductHistory!.totalBill.toString(),
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
                      "Product",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      singleProductHistory!.key.toString(),
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
