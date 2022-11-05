import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/data/models/activity_model.dart';

class DetailScreen extends StatefulWidget {
  static const route_name = '/detail';
  final String id;

  const DetailScreen({required this.id});

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
                        key: _formkey,
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
                                  final act = ActivityModel(
                                      title: nameActivity.text,
                                      date: deadlineActivity.text,
                                      value: false);

                                  if (_formkey.currentState!.validate()) {
                                    createActivity(act);
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
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('project')
            .doc(widget.id)
            .collection('activity')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;

            return ListView.builder(
              itemBuilder: (context, index) {
                var valu = data.docs[index]['value'];
                return Slidable(
                  groupTag: 1,
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          final docAct = FirebaseFirestore.instance
                              .collection('project')
                              .doc(widget.id)
                              .collection('activity')
                              .doc(data.docs[index]['id']);
                          docAct.delete();
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                  child: CheckboxListTile(
                    activeColor: kDeepBlue,
                    dense: true,
                    title: Text(
                      data.docs[index]['title'],
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      data.docs[index]['date'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    value: valu,
                    onChanged: (value) {
                      setState(() {
                        valu = value as bool;
                      });
                    },
                    side: const BorderSide(color: kDeepBlue),
                  ),
                );
              },
              itemCount: data.docs.length,
            );
          }
          return const Center(
            child: CustomInformation(
                imgPath: 'assets/empty.svg',
                title: 'Belum ada kegiatan nih',
                subtitle: 'Tambahkan dulu ya'),
          );
        },
      ),
    );
  }

  Future createActivity(ActivityModel activityModel) async {
    final docActivity = FirebaseFirestore.instance
        .collection('project')
        .doc(widget.id)
        .collection('activity')
        .doc();
    activityModel.id = docActivity.id;
    final json = activityModel.toJson();
    await docActivity.set(json);
  }
}
