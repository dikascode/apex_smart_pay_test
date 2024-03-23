import 'package:flutter/material.dart';

class OnboardingContent2 extends StatelessWidget {
  const OnboardingContent2({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            child: Image.asset(
              'assets/images/onboarding_2.png',
              height: 300,
            ),
          ),
          const Text(
            'The fastest transaction process only here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.',
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
