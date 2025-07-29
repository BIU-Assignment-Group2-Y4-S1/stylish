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
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,

      destinations: [
        const NavigationDestination(
          icon: Icon(Iconsax.home_1, color: Colors.black),
          label: 'Home',
        ),
        const NavigationDestination(
          icon: Icon(Iconsax.heart, color: Colors.black),
          label: 'Wishlist',
        ),
        // float cart button
        const NavigationDestination(icon: SizedBox.shrink(), label: ''),
        const NavigationDestination(
          icon: Icon(Iconsax.search_favorite_1, color: Colors.black),
          label: 'Search',
        ),
        const NavigationDestination(
          icon: Icon(Iconsax.setting, color: Colors.black),
          label: 'Setting',
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return NavigationBar(
  //     selectedIndex: selectedIndex,
  //     onDestinationSelected: onItemTapped,
  //     destinations: const [
  //       NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
  //       NavigationDestination(
  //         icon: Icon(Icons.favorite_border),
  //         label: 'Wishlist',
  //       ),
  //       NavigationDestination(
  //         icon: Icon(Icons.shopping_cart_outlined),
  //         label: 'Cart',
  //       ),
  //       NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
  //       NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
  //     ],
  //   );
  // }
}
