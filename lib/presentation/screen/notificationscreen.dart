import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scyject/common/custom_information.dart';

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
        child: CustomInformation(
            imgPath: 'assets/empty.svg',
            title: 'Notifikasi Masih Kosong',
            subtitle: ''),
      ),
    );
  }
}
