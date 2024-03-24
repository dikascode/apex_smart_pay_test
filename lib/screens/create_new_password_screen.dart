import 'package:flutter/material.dart';
import '../widgets/custom_back_button.dart';
import '../styles/styles.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordScreenState createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonActive = _newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Create New Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please, enter a new password below different from the previous password',
              style: customSubtitleTextStyle,
            ),
            const SizedBox(height: 32),
            _buildPasswordField('New password', _newPasswordController),
            const SizedBox(height: 16),
            _buildPasswordField('Confirm password', _confirmPasswordController),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _isButtonActive ? () {} : null,
                style: activeButtonStyle(_isButtonActive),
                child: const Text('Create new password',
                    style: customButtonBoldTextStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        hintText: label,
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
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
    );
  }
}
