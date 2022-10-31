import 'package:flutter/material.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/presentation/screen/profilescreen.dart';

class DetailScreen extends StatefulWidget {
  static const route_name = '/detail';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final nameActivity = TextEditingController();
  final descActivity = TextEditingController();
  final deadlineActivity = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameActivity.dispose();
    descActivity.dispose();
    deadlineActivity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Proyek',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text('Daftar Kegiatan'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Nama Kegiatan',
                                icon: Icon(Icons.checklist),
                              ),
                              controller: nameActivity,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Deskripsi',
                                icon: Icon(Icons.short_text_sharp),
                              ),
                              controller: descActivity,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Deskripsi tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Tenggat Waktu',
                                icon: Icon(Icons.access_time),
                              ),
                              controller: deadlineActivity,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tenggat waktu tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Tambah',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: const Center(
        child: CustomInformation(
            imgPath: 'assets/empty.svg',
            title: 'Daftar Kegiatan Masih Kosong',
            subtitle: 'Daftarkan kegiatan anda'),
      ),
    );
  }
}
