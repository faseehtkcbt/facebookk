import 'package:facebookk/Common/Home.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'LoginPage.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  _load(BuildContext context) async {
    var status = sharedPreference.getBool("log");
    if (status == true) {
      return Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    } else {
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 270,
            width: size.width,
          ),
          Text(
            "facebook",
            style: TextStyle(
                color: Colors.white, fontSize: 38, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 200,
            width: size.width,
          ),
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(
            height: 40,
            width: size.width,
          ),
          Text(
            "from",
            style: TextStyle(
                color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
          ),
          Text(
            "Meta",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400),
          ),
        ],
      )),
    );
  }
}
