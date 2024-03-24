import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/styles.dart';
import 'verify_identity_screen.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final isNotEmpty = _emailController.text.isNotEmpty;
    setState(() {
      _isButtonActive = isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateButtonState);
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/lock_icon.svg',
                height: 100,
              ),
              const SizedBox(height: 24),
              const Text(
                'Password Recovery',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your registered email below to receive password instructions',
                textAlign: TextAlign.left,
                style: customSubtitleTextStyle,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'anabella@example.com',
                  filled: true,
                  fillColor: const Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide
                        .none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide
                        .none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF2FA2B9),
                      width: 1,
                    ),
                  ),
                  hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16.0,
          right: 16.0,
          top: 16.0, 
        ),
        child: ElevatedButton(
          onPressed: _isButtonActive
              ? () {
                  final String userEmail = _emailController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VerifyIdentityScreen(email: userEmail)),
                  );
                }
              : null,
          style: activeButtonStyle(_isButtonActive),
          child: const Text('Send me email', style: customButtonBoldTextStyle),
        ),
      ),
    );
  }
}
