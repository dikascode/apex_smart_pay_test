import 'package:flutter/material.dart';

class OnboardingContent1 extends StatelessWidget {
  const OnboardingContent1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            child: Image.asset(
              'assets/images/onboarding_1.png',
              height: 300,
            ),
          ),
          const Text(
            'Finance app the safest and most trusted',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
