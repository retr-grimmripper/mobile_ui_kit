import 'package:flutter/material.dart';
import '../theme/styles.dart';
import '../widgets/ui_kit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.close, color: Colors.grey),
        title: const Text("Log In", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomInput(label: "Email"),
            const SizedBox(height: 16),
            const CustomInput(label: "Password", isPassword: true),
            const SizedBox(height: 32),
            PrimaryButton(text: "Log In", onPressed: () {
              Navigator.pushNamed(context, '/homepage');
            }),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot your password?", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),

            const Spacer(),
            const Text("Don't have an account?", style: TextStyle(color: Colors.grey)),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text("Sign Up", style: TextStyle(color: AppColors.primary))
            ),
          ],
        ),
      ),
    );
  }
}