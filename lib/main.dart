import 'package:flutter/material.dart';
import 'package:mobile_ui_kit1/screens/feed.dart';
import 'package:mobile_ui_kit1/screens/homepage.dart';
import 'package:mobile_ui_kit1/screens/market.dart';
import 'package:mobile_ui_kit1/screens/signup.dart';
import 'screens/profile.dart';
import 'screens/insights.dart';
import 'screens/login.dart';
import 'screens/content.dart';


void main() {
  runApp(MaterialApp(

    title: 'Store-Socio',
    debugShowCheckedModeBanner: false,

    initialRoute: '/signup',

    routes: {
      '/signup' : (context) => const SignUpScreen(),
      '/login' : (context) => const LoginScreen(),
      '/homepage' : (context) => const HomePage(),
      '/content' : (context) => const ContentScreen(),
      '/profile' : (context) => const ProfileScreen(),
      '/market' : (context) => const MarketScreen(),
      '/feed' : (context) => const FeedScreen(),
      '/insights' : (context) => const InsightsScreen(),
     },
  ));
}

