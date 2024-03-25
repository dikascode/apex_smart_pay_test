import 'package:flutter/material.dart';
import 'package:smart_pay/screens/otp_verification.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/social_sign_in_button.dart';
import 'sign_in_screen.dart';
import '../styles/styles.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../utils/dialog_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonActive = false;

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
    if (isFilled != _isButtonActive) {
      setState(() {
        _isButtonActive = isFilled;
      });
    }
  }

  void _onSignUpPressed() async {
    showLoadingDialog(context);

    final String userEmail = _emailController.text;
    final response = await Provider.of<AuthService>(context, listen: false)
        .getEmailToken(userEmail);
    hideLoadingDialog(context);

    if (response['success']) {
      // Successful API call with token received.
      String token = response['data'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerification(
              userEmail: userEmail, token: token),
        ),
      );
    } else {
      // Unsuccessful call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          duration: const Duration(seconds: 3),
        ),
      );
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
                  decoration: customInputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _isButtonActive
                    ? () {
                        // Sign up onPress logic
                        _onSignUpPressed();
                      }
                    : null,
                style: activeButtonStyle(_isButtonActive),
                child: const Text('Sign Up', style: customButtonBoldTextStyle),
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
                      'Already have an account?',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign in
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
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
