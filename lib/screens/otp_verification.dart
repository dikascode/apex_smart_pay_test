import 'package:flutter/material.dart';
import '../widgets/custom_back_button.dart';
import 'profile_setup_screen.dart';

class OtpVerification extends StatefulWidget {
  final String redactedEmail;

  const OtpVerification({super.key, required this.redactedEmail});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final codeLength = 5;
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
      // Add listener to each controller
      controllers[i].addListener(() {
        // Update isButtonActive when any field changes
        final allFilled =
            controllers.every((controller) => controller.text.isNotEmpty);
        setState(() => isButtonActive = allFilled);
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
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  List.generate(codeLength, (index) => _buildCodeBox(index)),
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
              onPressed: isButtonActive
                  ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileSetupScreen()),
                        );
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
              child: const Text('Confirm',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeBox(int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 232, 241),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focusNodes[index].hasFocus
              ? const Color(0xFF2FA2B9)
              : Colors.transparent,
          width: 2,
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
      ),
    );
  }
}
