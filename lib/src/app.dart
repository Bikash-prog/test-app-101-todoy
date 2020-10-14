import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoy/home_screen.dart';

Map<int, Color> color =
{
  50:Color.fromRGBO(117,121,231, 1),
  100:Color.fromRGBO(117,121,231, 1),
  200:Color.fromRGBO(117,121,231, 1),
  300:Color.fromRGBO(117,121,231, 1),
  400:Color.fromRGBO(117,121,231, 1),
  500:Color.fromRGBO(117,121,231, 1),
  600:Color.fromRGBO(117,121,231, 1),
  700:Color.fromRGBO(117,121,231, 1),
  800:Color.fromRGBO(117,121,231, 1),
  900:Color.fromRGBO(117,121,231, 1),
};
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xff7579e7,color);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: HomeScreen(),
    );
  }
}
