import 'package:flutter/material.dart';
import 'package:stylish_app/routes/app_routes.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 360),
            _logo,
            SizedBox(height: 300),
            _startButton(context),
          ],
        ),
      ),
    );
  }

  Widget get _logo {
    return Image.asset("assets/images/logo.png");
  }

  Widget _startButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.of(context).pushNamed(AppRoute.secondSplashScreen),
      child: Text("Get Started"),
    );
  }
}
