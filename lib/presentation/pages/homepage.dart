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
                                            .copyWith(color: Colors.white54),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          final docProject = FirebaseFirestore
                                              .instance
                                              .collection('project')
                                              .doc(data.docs[index]['id']);

                                          docProject.delete();
                                          const snackBar = SnackBar(
                                            content: Text(
                                              'Data berhasil dihapus',
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                            backgroundColor: kYellow,
                                            duration:
                                                Duration(milliseconds: 2000),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);
                                        },
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
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
                                            color: Colors.white,
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
                                        .copyWith(color: Colors.white54),
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
