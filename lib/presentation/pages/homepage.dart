import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/common/datetime_helper.dart';
import 'package:scyject/presentation/bloc/list_project_bloc/list_project_bloc.dart';
import 'package:scyject/presentation/bloc/project_bloc/project_bloc.dart';
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
            BlocBuilder<ListProjectBloc, ListProjectState>(
              builder: (context, state) {
                if (state is ListProjectLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListProjectError) {
                  return const Center(
                    child: CustomInformation(
                        imgPath: 'assets/error.svg',
                        title: 'Ups Maaf Ada Kesalahan',
                        subtitle: 'Tunggu Sebentar ya'),
                  );
                } else if (state is ListProjectHasData) {
                  final result = state.project;

                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final project = result[index];
                        if (project == result.first) {
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
                                          project.date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.white70),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ProjectBloc>()
                                                  .add(UnsaveProject(project));
                                            },
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white70,
                                              size: 15,
                                            ))
                                      ],
                                    ),
                                    Text(
                                      project.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      project.subtitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white70),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Progress',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.white70),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      value: 0.5,
                                      valueColor:
                                          AlwaysStoppedAnimation(kYellow),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
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
                                          project.date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: kDeepBlue),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ProjectBloc>()
                                                  .add(UnsaveProject(project));
                                            },
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: kDeepBlue,
                                              size: 15,
                                            ))
                                      ],
                                    ),
                                    Text(
                                      project.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: kDeepBlue,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      project.subtitle,
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
                        }
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return const Center(
                    child: CustomInformation(
                        imgPath: 'assets/empty.svg',
                        title: 'Daftar Proyek Masih Kosong',
                        subtitle: 'Silahkan Daftarkan Proyek'),
                  );
                }
              },
            )
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
