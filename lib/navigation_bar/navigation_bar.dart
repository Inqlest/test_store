import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_store/res/constants/color_constants.dart';
import 'package:test_store/router/app_router.dart';

int _selectedIndex = 0;

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final List<IconData> _icons = [
    Icons.home,
    Icons.favorite,
    Icons.person,
  ];

  final List<String> _labels = [
    'Товары',
    'Избранное',
    'профиль',
  ];

  final List<PageRouteInfo> _routes = [
    const ProductRoute(),
    const FavoritesRoute(),
    const ProfileRoute(),
  ];

  void _onItemTapped(int index) {
    context.router.replace(_routes[index]);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: const Color.fromRGBO(96, 96, 123, 1),
      items: List.generate(
        _icons.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(
            _icons[index],
          ),
          label: _labels[index],
        ),
      ),
    );
  }
}
