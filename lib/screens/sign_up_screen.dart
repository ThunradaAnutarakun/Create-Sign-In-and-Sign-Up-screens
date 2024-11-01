import 'package:flutter/material.dart';
import 'package:todolist_app/components/my_button.dart';
import 'package:todolist_app/components/my_textfield.dart';
import 'package:todolist_app/constant/constant.dart';
import 'package:todolist_app/screens/sign_in_screen.dart';
import 'package:todolist_app/screens/home_page.dart'; // นำเข้า HomePage

import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final re_passwordController = TextEditingController();

  final String txtMsg = '';

  void _showDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amber,
          title: const Text('Sign Up'),
          content: Text(txtMsg),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('OK')),
          ],
        );
      },
    );
  }

  void signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // นำทางไปยัง HomePage เมื่อลงทะเบียนสำเร็จ
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

      _showDialog('Signup successfully!');
    } on FirebaseAuthException catch (e) {
      _showDialog('Failed to Signup: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to KMUTNB community',
                style: textTitle,
              ),
              const SizedBox(height: 20),
              Text(
                'To get started, please create an account.',
                style: textSubTitle,
              ),
              const SizedBox(height: 30),
              MyTextField(
                controller: nameController,
                hintText: 'Enter your name',
                obscureText: false,
                labelText: 'Name',
              ),
              const SizedBox(height: 30),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your Email',
                obscureText: false,
                labelText: 'Email',
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your Password',
                obscureText: true, // ควรเป็น true เพื่อซ่อนรหัสผ่าน
                labelText: 'Password',
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: re_passwordController,
                hintText: 'Enter your Password again',
                obscureText: true, // ควรเป็น true เพื่อซ่อนรหัสผ่าน
                labelText: 'Re-password',
              ),
              const SizedBox(height: 30),
              MyButton(onTap: signUp, hinText: 'Register now'),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have a member?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}