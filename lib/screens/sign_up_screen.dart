import 'package:flutter/material.dart';
import 'package:smart_pay/screens/otp_verification.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/social_sign_in_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailFilled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    final isFilled = _emailController.text.isNotEmpty;
    if (isFilled != _isEmailFilled) {
      setState(() {
        _isEmailFilled = isFilled;
      });
    }
  }

  void _onSignUpPressed() {
  final String userEmail = _emailController.text;
    final String redactedEmail = _redactEmail(userEmail); 

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OtpVerification(redactedEmail: redactedEmail),
    ),
  );
}

String _redactEmail(String email) {
  final atIndex = email.indexOf('@');
  if (atIndex != -1) {
    return '*****${email.substring(atIndex)}';
  } else {
    return '*****@example.com'; // Fallback in case the email does not contain '@'
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: const CustomBackButton(),
        elevation: 0,
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Create a Smartpay account',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _emailController,
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
                keyboardType: TextInputType.emailAddress
              ),
              const SizedBox(height: 24.0),
               ElevatedButton(
              onPressed: _isEmailFilled
                  ? () {
                      // Sign up onPress logic
                     _onSignUpPressed();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isEmailFilled ? const Color(0xFF111827) : Colors.grey[400],
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Sign Up',
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
                    onPressed: () {

                    },
                  ),
                  SocialSignInButton(
                    assetName: 'assets/images/apple_icon.svg',
                    label: 'Apple',
                     onPressed: () {

                    }
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign in
                      },
                      child: const Text(
                        'Sign In',
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