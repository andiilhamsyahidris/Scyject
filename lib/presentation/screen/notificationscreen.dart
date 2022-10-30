import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scyject/presentation/screen/profilescreen.dart';

class NotificationScreen extends StatelessWidget {
  static const route_name = '/notification';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: const Center(
        child: Text('Halaman notifikasi'),
      ),
    );
  }
}
