import 'dart:async';

import 'package:bmi_calculator/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=> MyHomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text("BMI Calculator",style: TextStyle(fontSize: 34,
          fontWeight: FontWeight.w700,
          color: Colors.white
          )),
        ),
      ),
    );
  }
}
