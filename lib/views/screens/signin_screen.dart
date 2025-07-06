import 'package:flutter/material.dart';
import 'package:stylish_app/routes/app_routes.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoute.widgetTree, (route) => false);
            // Navigator.of(context).pushReplacementNamed(AppRoute.widgetTree);
          },
          child: Text("Go to Home"),
        ),
      ),
    );
  }
}
