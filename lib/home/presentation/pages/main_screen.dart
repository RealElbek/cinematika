
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/themes/colors.dart';
import '../../../favorites/presentation/pages/FavoritesScreen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../tv/presentation/pages/tv_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TvScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/video.svg',
              color: _selectedIndex == 0 ? AppColors.primary : Colors.grey,
            ),
            label: _selectedIndex == 0 ? 'Movies' : '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/grid.svg',
              color: _selectedIndex == 1 ? AppColors.primary : Colors.grey,
            ),
            label: _selectedIndex == 1 ? 'Serials' : '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              color: _selectedIndex == 2 ? AppColors.primary : Colors.grey,
            ),
            label: _selectedIndex == 2 ? 'Favorites' : '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              color: _selectedIndex == 3 ? AppColors.primary : Colors.grey,
            ),
            label: _selectedIndex == 3 ? 'Menu' : '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF161616),
        selectedLabelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(color: Colors.transparent),
      ),
    );
  }
}
