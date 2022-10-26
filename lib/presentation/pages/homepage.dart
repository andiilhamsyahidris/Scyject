import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/common/datetime_helper.dart';
import 'package:scyject/domain/entities/project.dart';
import 'package:scyject/presentation/bloc/list_project_bloc/list_project_bloc.dart';
import 'package:scyject/presentation/bloc/project_bloc/project_bloc.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final nameProject = TextEditingController();
  final descProject = TextEditingController();
  final deadlineProject = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ListProjectBloc>().add(FetchListProject()),
    );
  }

  @override
  void dispose() {
    nameProject.dispose();
    descProject.dispose();
    deadlineProject.dispose();
    super.dispose();
  }

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
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: _buildMainPage(),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
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

  SingleChildScrollView _buildMainPage() {
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
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'selengkapnya',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
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
                        return Card(
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
                                  ]),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      project.date ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white70),
                                    ),
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.white70,
                                      size: 18,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: Text(
                                    project.title ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  project.subtitle ?? '',
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
                                  valueColor: AlwaysStoppedAnimation(kYellow),
                                ),
                              ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nama Proyek',
                          icon: Icon(Icons.folder),
                        ),
                        controller: nameProject,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          icon: Icon(Icons.short_text_sharp),
                        ),
                        controller: descProject,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tenggat Waktu',
                          icon: Icon(Icons.access_time),
                        ),
                        controller: deadlineProject,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            var project = Project(
                                title: nameProject.text,
                                subtitle: descProject.text,
                                date: deadlineProject.text);
                            context.read<ProjectBloc>().add(
                                  InsertProject(project),
                                );
                            print(project);
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

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
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
    );
  }
}
