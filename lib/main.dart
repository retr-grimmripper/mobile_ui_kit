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
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/notification_screen.dart';

void main() async {
  // 1. MUST BE FIRST: Tells Flutter to wake up before starting Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Start Firebase securely
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Run the App
  runApp(const ProviderScope(child: MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store-Socio',

      // THE FONT FIX: This forces the browser to use a safe native font
      theme: ThemeData(
        fontFamily: 'system-ui',
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
      ),

      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/homepage': (context) => const HomePage(),
        '/content': (context) => const ContentScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/market': (context) => const MarketScreen(),
        '/feed': (context) => const FeedScreen(),
        '/insights': (context) => const InsightsScreen(),
        '/notifications': (context) => const NotificationScreen()
      },

      // THE ROUTING FIX: Smoothly handles Firebase loading states
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text("Firebase Error: ${snapshot.error}")),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator(color: Colors.green)),
            );
          }

          if (snapshot.hasData) {
            return const HomePage();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}