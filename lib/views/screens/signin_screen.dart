import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:stylish_app/routes/app_routes.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  bool _obsecurePassword = true;
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
                  _forgetPassword(context),
                  SizedBox(height: 30),
                  _buttonLogin,
                  SizedBox(height: 40),
                  _divided,
                  SizedBox(height: 40),
                  _socialLogin,
                  SizedBox(height: 30),
                  _signUp(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Craete An Account"),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoute.signUpScreen);
          },
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFF83758),
            textStyle: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
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
          child: GestureDetector(
            child: Image.asset("assets/images/fb.png"),
            onTap: () {
              _facebookSignin();
            },
          ),
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

  Widget get _buttonLogin {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF83758),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),

      onPressed: () {
        _loginFunc();
      },
      child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Widget _forgetPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoute.forgotPasswordScreen),
          child: Text("Forgot Password?", style: TextStyle(color: Colors.red)),
        ),
      ],
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
        suffix: !_isValidEmail
            ? Icon(Icons.check_circle_rounded)
            : Icon(Icons.check_circle_rounded, color: Colors.green),
        labelText: "Email",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _welcomeText {
    return Row(
      children: [
        Text(
          "Welcome \nBack!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> _facebookSignin() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential credential = FacebookAuthProvider.credential(
        result.accessToken!.tokenString,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushReplacementNamed(AppRoute.widgetTree);
    } else {
      print(result.message);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("${result.message}")));
    }
  }

  _loginFunc() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Login successful!'); // Add this line
      Navigator.of(context).pushReplacementNamed(AppRoute.widgetTree);
    } on FirebaseAuthException catch (e) {
      print('Login failed with Firebase error: $e'); // Add this line
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An unknown error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('Login failed with a general error: $e'); // Add this line
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unknown error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
