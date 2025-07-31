import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomnavbarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomnavbarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior:
          Clip.none, // Allow children to go outside the stack's bounds
      alignment: Alignment.bottomCenter,
      children: [
        // Background bar
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: kBottomNavigationBarHeight + 30,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Iconsax.home_1, 'Home', 0),
              _buildNavItem(Iconsax.heart, 'Wishlist', 1),
              const SizedBox(width: 60), // Space for floating cart
              _buildNavItem(Iconsax.search_normal_1, 'Search', 3),
              _buildNavItem(Iconsax.setting_2, 'Setting', 4),
            ],
          ),
        ),

        // Center Floating Cart Icon
        Positioned(
          bottom: 30, // Adjust this value to position the button correctly
          child: GestureDetector(
            onTap: () => onItemTapped(2),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIndex == 2
                    ? const Color(0xFFEB3030)
                    : Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: selectedIndex == 2 ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Modified _buildNavItem to show color for the selected item
  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;
    final Color itemColor = isSelected ? const Color(0xFFEB3030) : Colors.black;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: itemColor),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: itemColor, fontSize: 12)),
        ],
      ),
    );
  }
}
