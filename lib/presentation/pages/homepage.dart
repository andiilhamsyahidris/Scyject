import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/custom_information.dart';
import 'package:scyject/common/datetime_helper.dart';
import 'package:scyject/presentation/bloc/list_project_bloc/list_project_bloc.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ListProjectBloc>().add(FetchListProject()),
    );
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
    if (time.hour > 6 && time.hour < 10) {
      return SizedBox(
        child: Text(
          'Selamat Pagi',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    } else if (time.hour > 10 && time.hour < 15) {
      return SizedBox(
        child: Text(
          'Selamat Siang',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    } else if (time.hour > 15 && time.hour < 18) {
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
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          icon: Icon(Icons.short_text_sharp),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tenggat Waktu',
                          icon: Icon(Icons.access_time),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {},
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
      backgroundColor: kDeepBlue,
      child: const Icon(Icons.add),
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
