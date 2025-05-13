
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// VIDEO PLAYER WIDGET FULLSCREEN
class VideoPlayerWidget extends StatefulWidget {
  final String url;
  final VoidCallback? onVideoComplete; // <- Add this

  const VideoPlayerWidget({
    super.key,
    required this.url,
    this.onVideoComplete,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late BetterPlayerController _controller;
  final GlobalKey _betterPlayerKey = GlobalKey();
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Lock to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
      videoFormat: BetterPlayerVideoFormat.hls,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 20 * 1024 * 1024,
      ),
    );

    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: true,
        fit: BoxFit.cover,
        aspectRatio: null,
        expandToFill: true,
        handleLifecycle: true,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          showControls: false,
        ),
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        eventListener: (event) {
          if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
            setState(() {
              _isVideoInitialized = true;
            });
          } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
            widget.onVideoComplete?.call();
          }
        },
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Update the aspect ratio to match the screen dimensions
    final screenAspectRatio = MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height;
    _controller.setOverriddenAspectRatio(screenAspectRatio);
  }

  @override
  void dispose() {
    // Reset orientation
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _controller.dispose(forceDispose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player
        BetterPlayer(
          key: _betterPlayerKey,
          controller: _controller,
        ),

        // Loader overlay
        if (!_isVideoInitialized)
          const ColoredBox(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
