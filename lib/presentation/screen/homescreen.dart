import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/data/models/project_table.dart';
import 'package:scyject/presentation/pages/homepage.dart';
import 'package:scyject/presentation/pages/project_page.dart';
import 'package:scyject/presentation/provider/bottom_nav_provider.dart';
import 'package:scyject/presentation/screen/notificationscreen.dart';
import 'package:scyject/presentation/screen/profilescreen.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final nameProject = TextEditingController();
  final descProject = TextEditingController();
  final deadlineProject = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameProject.dispose();
    descProject.dispose();
    deadlineProject.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [Homepage(), ProjectPage()];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, bottomNavProvider, child) {
        final currentIndex = bottomNavProvider.index;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: currentIndex == 0
              ? _buildScaffoldBody(bottomNavProvider)
              : _buildBody(currentIndex),
          floatingActionButton: _buildFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _buildBottomNav(bottomNavProvider),
        );
      },
    );
  }

  Scaffold _buildScaffoldBody(BottomNavProvider bottomNavProvider) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.all_out),
        title: const Text(
          'Scyject',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NotificationScreen.route_name);
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.route_name);
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: _buildBody(bottomNavProvider.index),
    );
  }

  Widget _buildBody(int index) => _pages[index];

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Daftar'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     labelText: 'Nomor',
                      //     icon: Icon(Icons.access_time),
                      //   ),
                      //   controller: deadlineProject,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Nomor tidak boleh kosong';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nama Proyek',
                          icon: Icon(Icons.folder),
                        ),
                        controller: nameProject,
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
                        controller: descProject,
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
                        controller: deadlineProject,
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
                            final proj = ProjectTable(
                                title: nameProject.text,
                                subtitle: descProject.text,
                                date: deadlineProject.text);
                            // var project = Project(
                            //     // id: nomorProject.text,
                            //     title: nameProject.text,
                            //     subtitle: descProject.text,
                            //     date: deadlineProject.text);

                            if (_formKey.currentState!.validate()) {
                              createProject(proj);
                              Navigator.pop(context);
                            }
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
      backgroundColor: kSmoothBlue,
      child: const Icon(
        Icons.add,
        color: kDeepBlue,
      ),
    );
  }

  Future createProject(ProjectTable projectTable) async {
    final docProject = FirebaseFirestore.instance.collection('project').doc();
    projectTable.id = docProject.id;
    final json = projectTable.toJson();
    await docProject.set(json);
  }

  BottomNavigationBar _buildBottomNav(BottomNavProvider bottomNavProvider) {
    return BottomNavigationBar(
      currentIndex: bottomNavProvider.index,
      backgroundColor: Colors.white,
      selectedItemColor: kDeepBlue,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedFontSize: 12,
      iconSize: 32,
      unselectedItemColor: Colors.black45,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_numbered_rounded),
          label: 'Proyek',
        ),
      ],
      onTap: (index) {
        bottomNavProvider.index = index;
        switch (index) {
          case 0:
            bottomNavProvider.title = 'Home';
            break;
          case 1:
            bottomNavProvider.title = 'Project';
            break;
        }
      },
    );
  }
}
