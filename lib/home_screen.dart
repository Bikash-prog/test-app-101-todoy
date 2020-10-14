import 'package:flutter/material.dart';
import 'package:todoy/helpers/drawer_navigation.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(text: TextSpan(
          children: [
            TextSpan(
              text: 'to',
              style: TextStyle(
                 fontSize: 30,
                 fontWeight: FontWeight.bold,
                 color: Color(0xffffffff)
              ),
            ),
            TextSpan(
                text: 'DO',
              style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff0a500)
              ),
            ),
          ]
        ),
        ),
      ),
      drawer: DrawerNavigation(),
    );
  }
}

