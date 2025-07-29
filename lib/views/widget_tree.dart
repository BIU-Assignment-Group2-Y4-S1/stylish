import 'package:flutter/material.dart';
import 'package:stylish_app/views/screens/shoppage_screen.dart';
import 'package:stylish_app/views/screens/wishlist_screen.dart';
import 'package:stylish_app/views/screens/setting_screen.dart';
import 'package:stylish_app/views/widgets/bottomNavbar_widget.dart';
import 'package:stylish_app/views/screens/home_screen.dart';
import 'package:stylish_app/views/screens/search_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    const HomeScreen(),
    const WishlistScreen(),
    const ShoppageScreen(),
    const SearchScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 || _selectedIndex == 1
          ? null // 🔴 Disable AppBar on HomeScreen
          : AppBar(
              title: Text(
                _getAppBarTitle(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: Icon(Icons.arrow_back_ios_outlined),
            ),
      // appBar: AppBar(
      //   title: Text(
      //     _getAppBarTitle(),
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   leading: Icon(Icons.arrow_back_ios_outlined),
      // ),
      body: _screen[_selectedIndex],
      floatingActionButton: Transform.translate(
        offset: Offset(0, 16), // Move down by 16 pixels (adjust as needed)
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.white,
          elevation: 6,
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.black,
            size: 28,
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ShoppageScreen()),
            // );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomnavbarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Wishlist';
      case 2:
        return 'Cart';
      case 3:
        return 'Search';
      case 4:
        return 'Setting';
      default:
        return '';
    }
  }
}
