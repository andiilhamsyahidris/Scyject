import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/presentation/screen/detailscreen.dart';
import 'package:scyject/presentation/screen/notificationscreen.dart';

class ProfileScreen extends StatelessWidget {
  static const route_name = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NotificationScreen.route_name);
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3 - 40,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        kDeepBlue,
                        kDarkBlue,
                        kVeryDarkBlue,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Icon(
                        Icons.account_circle,
                        size: 104,
                        color: kSmoothBlue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ilhamsyah',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: kSmoothBlue),
                      ),
                      Text(
                        'Flutter Enthusiast',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: kSmoothBlue.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Proyek',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: kDeepBlue, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
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
                        controller: ScrollController(keepScrollOffset: true),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailScreen.route_name,
                                arguments: data.docs[index]['id'],
                              );
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
                                          .titleLarge!
                                          .copyWith(
                                              color: kDeepBlue,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      data.docs[index]['subtitle'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: kDeepBlue),
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
