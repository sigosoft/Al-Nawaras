import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class BookingTabBar extends StatelessWidget {
  final String selectedTab;
  final double width;
  final Function(String) onTabChanged;

  const BookingTabBar({
    super.key,
    required this.selectedTab,
    required this.width,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          _TabItem(
            title: S.of(context).allTab,
            isSelected: selectedTab == 'All',
            width: width,
            onTap: () => onTabChanged('All'),
          ),
          _TabItem(
            title: S.of(context).activeTab,
            isSelected: selectedTab == 'Active',
            width: width,
            onTap: () => onTabChanged('Active'),
          ),
          _TabItem(
            title: S.of(context).completedTab,
            isSelected: selectedTab == 'Completed',
            width: width,
            onTap: () => onTabChanged('Completed'),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final double width;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE30613) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[400],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
