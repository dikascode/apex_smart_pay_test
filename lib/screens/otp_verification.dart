import 'package:flutter/material.dart';
import '../widgets/custom_back_button.dart';
import 'profile_setup_screen.dart';
import '../utils/pin_field_utils.dart';
import '../styles/styles.dart';

class OtpVerification extends StatefulWidget {
  final String redactedEmail;
  final String token;
  const OtpVerification({super.key, required this.redactedEmail, required this.token});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _codeLength = 5;
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _codeLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
      // Add listener to each controller
      controllers[i].addListener(() {
        // Update isButtonActive when any field changes
        final allFilled =
            controllers.every((controller) => controller.text.isNotEmpty);
        setState(() => _isButtonActive = allFilled);
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Verify it\'s you',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'We sent a code to (${widget.redactedEmail}). Enter it here to verify your identity',
              style: customSubtitleTextStyle,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  List.generate(_codeLength, (index) => _buildCodeBox(index)),
            ),
            const SizedBox(height: 30),
            const Text(
              'Resend Code 30 secs',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 106, 105, 105)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _isButtonActive
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileSetupScreen()),
                      );
                    }
                  : null,
              style: activeButtonStyle(_isButtonActive),
              child: const Text('Confirm',
                  style: customButtonBoldTextStyle,),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeBox(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 232, 241),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focusNodes[index].hasFocus
              ? const Color(0xFF2FA2B9)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          textAlign: TextAlign.center,
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) => PinFieldUtils.handlePinFieldChange(
              value, index, focusNodes, _codeLength, context)),
    );
  }
}
