import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าแรก'),
      ),
      body: const Center(
        child: Text('Welcome To My app NaKa !'),
      ),
    );
  }
}