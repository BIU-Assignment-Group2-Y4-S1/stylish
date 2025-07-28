import 'package:flutter/material.dart';
import 'package:stylish_app/views/widget_tree.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash 1")
      ),
    );
  }
}