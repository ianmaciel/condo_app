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

import '../qrcode_scanner/qrcode_result_model.dart';
import '../qrcode_scanner/qrcode_scanner.dart';
import '../user/user_controller.dart';
import '../virtual_key/virtual_key_model.dart';

class GuestController with ChangeNotifier {
  VirtualKey? virtualKey;
  bool _loading = true;
  String error = '';
  UserController userController;
  bool hasKeyInParameters = false;
  late StreamSubscription<User?> _firebaseAuthStreamSubscription;

  GuestController(this.userController) {
    _firebaseAuthStreamSubscription =
        FirebaseAuth.instance.authStateChanges().listen(_onFirebaseAuthData);
  }

  bool get isLoading => _loading;
  bool get hasVirtualKey => !_loading && error.isEmpty && virtualKey != null;
  bool get hasError => error.isNotEmpty;

  Future<void> loadUserKeys() async {
    if (!hasKeyInParameters) {
      VirtualKeyQuery query = virtualKeysRef.whereAllowedUsers(
          arrayContainsAny: [userController.uid]).whereEnable(isEqualTo: true);
      VirtualKey? virtualKey = await _getFirsValidKey(query);
      if (virtualKey != null) {
        this.virtualKey = virtualKey;
      }
    }
    _loading = false;
    notifyListeners();
  }

  Future<VirtualKey?> _getFirsValidKey(VirtualKeyQuery query) async {
    VirtualKeyQuerySnapshot snapshots = await query.get();
    if (snapshots.docs.isEmpty) {
      return null;
    }

    // TODO: here we might have a bug: if the key is about to expire, lets say
    //       in 10 seconds, the user will receive a key but he won't be able to
    //       use it. Ideally we should test look for the "best key", which means
    //       the one that will be valid for a longer time.
    return snapshots.docs
        .where(
            (VirtualKeyQueryDocumentSnapshot element) => element.data.isValid())
        .first
        .data;
  }

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
    hasKeyInParameters = true;
    FirebaseFunctions.instance
        .httpsCallable('getVirtualKey')
        .call({
          'token': token,
          'id': virtuaKeyId,
        })
        .then((HttpsCallableResult result) => _onKeyLoaded(result, virtuaKeyId))
        .onError(_onError);
  }

  void _onKeyLoaded(HttpsCallableResult result, String virtuaKeyId) {
    virtualKey = VirtualKey.fromJson(result.data);
    _loading = false;
    notifyListeners();
  }

  void _onError(dynamic error, dynamic stackTrace) {
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
    //    .onError(_onError);
  }

  Future<void> openQrCodeReader(BuildContext context) async {
    Navigator.push<QRCodeResult?>(
      context,
      MaterialPageRoute(
        builder: (context) => const QRCodeScannerView(),
      ),
    ).then(_onQRCodeRead);
  }

  void _onQRCodeRead(QRCodeResult? qrcode) async {
    if (_qrCodeHasError(qrcode)) {
      // TODO: translate text
      _onError(qrcode?.error ?? 'Erro inexperado ao ler o QRCode', null);
      return;
    }
    if (!_validateQRCodeValue(qrcode!)) {
      // TODO: translate text
      _onError(
          'QRCode inválido, verifique se você está no portão correto.', null);
      return;
    }
    _openGateWithKey(qrcode.code);
  }

  bool _validateQRCodeValue(QRCodeResult qrcode) {
    // TODO: remove this hardcoded value. Each door should have its own code.
    return qrcode.code == 'xDDI3l4iQzn';
  }

  void _openGateWithKey(String qrcode) {
    _loading = true;
    notifyListeners();

    FirebaseFunctions.instance
        .httpsCallable('openGateWithKey')
        .call({
          'id': virtualKey!.id!,
          'token': virtualKey!.token,
          'qrcode': qrcode,
        })
        .then(_onOpenGateResult)
        .onError(_onError);
  }

  Future<void> _onOpenGateResult(HttpsCallableResult result) async {
    await Future.delayed(const Duration(seconds: 5));
    _loading = false;
    notifyListeners();
  }

  bool _qrCodeHasError(QRCodeResult? qrcode) =>
      qrcode == null || qrcode.hasError;

  @override
  void dispose() {
    _firebaseAuthStreamSubscription.cancel();
    super.dispose();
  }
}
