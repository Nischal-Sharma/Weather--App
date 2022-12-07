import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/screen/homepage.dart';
import 'components/Utils.dart' as Utils;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 15), () {
      Navigator.of(context).push(Utils.createRoute(Homepage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.97,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://www.vhv.rs/dpng/d/427-4270068_gold-retro-decorative-frame-png-free-download-transparent.png"),
                    fit: BoxFit.contain)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "We show weather for you",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    child: const Icon(Icons.skip_next),
                    onTap: () {
                      Navigator.of(context).push(Utils.createRoute(Homepage()));
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
