import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memovoca/screen/splash_screen.dart';

// void main() {
//   runApp(MyApp());
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List App',
      home: SplashScreen(),
    );
  }
}