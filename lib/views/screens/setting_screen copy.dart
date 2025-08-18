import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/views/screens/signin_screen.dart';

import '../../routes/app_routes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email_user = "Unknow@gmail.com";
  String username = "Unknow";

  @override
  void initState() {
    super.initState();
    _fetchEmail(); // Call the function to fetch the email when the widget initializes
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Use SingleChildScrollView for scrollability
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _profile,
            const SizedBox(height: 20),
            _userData,
            const SizedBox(height: 30),
            _menuList,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget get _profile {
    return const CircleAvatar(radius: 60, backgroundImage: AssetImage(''));
  }

  Widget get _userData {
    return Column(
      children: [
        Text(
          "$username",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox(height: 10),
        Text(
          "$email_user",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }

  Widget get _menuList {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.person_outline,
          title: "My profile",
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.location_on_outlined,
          title: "My address",
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.shopping_bag_outlined,
          title: "My orders",
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.credit_card_outlined,
          title: "My cards",
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.settings_outlined,
          title: "Settings",
          onTap: () {},
        ),
        _buildMenuItem(icon: Icons.logout, title: "Log out", onTap: () {
          _logoutFunc();
        }),
      ],
    );
  }

  Future<void> _logoutFunc() async{
    await _auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SigninScreen()),
          (Route<dynamic> route) => false, // This condition removes ALL routes
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
      ),
    );
  }

  // Future<void> _fetchEmail() async{
  //   String? email = await _auth.currentUser?.email;
  //   if(email!=null){
  //     setState(() {
  //       email_user = email;
  //     });
  //   }
  // }
  Future<void> _fetchEmail() async {
    String? email = _auth.currentUser?.email;

    if (email != null) {
      String newUsername = _getUsername(email); // Call the dedicated function

      setState(() {
        email_user = email;
        username = newUsername;
      });
    }
  }
  String _getUsername(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex != -1) {
      return email.substring(0, atIndex);
    }
    return "User Example"; // Return a default value if '@' is not found
  }

}
