import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'home_screen.dart';
import '../consultation/consultation_history_screen.dart';
import '../pharmacy/order_history_screen.dart';
import '../profile/profile_screen.dart';
import '../notifications/notifications_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ConsultationHistoryScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    'الرئيسية',
    'الاستشارات',
    'طلباتي',
    'حسابي',
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.history,
    Icons.local_shipping,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        items: List.generate(
          _titles.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(_icons[index]),
            label: _titles[index],
          ),
        ),
      ),
    );
  }
}
