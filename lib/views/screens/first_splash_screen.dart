import 'package:flutter/material.dart';
import 'package:stylish_app/routes/app_routes.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(AppRoute.secondSplashScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 360),
            _logo,
            const SizedBox(height: 300),
            // _startButton(context),
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
      onPressed: () => Navigator.of(context)
          .pushReplacementNamed(AppRoute.secondSplashScreen),
      child: const Text("Get Started"),
    );
  }
}