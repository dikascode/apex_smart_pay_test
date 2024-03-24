import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/styles.dart';
import 'create_new_password_screen.dart';

class VerifyIdentityScreen extends StatelessWidget {
  final String email;

  const VerifyIdentityScreen({
    super.key,
    required this.email,
  });

  String _redactEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex == -1) return "null@example.com";
    final redacted = '${email[0]}******${email.substring(atIndex)}';
    return redacted;
  }

  @override
  Widget build(BuildContext context) {
    final redactedEmail = _redactEmail(email);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/identity_icon.svg',
              height: 100,
            ),
            const SizedBox(height: 32),
            const Text(
              'Verify your identity',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Where would you like Smartpay to send your security code?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              initialValue: redactedEmail,
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.check_circle, color: Colors.green),
                suffixIcon: const Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
               Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateNewPasswordScreen()),
                      );
              },
               style: activeButtonStyle(true),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
