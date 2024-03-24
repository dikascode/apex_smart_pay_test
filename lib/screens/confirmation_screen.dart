import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';
import '../styles/styles.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment
                  .center,
              children: <Widget>[
                  SvgPicture.asset(
                  'assets/images/stars.svg',
                  height:160, 
                ),
                Image.asset(
                  'assets/images/thumbs_up.png',
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 48),
            const Text(
              'Congratulations, *James',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'You’ve completed the onboarding, you can start using',
              style: customSubtitleTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
              },
              style: activeButtonStyle(true),
              child: const Text('Get Started', style: customButtonBoldTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
