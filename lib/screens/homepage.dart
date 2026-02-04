import 'package:flutter/material.dart';
import 'package:mobile_ui_kit1/screens/feed.dart';
import 'package:mobile_ui_kit1/screens/insights.dart';
import 'package:mobile_ui_kit1/screens/login.dart';
import 'package:mobile_ui_kit1/screens/market.dart';
import 'package:mobile_ui_kit1/screens/profile.dart';
import 'package:mobile_ui_kit1/screens/signup.dart';
import 'package:mobile_ui_kit1/screens/content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final screens = [
    const FeedScreen(),
    const ContentScreen(),
    const InsightsScreen(),
    const MarketScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: const Color(0xFF5DB075),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Feed"),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: "Content"),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Insights"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Market"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}