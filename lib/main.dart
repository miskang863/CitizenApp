import 'package:flutter/material.dart';

import 'Views/loginView.dart';
import 'Views/registerView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Register'),
              ],
            ),
            title: Text("Citizen"),
          ),
          body: TabBarView(
            children: [
              LoginPage(),
              RegisterView()
            ],
          ),
        ),
      ),
    );
  }
}