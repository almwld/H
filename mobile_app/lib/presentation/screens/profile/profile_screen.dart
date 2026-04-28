import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/helpers.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/custom_button.dart';
import 'edit_profile_screen.dart';
import 'medical_history_screen.dart';
import 'subscription_screen.dart';
import 'payment_methods_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = GetIt.instance<AuthBloc>();
    _authBloc.add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.teal,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state is ProfileLoaded ? state.user.name : 'أحمد محمد',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state is ProfileLoaded ? state.user.email : 'ahmed@example.com',
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                        ),
                        child: const Text(AppStrings.editProfile),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Menu Items
                _buildMenuItem(
                  icon: Icons.medical_information,
                  title: AppStrings.medicalHistory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MedicalHistoryScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.subscriptions,
                  title: AppStrings.subscriptions,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.payment,
                  title: AppStrings.paymentMethods,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: AppStrings.settings,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.help,
                  title: 'مركز المساعدة',
                  onTap: () {},
                ),
                const Divider(),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: AppStrings.logout,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: _showLogoutDialog,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.primary),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showLogoutDialog() async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'تسجيل الخروج',
      message: 'هل أنت متأكد من تسجيل الخروج؟',
    );
    if (confirm) {
      _authBloc.add(LogoutEvent());
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }
}
