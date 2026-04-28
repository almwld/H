import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نسيت كلمة المرور'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.lock_reset,
              size: 80,
              color: Colors.teal,
            ),
            const SizedBox(height: 24),
            Text(
              'إعادة تعيين كلمة المرور',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: _emailController,
                label: AppStrings.email,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'إرسال رمز التحقق',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Helpers.showSnackBar(
                    context,
                    'تم إرسال رمز التحقق إلى بريدك الإلكتروني',
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OtpVerificationScreen(
                        email: _emailController.text,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
