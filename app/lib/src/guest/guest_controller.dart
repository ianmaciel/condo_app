// MIT License
//
// Copyright (c) 2022 Ian Koerich Maciel
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'dart:async';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../virtual_key/virtual_key_model.dart';

class GuestController with ChangeNotifier {
  VirtualKey? virtualKey;
  bool _loading = true;
  String error = '';
  late StreamSubscription<User?> _firebaseAuthStreamSubscription;

  GuestController() {
    _firebaseAuthStreamSubscription =
        FirebaseAuth.instance.authStateChanges().listen(_onFirebaseAuthData);
  }

  bool get isLoading => _loading;
  bool get hasVirtualKey => !_loading && error.isEmpty && virtualKey != null;
  bool get hasError => error.isNotEmpty;

  void loadKeyByUrlParameters(String route) {
    final Uri settingsUri = Uri.parse(route);
    final String? virtuaKeyId = settingsUri.queryParameters['k'];
    final String? token = settingsUri.queryParameters['t'];

    if (virtuaKeyId == null || token == null) {
      // TODO: translate
      error = 'Chave inválida';
      notifyListeners();
      return;
    }
    FirebaseFunctions.instance
        .httpsCallable('getVirtualKey')
        .call({
          'token': token,
          'id': virtuaKeyId,
        })
        .then(onKeyLoaded)
        .onError(_onFirebaseError);
  }

  void onKeyLoaded(HttpsCallableResult result) {
    virtualKey = VirtualKey.fromJson(result.data);
    _loading = false;
    notifyListeners();
  }

  void _onFirebaseError(dynamic error, dynamic stackTrace) {
    this.error = error.toString();
    notifyListeners();
    log(error.toString());
  }

  void _onFirebaseAuthData(User? user) {
    if (user != null && hasVirtualKey) {
      _addCurrentUserToKey(user, virtualKey!);
    }
  }

  void _addCurrentUserToKey(User user, VirtualKey virtualKey) {
    // TODO: save key on user account after login.
    //       it might be already on guest controller.
    //FirebaseFunctions.instance
    //    .httpsCallable('addUserToKey')
    //    .call({
    //      'userId': user.uid,
    //      'userEmail': user.email,
    //      'virtualKey': virtualKey.toJson(),
    //    })
    //    .then(onKeyLoaded)
    //    .onError(_onFirebaseError);
  }

  @override
  void dispose() {
    _firebaseAuthStreamSubscription.cancel();
    super.dispose();
  }
}
