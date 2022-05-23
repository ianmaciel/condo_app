import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_vlc_player/src/vlc_player_controller.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class DashboardView extends StatelessWidget {
  DashboardView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  final VlcPlayerController _vlcViewControllerExterna11 =
      VlcPlayerController.network(
    //'http://192.168.1.178:88/cgi-bin/CGIStream.cgi?cmd=GetMJStream&usr=ianmaciel&pwd=ian290994',
    //'http://admin:tomate1028@10.0.0.11/cgi-bin/mjpg/video.cgi?&subtype=1',
    //'rtsp://10.0.0.11:554/user=admin&password=tomate1028&channel=1&stream=0.sdp?',
    //'rtsp://10.0.0.130:554/user=admin&password=tomate1028&channel=1&stream=0.sdp?',
    //
    // OK - rua 1
    //'rtsp://10.0.0.131:554/user=admin&password=tomate1028&channel=1&stream=0.sdp?',
    //'rtsp://10.0.0.135:554/user=admin&password=tomate1028&channel=1&stream=0.sdp?',
    //
    // NVD 3610 - https://forum.intelbras.com.br/viewtopic.php?t=61631
    // rtsp://<user>:<password>@<ip>:<port>/cam/realmonitor?channel=<channelNo>&subtype=<typeNo>
    //'rtsp://admin:134940@10.0.0.21:554/cam/realmonitor?channel=3&subtype=0',
    //'rtsp://condo:880313@10.0.0.21:554/cam/realmonitor?channel=3&subtype=0',
    //
    // VIP 1120B - https://forum.intelbras.com.br/viewtopic.php?t=58960
    // rtsp://IP:PORTA/user=USUÁRIO&password=SENHA&channel=1&stream=0.sdp?
    //
    // Camera portão:
    //'rtsp://10.0.0.130:555/user=admin&password=tomate1028&channel=1&stream=0.sdp?',
    //'rtsp://ian:880313@10.0.0.130:554/cam/realmonitor?channel=3&subtype=0',
    //
    // Camera externa 103 VIP-3220-B:
    //'rtsp://USUÁRIO:SENHA@IP:PORTA/cam/realmonitor?channel=1&subtype=0',
    //'rtsp://condo:tomate1028@10.0.0.103:554/cam/realmonitor?channel=1&subtype=0',
    //
    // Camera externa 11 VIP-3220-B:
    //'rtsp://USUÁRIO:SENHA@IP:PORTA/cam/realmonitor?channel=1&subtype=0',
    //'rtsp://admin:avila8468@10.0.0.103:554/cam/realmonitor?channel=1&subtype=0',
    'rtsp://app:tomate1028@10.0.0.103:554/cam/realmonitor?channel=1&subtype=1',
    autoPlay: true,
  );
  final VlcPlayerController _vlcViewControllerPortao130 =
      VlcPlayerController.network(
    'rtsp://10.0.0.130:554/user=app&password=tomate1028&channel=1&stream=1.sdp?',
    autoPlay: true,
  );
  final VlcPlayerController _vlcViewControllerSonOff =
      VlcPlayerController.network(
    'rtsp://rtsp:12345678@10.0.0.152:554/av_stream/ch0',
    autoPlay: true,
  );
  final VlcPlayerController _vlcViewControllerMuro =
      VlcPlayerController.network(
    'rtsp://10.0.0.105:554/user=app&password=tomate1028&channel=1&stream=1.sdp?',
    autoPlay: true,
  );

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
        child: ListView(
          children: <Widget>[
            VlcPlayer(
              controller: _vlcViewControllerPortao130,
              aspectRatio: 16 / 9,
              placeholder: const Text("Vista do alto"),
            ),
            VlcPlayer(
              controller: _vlcViewControllerExterna11,
              aspectRatio: 16 / 9,
              placeholder: const Text("Entrada"),
            ),
            VlcPlayer(
              controller: _vlcViewControllerSonOff,
              aspectRatio: 16 / 9,
              placeholder: const Text("Portaria"),
            ),
          ],
        ),
      ),
    );
  }
}
