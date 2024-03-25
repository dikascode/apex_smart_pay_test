import 'package:flutter/material.dart';
import 'package:smart_pay/screens/home_screen.dart';
import 'package:smart_pay/styles/styles.dart';
import '../widgets/social_sign_in_button.dart';
import 'sign_up_screen.dart';
import '../widgets/custom_back_button.dart';
import 'password_recovery_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'dart:convert';
import '../utils/dialog_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/password_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonActive = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInAndNavigate() async {
    showLoadingDialog(context);

    final response =
        await Provider.of<AuthService>(context, listen: false).login(
      email: _emailController.text,
      password: _passwordController.text,
      deviceName: 'mobile',
    );

    hideLoadingDialog(context);

    if (response['success']) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userToken', response['token']);
      await prefs.setString('userData', jsonEncode(response['user']));

      print('SharePref: token:${jsonEncode(response['user'])}, ');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(response['message'] ?? 'Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(
            onPressed: () {},
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
                style: customSubtitleTextStyle,
              ),
              const SizedBox(height: 32.0),
              TextField(
                  controller: _emailController,
                  decoration: customInputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16.0),
              PasswordField(
                controller: _passwordController,
                hintText: 'Password',
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Forgot password onpress
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordRecoveryScreen()),
                    );
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
                  _signInAndNavigate();
                },
                style: activeButtonStyle(_isButtonActive),
                child: const Text('Sign In', style: customButtonBoldTextStyle),
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
