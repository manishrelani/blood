import 'package:BloodDoner/Screens/Signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  var isHidden = false;

  static RegExp validEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(size),
    );
  }

  Widget _body(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.01),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  Image.asset("assets/images/admin.png"),
            _emailField(size),
            _passwordTextField(size),
            loginButton(size),
            _textDetails(
                first: "Forgot your login Details? ",
                sec: "Click here",
                route: () {}),
            centerLine(),
            _textDetails(
                first: "Don't have Account? ",
                sec: "Signup",
                route: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => SignupPage()));
                }),
          ],
        ),
      ),
    );
  }

  Widget centerLine() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                height: 1,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                )),
          ),
          Text("  OR  "),
          Expanded(
            child: Container(
                height: 1,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                )),
          ),
        ],
      ),
    );
  }

  Widget _emailField(Size size) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: "Email id",
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value.trim().isEmpty) {
            return "Please Enter Email Address";
          } else if (!validEmail.hasMatch(value.trim())) {
            return "Please Enter Valid Email Address";
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordTextField(Size size) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: TextFormField(
        obscureText: isHidden,
        controller: _passController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey),
            suffix: GestureDetector(
              child: Icon(
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onTap: () {
                setState(() {
                  isHidden = !isHidden;
                });
              },
            )),
        validator: (value) {
          if (value.isEmpty || value.trim().isEmpty) {
            return "Please Enter password";
          }
          return null;
        },
      ),
    );
  }

  Widget loginButton(Size size) {
    return Builder(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent,
        ),
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: MaterialButton(
            shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8)),
            color: Colors.black12,
            height: 50,
            minWidth: double.infinity,
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              // login(context);
            }),
      );
    });
  }

  Widget _textDetails({String first, String sec, Function route}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          first,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        GestureDetector(
          child: Text(
            sec,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontSize: 16.0, fontWeight: FontWeight.w700),
          ),
          onTap: route,
        )
      ],
    );
  }
}
