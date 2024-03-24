import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/social_sign_in_button.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/back_icon.svg',
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Hi There! 👋',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Welcome back, Sign in to your account',
                style: TextStyle(fontSize: 20.0, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 32.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: const Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                  suffixIcon: const Icon(Icons.visibility_off,
                      color: Color(0xFF9CA3AF)),
                ),
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Forgot password onpress
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF0A6375),
                  ),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // Sign in onpress
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111827),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Sign In',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 32.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child:
                        Text('OR', style: TextStyle(color: Color(0xFF6B7280))),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SocialSignInButton(
                    assetName: 'assets/images/google_icon.svg',
                    label: 'Google',
                    onPressed: () {},
                  ),
                  SocialSignInButton(
                      assetName: 'assets/images/apple_icon.svg',
                      label: 'Apple',
                      onPressed: () {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Don’t have an account?',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Color(0xFF0A6375)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
