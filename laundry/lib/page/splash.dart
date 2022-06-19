import 'package:flutter/material.dart';
import 'package:laundry/home.dart';
import 'package:laundry/page/dashboard.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F2F8),
      body: Center(
        child: Container(
            margin: EdgeInsets.only(right: 25.0, left: 25.0, top: 130.0),
            child: Column(
              children: [
              // SizedBox(
              //   height: 100,
              // ),
              Image.asset(
                "/splashillus.png",
              ),
              SizedBox(
                height: 60,
              ),
              new Text("Get top\nwashing fasilities",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black.withOpacity(1.0),), textAlign: TextAlign.center),
              SizedBox(
                height: 15,
              ),
              new Text("We are a laundry service\nthat serves customers wholeheartedly\nby providing maximum results at affordable prices.",
                  style: TextStyle(fontSize: 12, height: 1.5,fontWeight: FontWeight.w400), textAlign: TextAlign.center),
              SizedBox(
                height: 50,
              ),
               Container(
              height: 70.0,
              width: 70.0,
              child: FittedBox(
                child: FloatingActionButton(
                  child: Icon(Icons.keyboard_arrow_right_outlined, size: 35,),
                  backgroundColor: Color(0xff483DAC),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()))),
              ),
               ),
              
            ])),
      ),
    );
  }
}
