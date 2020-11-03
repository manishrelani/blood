import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isHidden = true;
  bool isPass = false;
  bool _check = false;
  String selectedName = "";
  var member = false;
  var isLoading = false;
  String _selectedgroup = "";
  List<String> group = [
    'A+',
    'B+',
    'AB+',
    'O+',
    'OH+',
    'A-',
    'B-',
    'AB-',
    'O-',
    'OH-'
  ];

  static String validNumber = r'(^(?:[+0]9)?[0-9]{10}$)';
  static String validEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  RegExp regValidNumber = new RegExp(validNumber);
  RegExp regEmail = new RegExp(validEmail);
  DateTime selectedDate = DateTime.now();
  final formate = new DateFormat('dd-MM-yyyy');

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dob = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: MediaQuery.of(context).size.width > 800
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        _body(context, size)
                      ],
                    ),
                  )
                : _body(context, size)),
      ],
    );
  }

  Widget _body(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
        ),
        margin: EdgeInsets.only(top: size.height * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _titleText(),
              _subtitle(),
              _textFormField(
                size: size,
                hintText: "Name",
                controller: _nameController,
                icon: Icons.person,
                type: TextInputType.name,
                validator: (value) {
                  if (value.isEmpty || value.trim().isEmpty) {
                    return "Please Enter Your Name";
                  }
                  return null;
                },
              ),
              _textFormField(
                size: size,
                controller: _emailController,
                hintText: "Email ID",
                icon: Icons.email,
                type: TextInputType.name,
                validator: (value) {
                  if (value.isEmpty || value.trim().isEmpty) {
                    return "Please Enter Email id";
                  } else if (!regEmail.hasMatch(value.trim())) {
                    return "Please Enter Valid Email id";
                  }
                  return null;
                },
              ),
              _textFormField(
                size: size,
                controller: _numberController,
                hintText: "Mobile no",
                icon: Icons.phone_android,
                type: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Mobile no";
                  } else if (!regValidNumber.hasMatch(value.toString())) {
                    return "Please Enter Valid Mobile no";
                  }
                  return null;
                },
              ),
              _passTextField(size),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: _textFormField(
                    size: size,
                    controller: _dob,
                    hintText: "Date of birth",
                    icon: Icons.calendar_today,
                    type: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty || value.trim().isEmpty) {
                        return "Please Enter your birth date";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              dropDownMenu(size),
              _addressForm(size),
              _checkBox(),
              signInButton(size),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dob.value = TextEditingValue(text: formate.format(picked));
      });
  }

  Widget dropDownMenu(size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
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
              prefixIcon: Icon(Icons.add_location_outlined)),
          items: group.map((String val) {
            return new DropdownMenuItem<String>(
              value: val,
              child: new Text(val),
            );
          }).toList(),
          hint: Text(
            "Select a Blood group",
            style: TextStyle(color: Colors.grey),
          ),
          onChanged: (newVal) {
            _selectedgroup = newVal;
            this.setState(() {});
          },
          validator: (value) {
            if (value.isEmpty || value.trim().isEmpty) {
              return "Please Enter your blood group";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _titleText() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        "Signup",
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _subtitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        "Welcome Doners! Please Enter All Details to Complate Process",
        //  textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 18),
      ),
    );
  }

  Widget _passTextField(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _isHidden,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
          ),
          suffixIcon: GestureDetector(
            child: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
            onTap: () {
              setState(() {
                _isHidden = !_isHidden;
              });
            },
          ),
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
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Please Enter Password";
          } else if (value.length < 6) {
            return "password should be at least 6 characters long";
          }
          return null;
        },
      ),
    );
  }

  Widget _addressForm(size) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: TextFormField(
          minLines: 3,
          maxLines: 5,
          controller: _addressController,
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 16.0,
              ),
          keyboardType: TextInputType.streetAddress,
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
            hintText: "Your address",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          validator: (value) {
            if (value.isEmpty || value.trim().isEmpty) {
              return "Please enter your address";
            }
            return null;
          },
        ));
  }

  Widget _checkBox() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.all(0),
      title: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'I agree to the ',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            TextSpan(
                text: 'Terms',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                )),
            TextSpan(
                text: ' and ',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            TextSpan(
                text: 'Conditions',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                )),
          ],
        ),
      ),
      value: _check,
      onChanged: (value) {
        setState(() {
          _check = value;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _textFormField(
      {TextEditingController controller,
      Size size,
      String hintText,
      IconData icon,
      TextInputType type,
      Function validator}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 16.0,
                ),
            keyboardType: type,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            validator: validator));
  }

  Widget signInButton(Size size) {
    return Builder(
      builder: (context) => Container(
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
              "Signup",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                //  signup(context);
              }
            }),
      ),
    );
  }

  /*  signup(context) {
    if (member) {
      loadProgress();
      firebase.clgStaff(_userIdController.text.trim()).then((value) {
        loadProgress();
        if (value) {
          print("valid");
          process();
        } else {
          print("not");
          Fluttertoast.showToast(
              msg: "Please Enter Valid ID", textColor: Colors.black);
        }
      });
    } else {
      process();
    }
  } */

  /* process() {
    loadProgress();
    firebase
        .signUp(_emailController.text.trim(), _passwordController.text)
        .then((value) {
      if ("${value.runtimeType}" == "FirebaseUser") {
        FirebaseUser firebaseUser = value;
        if (firebaseUser != null) {
          Map<String, String> data = Map();
          data['name'] = _nameController.text.trim();
          data['email'] = _emailController.text.trim();
          data['mobile'] = _numberController.text.trim();
          data['id'] = _userIdController.text.trim();

          firebase.addUserData(data, firebaseUser).then((value) {
            loadProgress();
            ShareMananer.setDetails(
                _nameController.text.trim(),
                _numberController.text.trim(),
                _emailController.text.trim(),
                _userIdController.text.trim(),
                true,
                "user",
                firebaseUser.uid);
            Timer(Duration(seconds: 1), () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => EmailVerification()),
                  (route) => false);
            });
          });
        }
      } else {
        Fluttertoast.showToast(msg: value.toString(), textColor: Colors.black);
      }
    });
  } */

  loadProgress() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
