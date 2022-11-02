import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scyject/common/constant.dart';
import 'package:scyject/common/utils.dart';
import 'package:scyject/firebase_options.dart';
import 'package:scyject/presentation/provider/bottom_nav_provider.dart';
import 'package:scyject/presentation/screen/detailscreen.dart';
import 'package:scyject/presentation/screen/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:scyject/injection.dart' as di;
import 'package:scyject/presentation/screen/notificationscreen.dart';
import 'package:scyject/presentation/screen/profilescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavProvider>(
          create: (_) => BottomNavProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData().copyWith(colorScheme: kColorScheme),
        home: Homescreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => Homescreen());
            case DetailScreen.route_name:
              return MaterialPageRoute(builder: (_) => DetailScreen());
            case ProfileScreen.route_name:
              return MaterialPageRoute(builder: (_) => ProfileScreen());
            case NotificationScreen.route_name:
              return MaterialPageRoute(builder: (_) => NotificationScreen());
          }
        },
      ),
    );
  }
}
