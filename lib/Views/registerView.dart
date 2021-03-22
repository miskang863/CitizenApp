import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterView> {
  // register details
  var login = "";
  var password = "";
  var email = "";

  // Validation bools
  bool strongPassword;
  bool correctEmail;
  bool correctUsername;
  bool passwordMatch;
  bool validatorVisibility;

  // Bool for enabling/disabling register button
  bool _enabled;

  // controllers
  final TextEditingController controller = new TextEditingController();
  final _controller = ScrollController();

  // inits
  @override
  void initState() {
    _enabled = false;
    strongPassword = false;
    correctEmail = false;
    correctUsername = false;
    passwordMatch = false;
    validatorVisibility = false;
    super.initState();
  }

  // Change visibility of password validator
  void _changeVisibility(bool visibility) {
    setState(() {
      validatorVisibility = visibility;
    });
  }

  // Enable / disable register button
  void _buttonEnabler() {

    if (strongPassword &&
        correctEmail &&
        correctUsername &&
        passwordMatch) {
      setState(() {
        _enabled = true;
      });
    } else {
      setState(() {
        _enabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Onpress register button
    var _onPressed;
    if (_enabled) {
      _onPressed = () {
        print("Register button pressed");
      };
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueAccent, Colors.white]),
        ),
        child: ListView(
          controller: _controller,
          children: <Widget>[
            // USERNAME
            Column(
              children: <Widget>[
                Row(children: <Widget>[]),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {

                        if (val.isEmpty) {
                          return "Enter username";
                        } else if (val.length < 3) {
                          return "Minimum three symbols";
                        } else if(val.length > 20){
                          return "Too long";
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9.]')),
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      ],
                      onChanged: (val) {
                        login = val;
                        if (login.length >= 3) {
                          correctUsername = true;
                        } else {
                          correctUsername = false;
                        }
                        _buttonEnabler();
                      },
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      obscureText: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Login',
                        icon: Image.asset(
                          'Assets/Icons/userIcon.png',
                          height: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                // EMAIL
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        bool isValid = EmailValidator.validate(val);
                        if (!isValid) {
                          return "Not valid email";
                        } else {
                          correctEmail = true;
                        }
                        return null;
                      },
                      onChanged: (val){
                        if (correctEmail){
                          email = val;
                        }
                      },
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        icon: Image.asset(
                          'Assets/Icons/email_icon.png',
                          height: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  // PASSWORD 1
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                               Column(
                            children: [
                              TextField(
                                onTap: () {
                                  _changeVisibility(true);
                                  print("visibility");
                                },
                                controller: controller,
                                onChanged: (val) {
                                  password = val;

                                },
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  icon: Image.asset(
                                    'Assets/Icons/passwordIcon.png',
                                    height: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: validatorVisibility,
                                child: FlutterPwValidator(
                                  controller: controller,
                                  minLength: 8,
                                  uppercaseCharCount: 2,
                                  numericCharCount: 3,
                                  specialCharCount: 1,
                                  width: 400,
                                  height: 130,
                                  defaultColor: Colors.transparent,
                                  onSuccess: () {
                                    _controller.jumpTo(
                                        _controller.position.maxScrollExtent);
                                    strongPassword = true;
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
                // PASSWORD 2
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: () {
                        _controller.jumpTo(
                            _controller.position.maxScrollExtent);
                        print("tapped ");
                      },
                      validator: (val){

                        if (val == password) {
                          passwordMatch = true;

                        } else {
                          return "Passwords are not matching";
                        }
                        return null;
                      },
                      onChanged: (val) {

                        if (val == password) {
                          passwordMatch = true;
                        }
                        else {
                          passwordMatch = false;
                        }
                        _buttonEnabler();
                      },
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Repeat password',
                        icon: Image.asset(
                          'Assets/Icons/passwordIcon.png',
                          height: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  // REGISTER BUTTON
                  padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: FlatButton(
                        onPressed: _onPressed,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        disabledColor: Colors.black54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
