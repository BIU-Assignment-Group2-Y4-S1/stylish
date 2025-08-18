import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // Check auth state and navigate after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _checkAuthState();
    });
  }

  Future<void> _checkAuthState() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, go to widgetTree
      Navigator.of(context).pushReplacementNamed(AppRoute.widgetTree);
    } else {
      // User is not logged in, go to second splash screen
      Navigator.of(context).pushReplacementNamed(AppRoute.secondSplashScreen);
    }
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
          ],
        ),
      ),
    );
  }

  Widget get _logo {
    return Image.asset("assets/images/logo.png");
  }
}