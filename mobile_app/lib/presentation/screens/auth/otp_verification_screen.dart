import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/custom_button.dart';
import '../home/main_navigation.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  int _timerSeconds = 60;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
        _startTimer();
      } else if (_timerSeconds == 0) {
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String getOtp() {
    return _otpControllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحقق من الكود'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.verified_user,
              size: 80,
              color: Colors.teal,
            ),
            const SizedBox(height: 24),
            Text(
              'تم إرسال الكود إلى',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.email,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) => _onOtpChanged(index, value),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'تحقق',
              onPressed: () {
                Helpers.showSnackBar(context, 'تم التحقق بنجاح');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainNavigation()),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_isResendEnabled ? 'لم يصلك الكود؟' : 'إعادة الإرسال بعد $_timerSeconds ثانية'),
                if (_isResendEnabled)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _timerSeconds = 60;
                        _isResendEnabled = false;
                      });
                      _startTimer();
                      Helpers.showSnackBar(context, 'تم إعادة إرسال الكود');
                    },
                    child: const Text('إعادة الإرسال'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
