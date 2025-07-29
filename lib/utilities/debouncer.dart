import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration delay;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.delay});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  dispose() {
    _timer?.cancel();
  }
}