import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_back_button.dart';
import '../utils/pin_field_utils.dart';
import 'confirmation_screen.dart';
import '../styles/styles.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({Key? key}) : super(key: key);

  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final codeLength = 5;
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
      controllers[i].addListener(_updateButtonState);
    }
  }

  void _updateButtonState() {
    final allFilled = controllers.every((controller) => controller.text.isNotEmpty);
    setState(() => _isButtonActive = allFilled);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _savePinAndNavigate() async {
    // Concatenate the inputs from each PIN field into a single PIN string
    final pin = controllers.map((controller) => controller.text).join();

    // Save the PIN in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
     bool saveSuccess = await prefs.setString('userPin', pin);

    if (saveSuccess) {
    print("PIN saved successfully: $pin");
    // Navigate to the ConfirmationScreen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ConfirmationScreen()));
  } else {
    print("Failed to save PIN.");
  }

    // Navigate to the ConfirmationScreen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ConfirmationScreen()));
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
              'Set your PIN code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We use state-of-the-art security measures to protect your information at all times',
              style: customSubtitleTextStyle,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(codeLength, (index) => _buildPinBox(index)),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _isButtonActive ? _savePinAndNavigate : null,
              style: activeButtonStyle(_isButtonActive),
              child: const Text('Create PIN', style: customButtonBoldTextStyle),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildPinBox(int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        obscureText: true,
        obscuringCharacter: '●',
        decoration: const InputDecoration(
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 223, 232, 241),
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF2FA2B9),
              width: 2,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => PinFieldUtils.handlePinFieldChange(value, index, focusNodes, codeLength, context),
      ),
    );
  }
}