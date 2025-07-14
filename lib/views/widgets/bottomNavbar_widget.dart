import 'package:flutter/material.dart';

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
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      destinations: [
        const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        const NavigationDestination(
          icon: Icon(Icons.favorite_border),
          label: 'Wishlist',
        ),
        NavigationDestination(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          label: '',
        ),
        const NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        const NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
    );
  }
}
