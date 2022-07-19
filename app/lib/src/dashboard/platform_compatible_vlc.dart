import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

export 'package:flutter_vlc_player_platform_interface/src/utils/options/vlc_player_options.dart';

/// Mock VlcPlayer to be able to compile and run this app on non-supported
/// platforms like web and desktop.
class VlcPlayer extends StatelessWidget {
  const VlcPlayer(
      {Key? key,

      /// The [VlcPlayerController] responsible for the video being rendered in
      /// this widget.
      required this.controller,

      /// The aspect ratio used to display the video.
      /// This MUST be provided, however it could simply be (parentWidth / parentHeight) - where parentWidth and
      /// parentHeight are the width and height of the parent perhaps as defined by a LayoutBuilder.
      required this.aspectRatio,

      /// Before the platform view has initialized, this placeholder will be rendered instead of the video player.
      /// This can simply be a [CircularProgressIndicator] (see the example.)
      this.placeholder,

      /// Specify whether Virtual displays or Hybrid composition is used on Android.
      /// iOS only uses Hybrid composition.
      this.virtualDisplay = true})
      : super(key: key);

  final VlcPlayerController controller;
  final double aspectRatio;
  final Widget? placeholder;
  final bool virtualDisplay;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          color: Colors.grey,
          height: 200,
          child: Center(
            child: Text(
              'Visualização não disponível neste dispositivo. Utilize o aplicativo para visualizar as câmeras.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

class VlcPlayerController {
  /// The URI to the video file. This will be in different formats depending on
  /// the [DataSourceType] of the original video.
  final String dataSource;

  /// Set hardware acceleration for player. Default is Automatic.
  final HwAcc hwAcc;

  /// Initialize vlc player when the platform is ready automatically
  final bool autoInitialize;

  /// The video should be played automatically.
  final bool autoPlay;

  /// Adds options to vlc. For more [https://wiki.videolan.org/VLC_command-line_help] If nothing is provided,
  /// vlc will run without any options set.
  final VlcPlayerOptions? options;

  /// This is a callback that will be executed every time a new renderer cast device attached/detached
  /// It should be defined as "void Function(VlcRendererEventType, String, String)", where the VlcRendererEventType is an enum { attached, detached } and the next two String arguments are unique-id and name of renderer device, respectively.
  ///
  /// This member is deprecated, please, use the [addOnRendererEventListener] method instead.
  // ignore: unused_field
  final RendererCallback? _onRendererHandler;

  /// Only set for [asset] videos. The package that the asset was loaded from.
  String? package;

  /// Describes the type of data source this [VlcPlayerController]
  /// is constructed with.
  DataSourceType get dataSourceType => _dataSourceType;
  // ignore: prefer_final_fields
  DataSourceType _dataSourceType;

  /// This is a callback that will be executed once the platform view has been initialized.
  /// If you want the media to play as soon as the platform view has initialized, you could just call
  /// [VlcPlayerController.play] in this callback. (see the example).
  ///
  /// This member is deprecated, please, use the [addOnInitListener] method instead.
  // ignore: unused_field
  final VoidCallback? _onInit;

  /// Constructs a [VlcPlayerController] playing a video from obtained from
  /// the network.
  ///
  /// The URI for the video is given by the [dataSource] argument and must not be
  /// null.
  VlcPlayerController.network(
    this.dataSource, {
    this.autoInitialize = true,
    this.hwAcc = HwAcc.auto,
    this.autoPlay = true,
    this.options,
    @Deprecated('Please, use the addOnInitListener method instead.')
        VoidCallback? onInit,
    @Deprecated('Please, use the addOnRendererEventListener method instead.')
        RendererCallback? onRendererHandler,
  })  : package = null,
        _dataSourceType = DataSourceType.network,
        _onInit = onInit,
        _onRendererHandler = onRendererHandler;
}

typedef RendererCallback = void Function(VlcRendererEventType, String, String);
