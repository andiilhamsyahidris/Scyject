import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/datetime_helper.dart';
import 'package:scyject/presentation/screen/detailscreen.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hai Ilham!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600, color: kDeepBlue),
            ),
            timeNow(),
            _buildDashboard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Proyek',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: kDeepBlue, fontWeight: FontWeight.w600),
                ),
              ],
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
    );
  }

  SizedBox timeNow() {
    var time = DatetimeHelper.dateTimeScheduled();
    if (time.hour >= 6 && time.hour < 10) {
      return SizedBox(
        child: Text(
          'Selamat Pagi',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    } else if (time.hour >= 10 && time.hour < 15) {
      return SizedBox(
        child: Text(
          'Selamat Siang',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    } else if (time.hour >= 15 && time.hour < 18) {
      return SizedBox(
        child: Text(
          'Selamat Sore',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    } else {
      return SizedBox(
        child: Text(
          'Selamat Malam',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }
  }

  Container _buildDashboard() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black87),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selamat Datang!',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: kDeepBlue, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Jadwalkan Proyek Anda',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Flexible(
            child: SvgPicture.asset(
              'assets/dashboard.svg',
              height: 110,
            ),
          ),
        ],
      ),
    );
  }
}
