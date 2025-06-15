import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x5A000000),
            blurRadius: 16,
            offset: Offset(0, -8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(iconColor: const Color(0xFF2AB156), label: 'Movies'),
          _NavItem(iconColor: const Color(0xFF8E8E93), label: ''),
          _NavItem(iconColor: const Color(0xFF8E8E93), label: ''),
          _NavItem(iconColor: const Color(0xFF8E8E93), label: ''),
          _NavItem(iconColor: const Color(0xFF8E8E93), label: ''),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final Color iconColor;
  final String label;

  const _NavItem({required this.iconColor, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: iconColor,
          ),
        ),
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF2AB156),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}