import 'package:BloodDoner/Screens/Login.dart';
import 'package:BloodDoner/Screens/Signup.dart';
import 'package:flutter/material.dart';

class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  int currentPageValue = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            physics: ClampingScrollPhysics(),
            onPageChanged: (int page) {
              getChangedPageAndMoveBar(page);
            },
            children: [
              _screen1(),
              _screen2(),
              _screen3(),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
        ),
        _circle(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        _login(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        _signUp(),
      ],
    );
  }

  Widget _circle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < 3; i++)
          if (i == currentPageValue) ...[circleBar(true)] else circleBar(false),
      ],
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 9,
      width: 9,
      decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(9))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  Widget _screen1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("We Save Lives",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Image.asset(
          "assets/images/donate.png",
          gaplessPlayback: true,
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Connecting doners with recipients",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ))
      ],
    );
  }

  Widget _screen2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Find Doners",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Image.asset(
          "assets/images/map.png",
          gaplessPlayback: true,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        SizedBox(
          height: 10,
        ),
        Text("We match and connect you with nearby doners",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ))
      ],
    );
  }

  Widget _screen3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Select Donation Date",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Image.asset(
          "assets/images/date.png",
          gaplessPlayback: true,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        SizedBox(
          height: 20,
        ),
        Text("Choose any date and location to donate",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ))
      ],
    );
  }

  Widget _login() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: MaterialButton(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.black45)),
        height: 50,
        minWidth: double.infinity,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
        },
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _signUp() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.redAccent,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: MaterialButton(
          shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
          color: Colors.black12,
          height: 50,
          minWidth: double.infinity,
          child: Text(
            "SIGNUP",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => SignupPage()));
          }),
    );
  }
}
