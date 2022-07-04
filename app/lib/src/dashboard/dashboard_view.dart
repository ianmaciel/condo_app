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

import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'camera_listview.dart';
import '../bottom_navigation/bottom_navigation_controller.dart';
import '../settings/settings_view.dart';
import '../camera/camera_model.dart';

/// Displays a list of SampleItems.
class DashboardView extends StatelessWidget implements PageModel {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  final String routeName = '/dashboard';
  // TODO: translate
  @override
  final String routeTitle = 'Painel';
  @override
  final BottomNavigationBarItem navigationButton =
      const BottomNavigationBarItem(
    icon: Icon(Icons.camera_alt),
    // TODO: translate
    label: 'Painel',
  );

  @override
  Widget build(BuildContext context) => FirestoreBuilder<CameraQuerySnapshot>(
        ref: camerasRef
            .whereEnabled(isEqualTo: true)
            .orderByPriority()
            .orderByName(),
        builder: (context, AsyncSnapshot<CameraQuerySnapshot> snapshot,
            Widget? child) {
          if (snapshot.hasError) {
            FirebaseException error = snapshot.error as FirebaseException;
            if (error.code == 'permission-denied') {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    // TODO: translate
                    'Seu usuário não possui permissão para acessar o aplicativo.',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return Center(
              child:
                  // TODO: translate
                  SelectableText(
                      'Erro inesperado!\n\n${snapshot.error.toString()}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Access the QuerySnapshot
          CameraQuerySnapshot querySnapshot = snapshot.requireData;

          return CameraListView(cameras: querySnapshot.docs);
        },
      );

  @override
  Widget? getFloatingButton(BuildContext context) => null;
}
