// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cupertino_page_controller/cupertino_page_controller.dart';
import 'package:example/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;
  Timer? _timer;
  bool isSelect = false;
  final CarouselController _carouselController = CarouselController();
  int length = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                "assets/test.jpg",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: length,
                      itemBuilder: (context, index, current) {
                        return Text(
                          index.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 200),
                        );
                      },
                      options: CarouselOptions(
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          HapticFeedback.heavyImpact();
                          setState(() {
                            current = index;
                            isSelect = true;
                            _timer?.cancel();
                            _timer =
                                Timer(const Duration(milliseconds: 1500), () {
                              setState(() {
                                isSelect = false;
                              });
                            });
                          });
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.only(bottom: 70),
                  child: CupertinoPageControl(
                    length: length,
                    current: current,
                    name: "Search",
                    isSelect: isSelect,
                    timer: _timer,
                    icon: CupertinoIcons.search,
                    function: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                    brightness: Brightness.dark,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
