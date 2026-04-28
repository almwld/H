import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'أحمد محمد');
  final _emailController = TextEditingController(text: 'ahmed@example.com');
  final _phoneController = TextEditingController(text: '0500000000');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editProfile)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(blurRadius: 4, color: Colors.black26),
                          ],
                        ),
                        child: const Icon(Icons.camera_alt, size: 20, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: _nameController,
                label: AppStrings.name,
                prefixIcon: Icons.person,
                validator: Validators.validateName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: AppStrings.email,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                label: AppStrings.phone,
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.save,
                isLoading: _isLoading,
                onPressed: _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _isLoading = false);
      Helpers.showSnackBar(context, 'تم تحديث الملف الشخصي بنجاح');
      Navigator.pop(context);
    }
  }
}
