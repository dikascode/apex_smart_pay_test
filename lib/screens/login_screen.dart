import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/styles.dart';
import 'home_screen.dart';
import '../utils/pin_field_utils.dart';
import '../widgets/custom_back_button.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({Key? key}) : super(key: key);

  @override
  _PinLoginScreenState createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _pinController.addListener(() {
      setState(() {
        _isButtonActive = _pinController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _loginWithPin() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPin = prefs.getString('userPin');
    
    if (_pinController.text == storedPin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect PIN. Please try again.')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your PIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _pinController,
              obscureText: true,
              decoration: customInputDecoration('PIN'),
              keyboardType: TextInputType.number,
              maxLength: 5, 
              onChanged: (value) => PinFieldUtils.handlePinFieldChange(value, 0, [], 5, context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonActive ? _loginWithPin : null,
              style: activeButtonStyle(_isButtonActive),
              child: const Text('Login', style: customButtonBoldTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
