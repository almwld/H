import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  String _selectedLanguage = 'ar';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _pushNotifications = prefs.getBool('pushNotifications') ?? true;
      _emailNotifications = prefs.getBool('emailNotifications') ?? true;
      _selectedLanguage = prefs.getString('language') ?? 'ar';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setBool('pushNotifications', _pushNotifications);
    await prefs.setBool('emailNotifications', _emailNotifications);
    await prefs.setString('language', _selectedLanguage);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ الإعدادات')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('الوضع الليلي'),
              subtitle: const Text('تغيير مظهر التطبيق'),
              secondary: const Icon(Icons.dark_mode),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() => _isDarkMode = value);
                _saveSettings();
              },
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('إشعارات فورية'),
              subtitle: const Text('استلام إشعارات التطبيق'),
              secondary: const Icon(Icons.notifications),
              value: _pushNotifications,
              onChanged: (value) {
                setState(() => _pushNotifications = value);
                _saveSettings();
              },
            ),
            SwitchListTile(
              title: const Text('إشعارات البريد الإلكتروني'),
              subtitle: const Text('استلام إشعارات عبر البريد'),
              secondary: const Icon(Icons.email),
              value: _emailNotifications,
              onChanged: (value) {
                setState(() => _emailNotifications = value);
                _saveSettings();
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('اللغة'),
              subtitle: const Text('اختر لغة التطبيق'),
              leading: const Icon(Icons.language),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (value) {
                  setState(() => _selectedLanguage = value!);
                  _saveSettings();
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('سياسة الخصوصية'),
              leading: const Icon(Icons.privacy_tip),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              title: const Text('شروط الاستخدام'),
              leading: const Icon(Icons.description),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              title: const Text('حول التطبيق'),
              leading: const Icon(Icons.info),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
