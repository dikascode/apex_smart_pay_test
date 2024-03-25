import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';
import '../styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  String _username = 'James';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    //Retrieve from sharedPref
    final prefs = await SharedPreferences.getInstance();
    final String? userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      final Map<String, dynamic> userData = jsonDecode(userDataJson);
      final String username = userData['username'];
      setState(() {
        _username = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/stars.svg',
                  height: 160,
                ),
                Image.asset(
                  'assets/images/thumbs_up.png',
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 48),
            Text(
              'Congratulations, $_username',
              style: const TextStyle(
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
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: activeButtonStyle(true),
              child:
                  const Text('Get Started', style: customButtonBoldTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
