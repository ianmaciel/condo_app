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
import 'package:condo_app/src/camera/camera_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../settings/settings_view.dart';
import '../gate_button/ewelink_button.dart';

/// Displays a list of SampleItems.
class DashboardView extends StatefulWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final List<VlcPlayerController> _vlcControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: FirestoreBuilder<CameraQuerySnapshot>(
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
                    'Seu usuário não possui permissão para acessar o aplicativo.',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return const Text('Something went wrong!');
          }
          if (!snapshot.hasData) {
            return const Text('Loading cameras...');
          }

          // Access the QuerySnapshot
          CameraQuerySnapshot querySnapshot = snapshot.requireData;

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.blueGrey,
                  height: 75,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: EwelinkButton(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: querySnapshot.docs.length,
                    itemBuilder: (context, index) {
                      // Access the User instance
                      Camera camera = querySnapshot.docs[index].data;
                      VlcPlayerController controller =
                          VlcPlayerController.network(
                        camera.url,
                        autoInitialize: true,
                        autoPlay: true,
                      );
                      _vlcControllers.add(controller);

                      return Column(
                        children: [
                          VlcPlayer(
                            controller: controller,
                            aspectRatio: 16 / 9,
                            placeholder: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Text(camera.name)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
