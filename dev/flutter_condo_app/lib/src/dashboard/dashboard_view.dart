import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:condo_app/src/camera/camera_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_vlc_player/src/vlc_player_controller.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class DashboardView extends StatefulWidget {
  DashboardView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/dashboard';

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
      body: Center(
        child: FirestoreBuilder<CameraQuerySnapshot>(
          ref: camerasRef.whereEnabled(isEqualTo: true).orderByName(),
          builder: (context, AsyncSnapshot<CameraQuerySnapshot> snapshot,
              Widget? child) {
            if (snapshot.hasError) return const Text('Something went wrong!');
            if (!snapshot.hasData) return const Text('Loading users...');

            // Access the QuerySnapshot
            CameraQuerySnapshot querySnapshot = snapshot.requireData;

            return ListView.builder(
              itemCount: querySnapshot.docs.length,
              itemBuilder: (context, index) {
                // Access the User instance
                Camera camera = querySnapshot.docs[index].data;
                VlcPlayerController controller =
                    VlcPlayerController.network(camera.url);
                _vlcControllers.add(controller);

                return VlcPlayer(
                  controller: controller,
                  aspectRatio: 16 / 9,
                  placeholder: Text(camera.name),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
