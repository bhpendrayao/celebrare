import 'package:flutter/material.dart';
import 'dart:async';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer= Timer(Duration(seconds:2),(){
      setState(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>HomeScreen(),
          )
        );
      });
    });
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/splash.jpg')
        )
      ),
    );
  }
}
