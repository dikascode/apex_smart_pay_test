import 'package:flutter/material.dart';
import '../widgets/custom_back_button.dart';
import 'package:country_list_pick/country_list_pick.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedCountry = 'Select Country';
  bool isButtonActive = false;

  void checkIfButtonShouldBeActive() {
    setState(() {
      if (fullNameController.text.isNotEmpty &&
          usernameController.text.isNotEmpty &&
          selectedCountry != 'Select Country' &&
          passwordController.text.isNotEmpty) {
        isButtonActive = true;
      } else {
        isButtonActive = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fullNameController.addListener(checkIfButtonShouldBeActive);
    usernameController.addListener(checkIfButtonShouldBeActive);
    passwordController.addListener(checkIfButtonShouldBeActive);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
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
                selectedCountry = code?.name ?? 'Select Country';
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
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full name',
                fillColor: Color(0xFFF9FAFB),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                fillColor: Color(0xFFF9FAFB),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
               GestureDetector(
              onTap: () {
                _showCountryPicker();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedCountry,
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
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                fillColor: Color(0xFFF9FAFB),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isButtonActive
                  ? () {
                      // Handle profile setup logic
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isButtonActive ? const Color(0xFF111827) : Colors.grey[400],
                    foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
