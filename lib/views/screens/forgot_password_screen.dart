import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body);
  }

  Widget get _body {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                _welcomeText,
                SizedBox(height: 30),
                _email,
                SizedBox(height: 10),
                _forgetPassword,
                SizedBox(height: 40),
                _submitButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _submitButton {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF83758),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: () {},
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget get _forgetPassword {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: "* ",
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text:
                    "We will send you a message to set or reset\n   your new password",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _email {
    return TextFormField(
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Enter your email address",
        prefixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _welcomeText {
    return Row(
      children: [
        Text(
          "Forgot \nPassword?",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
