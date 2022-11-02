import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/presentation/screen/detailscreen.dart';
import 'package:scyject/presentation/screen/notificationscreen.dart';
import 'package:scyject/presentation/screen/profilescreen.dart';

class ProjectPage extends StatelessWidget {
  static const route_name = '/project';

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Proyek',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: kDeepBlue),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('project')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DetailScreen.route_name);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: kSmoothBlue,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.docs[index]['date'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: kDeepBlue),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            final docProject = FirebaseFirestore
                                                .instance
                                                .collection('project')
                                                .doc(data.docs[index]['id']);

                                            docProject.delete();
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: kDeepBlue,
                                            size: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      data.docs[index]['title'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: kDeepBlue,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      data.docs[index]['subtitle'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: kDeepBlue),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Progress',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: kDeepBlue),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      value: 0.5,
                                      valueColor:
                                          AlwaysStoppedAnimation(kDarkBlue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: data.docs.length,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
