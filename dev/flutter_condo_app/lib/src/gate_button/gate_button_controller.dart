import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

class GateButtonController with ChangeNotifier {
  bool loading = false;

  FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<void> toggleCarGate() async {
    HttpsCallableResult result =
        await FirebaseFunctions.instance.httpsCallable('toggleCarGate').call();
  }

  void onPressed() async {
    loading = false;
    notifyListeners();

    await toggleCarGate();
    loading = false;
    notifyListeners();
  }
}
