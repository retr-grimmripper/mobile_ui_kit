import 'package:flutter/material.dart';
import '../theme/styles.dart';
import '../widgets/ui_kit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _agreedToPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.close, color: Colors.grey),
        title: const Text("Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, child: const Text("Login", style: TextStyle(color: AppColors.primary)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomInput(label: "Name"),
            const SizedBox(height: 16,),
            const CustomInput(label: "Email"),
            const SizedBox(height: 16),
            const CustomInput(label: "Password", isPassword: true),
            const SizedBox(height: 20),

            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: _agreedToPrivacy,
                    activeColor: Color(0xFF5DB075),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (value) {
                      setState(() {
                        _agreedToPrivacy = value!;
                      });
                    },
                  ),
                  Text("I would like to receive your newsletter and promotional information.", style: TextStyle(color: Colors.grey[600]), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 2, softWrap: false),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: "Sign Up", onPressed: () {
              Navigator.pushNamed(context, '/homepage');
            }),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot your password?", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),

            SizedBox.fromSize(),
            const Text("Already have an account?", style: TextStyle(color: Colors.grey)),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("Log In", style: TextStyle(color: AppColors.primary))
            ),
          ],
        ),
      ),
    );
  }
}