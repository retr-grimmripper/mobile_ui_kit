import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_ui_kit1/screens/feed.dart';
import 'package:mobile_ui_kit1/screens/homepage.dart';
import 'package:mobile_ui_kit1/screens/market.dart';
import 'package:mobile_ui_kit1/screens/notification_screen.dart';
import 'package:mobile_ui_kit1/screens/signup.dart';
import 'screens/profile.dart';
import 'screens/insights.dart';
import 'screens/login.dart';
import 'screens/content.dart';
import 'lib/services/auth_service.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await AuthService.init();

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

  } catch (e, stacktrace) {
    print("❌ CRITICAL CRASH DURING STARTUP: $e");

    runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                "App failed to start.\nError: $e",
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store-Socio',

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
        '/notifications' : (context) => const NotificationScreen()
      },
      home: AuthService.isLoggedIn ? const HomePage() : const LoginScreen(),
    );
  }
}
