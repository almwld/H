import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _autoRenew = true;
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
      _autoRenew = prefs.getBool('autoRenew') ?? true;
      _selectedLanguage = prefs.getString('language') ?? 'ar';
    });
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  void _changeLanguage(String code) async {
    setState(() => _selectedLanguage = code);
    await _saveSetting('language', code);
    Helpers.showSnackBar(context, 'تم تغيير اللغة');
  }

  void _clearAllData() async {
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: 'مسح البيانات',
      message: 'هل أنت متأكد من مسح جميع بيانات التطبيق؟ هذا الإجراء لا يمكن التراجع عنه.',
    );
    if (confirm) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Helpers.showSnackBar(context, 'تم مسح جميع البيانات');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        children: [
          // Appearance Section
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('المظهر', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('الوضع الليلي'),
            subtitle: const Text('تغيير مظهر التطبيق'),
            secondary: const Icon(Icons.dark_mode),
            value: _isDarkMode,
            onChanged: (value) async {
              setState(() => _isDarkMode = value);
              await _saveSetting('darkMode', value);
            },
          ),
          const Divider(),

          // Notifications Section
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('الإشعارات', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('إشعارات فورية'),
            subtitle: const Text('استلام إشعارات التطبيق'),
            secondary: const Icon(Icons.notifications),
            value: _pushNotifications,
            onChanged: (value) async {
              setState(() => _pushNotifications = value);
              await _saveSetting('pushNotifications', value);
            },
          ),
          SwitchListTile(
            title: const Text('إشعارات البريد الإلكتروني'),
            subtitle: const Text('استلام إشعارات عبر البريد'),
            secondary: const Icon(Icons.email),
            value: _emailNotifications,
            onChanged: (value) async {
              setState(() => _emailNotifications = value);
              await _saveSetting('emailNotifications', value);
            },
          ),
          const Divider(),

          // Subscription Section
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('الاشتراك', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('تجديد تلقائي'),
            subtitle: const Text('تجديد الاشتراك تلقائياً'),
            secondary: const Icon(Icons.autorenew),
            value: _autoRenew,
            onChanged: (value) async {
              setState(() => _autoRenew = value);
              await _saveSetting('autoRenew', value);
            },
          ),
          const Divider(),

          // Language Section
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('اللغة', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('العربية'),
            leading: Radio<String>(
              value: 'ar',
              groupValue: _selectedLanguage,
              onChanged: (value) => _changeLanguage(value!),
            ),
            trailing: _selectedLanguage == 'ar' ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () => _changeLanguage('ar'),
          ),
          ListTile(
            title: const Text('English'),
            leading: Radio<String>(
              value: 'en',
              groupValue: _selectedLanguage,
              onChanged: (value) => _changeLanguage(value!),
            ),
            trailing: _selectedLanguage == 'en' ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () => _changeLanguage('en'),
          ),
          const Divider(),

          // Data Management Section
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('البيانات', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('مسح جميع البيانات'),
            subtitle: const Text('حذف جميع بيانات التطبيق المخزنة محلياً'),
            leading: const Icon(Icons.delete, color: Colors.red),
            onTap: _clearAllData,
          ),
          const Divider(),

          // About Section
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('حول التطبيق', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('سياسة الخصوصية'),
            leading: const Icon(Icons.privacy_tip),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('سياسة الخصوصية'),
                  content: const SizedBox(
                    width: 300,
                    child: Text('نحن نحمي خصوصية بياناتك ولا نشاركها مع أي جهة خارجية.'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إغلاق'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('شروط الاستخدام'),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('شروط الاستخدام'),
                  content: const SizedBox(
                    width: 300,
                    child: Text('باستخدام هذا التطبيق، أنت توافق على الشروط والأحكام.'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إغلاق'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('حول التطبيق'),
            leading: const Icon(Icons.info),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('حول التطبيق'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.health_and_safety, size: 50, color: Colors.teal),
                      const SizedBox(height: 8),
                      const Text('صحتك', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('منصة رعاية صحية رقمية'),
                      const SizedBox(height: 8),
                      Text('الإصدار 1.0.0', style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إغلاق'),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
