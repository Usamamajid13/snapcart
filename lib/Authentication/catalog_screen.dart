import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../Utils/app_utils.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  var _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  CarouselController crouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.60,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                CarouselSlider(
                  carouselController: crouselController,
                  options: CarouselOptions(
                      initialPage: 0,
                      reverse: false,
                      disableCenter: true,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(
                          imgUrl,
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _current == 0
                                ? "No Scanners!"
                                : _current == 1
                                    ? "Track Expenses"
                                    : _current == 2
                                        ? "Use Mobile"
                                        : _current == 3
                                            ? "Save Time"
                                            : "Reach Goals",
                            style: AppUtils()
                                .largeHeadingTextStyle(color: purpleColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _current == 0
                                ? "No need to carry those big scanners \nwith you all the time."
                                : _current == 1
                                    ? "Track all your expenses you spend on \ndifferent items you use in your daily life."
                                    : _current == 2
                                        ? "Use your mobile phone to scan everything \nthat you purchase and keep record of \nit in our app."
                                        : _current == 3
                                            ? "Save time by scanning qr codes through your \n mobile anytime and anywhere in the world."
                                            : "Reach your end goals by managing your expenses. \nWe are here to make your life much easier.",
                            style: AppUtils()
                                .mediumTitleTextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(imgList, (index, url) {
                          return Container(
                            width: _current == index ? 25.0 : 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _current == index
                                  ? purpleColor
                                  : Colors.white,
                            ),
                          );
                        }),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_current < 4) {
                            crouselController.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease);
                          } else {
                            Navigator.pushNamed(context, loginScreenRoute);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: purpleColor,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

final List<String> imgList = [
  'assets/barcode-scanner.png',
  'assets/trackExpenses.png',
  'assets/phone.png',
  'assets/stopwatch.png',
  'assets/goals.png',
];
