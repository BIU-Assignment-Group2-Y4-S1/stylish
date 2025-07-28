import 'package:flutter/material.dart';
import 'package:stylish_app/views/screens/first_splash_screen.dart';
import 'package:stylish_app/views/screens/forgot_password_screen.dart';
import 'package:stylish_app/views/screens/fourth_splash_screen.dart';
import 'package:stylish_app/views/screens/home_screen.dart';
import 'package:stylish_app/views/screens/search_screen.dart';
import 'package:stylish_app/views/screens/second_splash_screen.dart';
import 'package:stylish_app/views/screens/setting_screen.dart';
import 'package:stylish_app/views/screens/signin_screen.dart';
import 'package:stylish_app/views/screens/signup_screen.dart';
import 'package:stylish_app/views/screens/third_splash_screen.dart';
import 'package:stylish_app/views/widget_tree.dart';

class AppRoute {
  static const String widgetTree = "/widgetTree";
  static const String homeScreen = "/homeScreen";
  static const String searchScreen = "/searchScreen";
  static const String firstSplashScreen = "/firstSplashScreen";
  static const String signInScreen = "/signInScreen";
  static const String secondSplashScreen = "/secondSplashScreen";
  static const String thirdSplashScreen = "/thirdSplashScreen";
  static const String fourthSplashScreen = "/fourthSplashScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String settingScreen = "/settingScreen";

  static final key = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case widgetTree:
        return _buildRoute(routeSettings, WidgetTree());
      case homeScreen:
        return _buildRoute(routeSettings, HomeScreen());
      case searchScreen:
        return _buildRoute(routeSettings, SearchScreen());
      case firstSplashScreen:
        return _buildRoute(routeSettings, FirstSplashScreen());
      case signInScreen:
        return _buildRoute(routeSettings, SigninScreen());
      case secondSplashScreen:
        return _buildRoute(routeSettings, SecondSplashScreen());
      case thirdSplashScreen:
        return _buildRoute(routeSettings, ThirdSplashScreen());
       case fourthSplashScreen:
        return _buildRoute(routeSettings, FourthSplashScreen());
      case signUpScreen:
        return _buildRoute(routeSettings, SignupScreen());
      case forgotPasswordScreen:
        return _buildRoute(routeSettings, ForgotPasswordScreen());
      case settingScreen:
        return _buildRoute(routeSettings, SettingScreen());
      default:
        return _buildRoute(
          routeSettings,
          Scaffold(
            body: Center(child: Text('Route ${routeSettings.name} not found')),
          ),
        );
    }
  }

  static Route<dynamic> _buildRoute(
    RouteSettings routeSettings,
    Widget newRoute,
  ) {
    final route = MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) => newRoute,
    );
    return route;
  }
}

class RouteException implements Exception {
  String messsage;

  RouteException(this.messsage);
}
