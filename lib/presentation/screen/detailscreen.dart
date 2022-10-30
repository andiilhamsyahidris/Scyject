import 'package:flutter/material.dart';
import 'package:scyject/presentation/screen/profilescreen.dart';

class DetailScreen extends StatefulWidget {
  static const route_name = '/detail';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Proyek',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: const Center(
        child: Text('Halaman detail'),
      ),
    );
  }
}
