import 'package:flutter/material.dart';
import 'package:stylish_app/routes/app_routes.dart';

class ThirdSplashScreen extends StatefulWidget {
  const ThirdSplashScreen({super.key});

  @override
  State<ThirdSplashScreen> createState() => _ThirdSplashScreenState();
}

class _ThirdSplashScreenState extends State<ThirdSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Skip",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 155),
            _banner,
            _text,
            SizedBox(height: 170),
            _nextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.of(
            context,
          ).pop(AppRoute.secondSplashScreen),
          child: Text(
            "Prev",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFC4C4C4),
              fontSize: 18,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(
            context,
          ).pushNamed(AppRoute.fourthSplashScreen),
          child: Text(
            "Next",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFF83758),
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _banner {
    return Image.asset("assets/images/sales-consulting.png");
  }

  Widget get _text {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Text(
            "Make Payment",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
            style: TextStyle(color: Color(0xFFA8A8A9), fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
