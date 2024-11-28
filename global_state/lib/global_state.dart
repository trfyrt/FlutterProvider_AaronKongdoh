library global_state;

import 'package:flutter/material.dart';

class GlobalState with ChangeNotifier {
  List<int> _counters = [];

  List<int> get counters => _counters;

  void addCounter() {
    _counters.add(0);
    notifyListeners();
  }

  void removeCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters.removeAt(index);
      notifyListeners();
    }
  }

  void incrementCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters[index]++;
      notifyListeners();
    }
  }

  void decrementCounter(int index) {
    if (index >= 0 && index < _counters.length && _counters[index] > 0) {
      _counters[index]--;
      notifyListeners();
    }
  }
}
