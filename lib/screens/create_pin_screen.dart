import 'package:flutter/material.dart';
import '../widgets/custom_back_button.dart';
import '../utils/pin_field_utils.dart';
import 'confirmation_screen.dart';
import '../styles/styles.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

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
              'Set your PIN code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We use state-of-the-art security measures to protect your information at all times',
              style:  customSubtitleTextStyle,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  List.generate(codeLength, (index) => _buildPinBox(index)),
            ),
    
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _isButtonActive
                  ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ConfirmationScreen()),
                        );
                    }
                  : null,
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