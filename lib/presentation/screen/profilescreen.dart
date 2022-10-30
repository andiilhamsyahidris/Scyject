import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/presentation/bloc/list_project_bloc/list_project_bloc.dart';
import 'package:scyject/presentation/bloc/project_bloc/project_bloc.dart';
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
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final project = result[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DetailScreen.route_name);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 40,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
