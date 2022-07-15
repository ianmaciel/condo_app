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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../bottom_navigation/condo_app_user_model.dart';

class UserController with ChangeNotifier {
  final Completer<void> _completer = Completer<void>();
  bool isLoading = true;
  CondoAppUser? user;
  Future<void> get initialization => _completer.future;
  late StreamSubscription<User?> _firebaseAuthStreamSubscription;

  bool get isAdmin => user?.isAdmin() ?? false;
  bool get isResident => user?.isResident() ?? false;
  bool get isGuest => user?.isGuest() ?? true;
  String? get uid => user?.firebaseUser?.uid;

  UserController() {
    _firebaseAuthStreamSubscription =
        FirebaseAuth.instance.authStateChanges().listen(_onFirebaseAuthData);
  }

  Future<void> loadUserController() async {
    user = await CondoAppUser.fromFirebaseUser();
    isLoading = false;
    if (!_completer.isCompleted) {
      _completer.complete();
    }
    notifyListeners();
  }

  void _onFirebaseAuthData(User? user) {
    isLoading = true;
    notifyListeners();

    if (user != null) {
      loadUserController();
    }
  }

  @override
  void dispose() {
    _firebaseAuthStreamSubscription.cancel();
    super.dispose();
  }
}
