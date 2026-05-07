import 'package:flutter/material.dart';
import '../theme/styles.dart';
import '../widgets/ui_kit.dart';
import 'package:mobile_ui_kit1/lib/services/auth_service.dart';

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
  bool _isLoading = false; // Added to show a loading spinner while Firebase works

  // --- THE NEW FIREBASE LOGIC ---
  void _handleSignUp() async {
    // 1. Ensure the user agreed to the privacy policy (optional UI enhancement)
    if (!_agreedToPrivacy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please agree to the newsletter and privacy terms."), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isLoading = true);

    // 2. Send the typed email and password to our AuthService
    String? error = await AuthService.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (mounted) setState(() => _isLoading = false);

    if (error != null) {
      // 3. Show error if Firebase rejects it (e.g., "Password too weak")
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      }
    } else {
      // 4. Success! Close the signup screen.
      // The StreamBuilder in main.dart will instantly detect the new user and draw the HomePage!
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

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
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text("Login", style: TextStyle(color: AppColors.primary))
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bound your controllers to your CustomInputs so Firebase can read the text!
            CustomInput(label: "Name", controller: _nameController),
            const SizedBox(height: 16),
            CustomInput(label: "Email", controller: _emailController),
            const SizedBox(height: 16),
            CustomInput(label: "Password", isPassword: true, controller: _passwordController),
            const SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                  value: _agreedToPrivacy,
                  activeColor: const Color(0xFF5DB075),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  onChanged: (value) {
                    setState(() {
                      _agreedToPrivacy = value!;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "I would like to receive your newsletter and promotional information.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Swap the button for a loader if Firebase is thinking
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : PrimaryButton(
              text: "Sign Up",
              onPressed: _handleSignUp, // Changed from hardcoded navigation to real Firebase logic
            ),

            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot your password?", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
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