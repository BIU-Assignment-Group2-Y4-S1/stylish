import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/routes/app_routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  bool _obsecurePassword = true;
  bool _obsecureConfirmPassword = true;

  bool _isValidEmail = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(body: _body(context));
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            child: Form(
              key: _formKey,
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
            Navigator.of(context).pop(AppRoute.signInScreen);
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

      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          _registerFunc();
        }
      },
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
      controller: _confirmPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please input your Confirm Password";
        }
        return null;
      },
      obscureText: _obsecureConfirmPassword,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obsecureConfirmPassword = !_obsecureConfirmPassword;
            });
          },
          icon: Icon(_obsecureConfirmPassword ? Icons.visibility : Icons.visibility_off,),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _password {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please input your Password";
        }
        return null;
      },
      obscureText: _obsecurePassword,
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
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please input your email";
        }
        return null;
      },
      onChanged: (value) {
        if (value.contains("@")) {
          setState(() {
            _isValidEmail = true;
          });
        }
      },
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
  Future<void> _registerFunc() async {
    // String fullName = _fullNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
      return; // Stop the function from executing further
    }

    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
            Navigator.of(context).pushReplacementNamed(AppRoute.signInScreen);
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          });
    } catch (error) {
      print("Error: $error");
    }
  }
}
