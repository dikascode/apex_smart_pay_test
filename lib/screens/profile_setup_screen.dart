import 'package:flutter/material.dart';
import '../widgets/custom_back_button.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'create_pin_screen.dart';
import '../styles/styles.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedCountry = 'Select Country';
  bool _isButtonActive = false;

  void checkIfButtonShouldBeActive() {
    setState(() {
      if (_fullNameController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _selectedCountry != 'Select Country' &&
          _passwordController.text.isNotEmpty) {
        _isButtonActive = true;
      } else {
        _isButtonActive = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(checkIfButtonShouldBeActive);
    _usernameController.addListener(checkIfButtonShouldBeActive);
    _passwordController.addListener(checkIfButtonShouldBeActive);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

//return to this later to rework custom ux
  void _showCountryPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 50,
            child: CountryListPick(
              theme: CountryTheme(
                isShowFlag: true,
                isShowTitle: true,
                isShowCode: false,
                isDownIcon: true,
                showEnglishName: true,
              ),
              onChanged: (CountryCode? code) {
                setState(() {
                  _selectedCountry = code?.name ?? 'Select Country';
                  checkIfButtonShouldBeActive();
                });
              },
            ),
          ),
        );
      },
    );
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
          children: [
            const Text(
              'Hey there! tell us a bit about yourself',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _fullNameController,
              decoration: customInputDecoration('Full name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: customInputDecoration('Username'),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _showCountryPicker();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedCountry,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF6B7280),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: customInputDecoration('Password'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isButtonActive
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreatePinScreen()),
                      );
                    }
                  : null,
              style: activeButtonStyle(_isButtonActive),
              child: const Text('Continue', style: customButtonBoldTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
