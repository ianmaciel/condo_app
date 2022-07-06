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

import 'package:flutter/material.dart';

import 'package:flutter_vlc_player/flutter_vlc_player.dart'
    if (dart.library.html) 'platform_compatible_vlc.dart';

import '../gate_button/ewelink_button.dart';
import '../camera/camera_model.dart';

class CameraListView extends StatelessWidget {
  CameraListView({required this.cameras, key}) : super(key: key);
  final List<CameraQueryDocumentSnapshot> cameras;
  final List<VlcPlayerController> _vlcControllers = [];

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blueGrey,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: EwelinkButton(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cameras.length,
                itemBuilder: (context, index) {
                  // Access the User instance
                  Camera camera = cameras[index].data;
                  VlcPlayerController controller = VlcPlayerController.network(
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
}
