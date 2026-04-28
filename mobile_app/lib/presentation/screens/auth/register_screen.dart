import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home/main_navigation.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _userType = 'patient';
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = GetIt.instance<AuthBloc>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.register),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthLoading) {
            Helpers.showLoadingDialog(context);
          } else {
            Helpers.hideLoadingDialog(context);
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainNavigation()),
            );
          }
          if (state is AuthFailure) {
            Helpers.showSnackBar(context, state.message, isError: true);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_add,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: AppStrings.password,
                      prefixIcon: Icons.lock,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: Validators.validatePassword,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      label: AppStrings.confirmPassword,
                      prefixIcon: Icons.lock_outline,
                      obscureText: !_isConfirmPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) => Validators.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Text('نوع الحساب:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SegmentedButton<String>(
                              segments: const [
                                ButtonSegment(
                                  value: 'patient',
                                  label: Text('مريض'),
                                  icon: Icon(Icons.person),
                                ),
                                ButtonSegment(
                                  value: 'doctor',
                                  label: Text('طبيب'),
                                  icon: Icon(Icons.medical_services),
                                ),
                                ButtonSegment(
                                  value: 'pharmacy',
                                  label: Text('صيدلية'),
                                  icon: Icon(Icons.local_pharmacy),
                                ),
                              ],
                              selected: {_userType!},
                              onSelectionChanged: (Set<String> selection) {
                                setState(() {
                                  _userType = selection.first;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.register,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _authBloc.add(
                      RegisterRequested(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        phone: _phoneController.text.trim(),
                        password: _passwordController.text,
                        userType: _userType!,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.haveAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      AppStrings.login,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
