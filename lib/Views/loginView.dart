
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controller = new TextEditingController();

  // Login details
  var login = "";
  var password = "";
  // Enable/disable button
  bool _enabled;
@override void initState() {
    _enabled = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var _onPressed;
    if(_enabled){
      _onPressed = (){
        print("Pressed");
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
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                ]),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
            child: Container(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:  (val){
                  if(val.isEmpty){
                    return "Enter username";
                  } return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                  FilteringTextInputFormatter.deny(RegExp('[ ]'))
                ],
                onChanged: (val){
                  login = val;
                  if (login.length > 3 && password.length > 3){
                    setState(() {
                      _enabled = true;
                      print("enabled : $_enabled");
                    });
                  }
                  else{
                    setState(() {
                      _enabled = false;
                      print("enabled : $_enabled");
                    });
                  }
                },
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                ),
                obscureText: false,
                keyboardType: TextInputType.name,
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
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:  (val){
                        if(val.isEmpty){
                          return "Enter password";
                        } return null;
                      },
                      onChanged: (val){
                        password = val;
                        if (login.length > 3 && password.length > 3){
                          setState(() {
                            _enabled = true;
                            print("ButtonENabled : $_enabled");
                          });
                        }
                        else{
                          setState(() {
                            _enabled = false;
                            print("ButtonENabled : $_enabled");
                          });
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                      ),
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
                  ),
                ),
        Padding(
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
                  borderRadius: BorderRadius.circular(30.0)
                ) ,
                disabledColor: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Login',
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