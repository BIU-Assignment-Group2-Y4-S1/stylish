import 'package:flutter/material.dart';
import 'package:stylish_app/routes/app_routes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
  }

  Widget _body(BuildContext context) {
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
                SizedBox(height: 20),
                _password,
                SizedBox(height: 10),
                _confirmPassword,
                SizedBox(height: 10),
                _text,
                SizedBox(height: 40),
                _buttonRegister,
                SizedBox(height: 40),
                _divided,
                SizedBox(height: 40),
                _socialLogin,
                SizedBox(height: 30),
                _login(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _login(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("I Already Have an Account"),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRoute.signInScreen);
          },
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFF83758),
            textStyle: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget get _socialLogin {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF83758), width: 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset("assets/images/google-logo.png"),
        ),
        SizedBox(width: 15),
        Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF83758), width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset("assets/images/apple-black.png"),
        ),
        SizedBox(width: 15),
        Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF83758), width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset("assets/images/fb.png"),
        ),
      ],
    );
  }

  Widget get _divided {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              height: 10,
              thickness: 1,
              endIndent: 10,
              color: Color.fromARGB(255, 187, 187, 187),
            ),
          ),
          Text("OR Continue with"),
          Expanded(
            child: Divider(
              height: 10,
              thickness: 1,
              indent: 10,
              color: Color.fromARGB(255, 187, 187, 187),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buttonRegister {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF83758),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),

      onPressed: () {},
      child: Text(
        "Create Account",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget get _text {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "By clicking  the Register button, you agree \nto the public offer",
        ),
      ],
    );
  }

  Widget get _confirmPassword {
    return TextFormField(
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Confirm Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _password {
    return TextFormField(
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _email {
    return TextFormField(
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Username or Email",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _welcomeText {
    return Row(
      children: [
        Text(
          "Create an \naccount",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
