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

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

import 'package:dart_ewelink_api/dart_ewelink_api.dart';

import 'ewelink_config_model.dart';

class EwelinkButtonController with ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;
  bool get isNotloading => !_loading;
  late EwelinkConfigModelDocumentReference documentReference;
  EwelinkConfigModel? _ewelinkConfig;
  Ewelink? ewelinkApi;

  void init() {
    documentReference = configsRef.doc('ewelinkConnection');
    documentReference.get().then(onLoaded);
  }

  void onLoaded(EwelinkConfigModelDocumentSnapshot value) {
    _ewelinkConfig = value.data;
    _loading = false;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> toggleCarGate() async {
    if (_ewelinkConfig == null) {
      // TODO: provider a proper error message.
      return;
    }

    if (kIsWeb) {
      await FirebaseFunctions.instance.httpsCallable('toggleCarGate').call();
    } else {
      ewelinkApi = await getEwelinkApi();
    }

    // Toogle device by its id
    try {
      // TODO change device id. Remove hardcoded id, read from firestore.
      await ewelinkApi!
          .setDevicePowerState(deviceId: '10000ffeb5', state: 'on');
    } on EwelinkInvalidAccessToken {
      _ewelinkConfig!.auth = null;
      ewelinkApi = await getEwelinkApi(recreate: true);
      await ewelinkApi!
          .setDevicePowerState(deviceId: '10000ffeb5', state: 'on');
    }
  }

  void onPressed() async {
    setLoading(true);
    await toggleCarGate();
    // Add extra three seconds to make sure it is greater than the camera delay
    await Future.delayed(const Duration(seconds: 3));
    setLoading(false);
  }

  Future<Ewelink> getEwelinkApi({bool recreate = false}) async {
    if (_ewelinkConfig == null) {
      throw Exception('Ewelink config is null');
    }

    if (ewelinkApi == null || recreate) {
      if (_hasValidEwelinkToken) {
        ewelinkApi = Ewelink.fromToken(credentials: _ewelinkConfig!.auth!);
        return ewelinkApi!;
      }

      if (_hasValidUserAndPassword) {
        return updateCredentials();
      }

      throw Exception('Invalid ewelink config: ${_ewelinkConfig.toString()}');
    }
    return ewelinkApi!;
  }

  Future<Ewelink> updateCredentials() async {
    ewelinkApi = Ewelink.fromPassword(
        email: _ewelinkConfig!.email,
        password: _ewelinkConfig!.password,
        region: _ewelinkConfig!.region);
    EwelinkCredentials credentials = await ewelinkApi!.getCredentials();
    _ewelinkConfig!.auth = credentials;
    documentReference.set(_ewelinkConfig!);
    return ewelinkApi!;
  }

  bool get _hasValidEwelinkToken => _ewelinkConfig!.auth != null;
  bool get _hasValidUserAndPassword =>
      _ewelinkConfig!.email.isNotEmpty &&
      _ewelinkConfig!.password.isNotEmpty &&
      _ewelinkConfig!.region.isNotEmpty;
}
