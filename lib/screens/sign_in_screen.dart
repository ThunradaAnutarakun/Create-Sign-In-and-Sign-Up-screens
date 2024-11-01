import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist_app/components/my_textfromfield.dart';
import 'package:todolist_app/constant/constant.dart';
import 'package:todolist_app/screens/sign_up_screen.dart';
import 'package:todolist_app/screens/home_page.dart'; // นำเข้า HomePage

import '../components/my_button.dart';
import '../components/my_icon_btn.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final String txtMsg = '';

  void _showDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amber,
          title: const Text('Sign In'),
          content: Text(txtMsg),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('OK')),
          ],
        );
      },
    );
  }

  //Function signInUser()
  void signInUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // นำทางไปยัง HomePage เมื่อล็อกอินสำเร็จ
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      _showDialog('Login successfully');
    } on FirebaseAuthException catch (e) {
      _showDialog("Failed to login: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 80, 15, 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(
                  'Hello, Monday!',
                  style: textTitle,
                ),
                const SizedBox(height: 15),
                Text(
                  'Please sign-in with your email and password.',
                  style: textSubTitle,
                ),
                const SizedBox(height: 20),
                MyTextFormField(
                    controller: emailController,
                    obscureText: false,
                    labelText: 'Email',
                    hintText: 'Enter your email', validator: (value) {
                      return null;
                      },),
                const SizedBox(height: 20),
                MyTextFormField(
                    controller: passwordController,
                    obscureText: true,
                    labelText: 'Password',
                    hintText: 'Enter your password', validator: (value) {
                      return null;
                      },),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: GoogleFonts.lato(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                MyButton(
                  onTap: signInUser,
                  hinText: 'Sign In',
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey),
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyIconBtn(imagePath: 'assets/images/google_icon.png'),
                    SizedBox(width: 30),
                    MyIconBtn(imagePath: 'assets/images/ios_icon.png'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Register now.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}