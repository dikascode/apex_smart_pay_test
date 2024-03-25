import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/styles.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //retrieve user data from shared pref
  Future<Map<String, String>> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String userDataJson = prefs.getString('userData') ?? '{"username": "User"}';

    final Map<String, dynamic> userData = jsonDecode(userDataJson);
    final String username = userData['username'];
    String token = prefs.getString('userToken') ?? 'No token';
    return {'username': username, 'token': token};
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    prefs.remove('userToken');
    prefs.remove('userData');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const OnboardingScreens()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, String>>(
          future: _loadUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Welcome, ${snapshot.data!['username']}!',
                            textAlign: TextAlign.left,
                            style:  const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                        const SizedBox(height: 20),
                        SvgPicture.asset('assets/images/logo.svg', width: 200),
                        const SizedBox(height: 40),
                        Text(
                          "Here's your secret: \n${snapshot.data!['token']}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Log out'),
                        content:
                            const Text('Are you sure you want to log out?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _logout();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    style: activeButtonStyle(true),
                    child:
                        const Text('Log Out', style: customButtonBoldTextStyle),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
