import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/presentation/bloc/list_project_bloc/list_project_bloc.dart';
import 'package:scyject/presentation/bloc/project_bloc/project_bloc.dart';
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
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
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
      ),
    );
  }
}
