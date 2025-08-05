import 'package:flutter/material.dart';
import 'package:stylish_app/routes/app_routes.dart';
import 'package:stylish_app/views/screens/shipping_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish App',
      onGenerateRoute: AppRoute.onGenerateRoute,
      initialRoute: AppRoute.signInScreen,
      // navigatorKey: AppRoute.key,
      // home: ShippingScreen(),
    );
  }
}
