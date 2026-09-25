import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor = const Color(0xFFE30613),
    this.unselectedColor = Colors.black38,
  });

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;

    return Container(
      height: kBottomNavigationBarHeight + MediaQuery.paddingOf(context).bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, S.of(context).home, 'lib/assets/images/Home bottom.png'),
            _buildNavItem(1, S.of(context).bookings, 'lib/assets/images/booking bottom.png'),
            _buildNavItem(2, S.of(context).services, 'lib/assets/images/Service bottom.png'),
            _buildNavItem(3, S.of(context).profile, 'lib/assets/images/Profile.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String assetPath) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 24,
              width: 24,
              color: isSelected ? selectedColor : unselectedColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
