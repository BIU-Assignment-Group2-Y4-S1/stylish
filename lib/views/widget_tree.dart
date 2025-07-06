import 'package:flutter/material.dart';
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
    const SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(_getAppBarTitle()),
    ),
    body: _screen[_selectedIndex],
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
    case 3:
      return 'Search';
    case 4:
      return 'Settings';
    default:
      return '';
  }
}

}
