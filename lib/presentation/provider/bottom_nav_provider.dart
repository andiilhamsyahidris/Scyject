import 'package:flutter/cupertino.dart';

class BottomNavProvider extends ChangeNotifier {
  int _index = 0;
  String _title = 'Home';

  int get index => _index;
  String get title => _title;

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  set title(String value) {
    _title = value;
    notifyListeners();
  }
}
