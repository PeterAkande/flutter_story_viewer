import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_story_viewer/src/models/models.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

/// [VideoView] handles displaying the video for a status
class VideoView extends StatefulWidget {
  /// Constructor
  const VideoView({
    required this.index,
    required this.videoItem,
    required this.totalDurationCallback,
    required this.watchedPositionCallback,
    required this.onNextStatus,
    required this.onPreviousStatus,
    required this.fillColor,
    this.loadingOrBufferingIndicatorBuilder,
    super.key,
  });

  /// The index of this video view in the item list
  final int index;

  /// The video item
  final VideoItem videoItem;

  /// Callback to update ots parent widget of its current watched position
  final void Function(Duration position) watchedPositionCallback;

  /// Callback to update its parent of the total duration for this video
  final void Function(Duration totalDuration) totalDurationCallback;

  /// Callback called when the next status is to be chaecked out
  final VoidCallback onNextStatus;

  /// Callback called when the previous status is to be checked out
  final VoidCallback onPreviousStatus;

  /// View when Video is loading
  final Widget Function(BuildContext)? loadingOrBufferingIndicatorBuilder;

  /// The fill color for the video background
  final Color fillColor;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final Player player;
  late final VideoController controller;
  late Future<void> initializePlayerFuture;

  bool shouldGoToNextOrPreviousStatus = true;

  Future<void> initializePlayer() async {
    player = Player();
    late Media media;

    // Get if file has been cached and downloaded.
    final fileInfo = await DefaultCacheManager()
        .getFileFromCache(widget.videoItem.uniqueCacheKey);

    if (fileInfo == null) {
      media = Media(widget.videoItem.url);
    } else {
      media = Media(fileInfo.file.path);
    }

    await player.open(media);
    await player.play();

    controller = VideoController(player);

    player.stream.position.listen((event) {
      widget.watchedPositionCallback.call(event);
    });

    player.stream.duration.listen((event) {
      widget.totalDurationCallback.call(event);
    });
  }

  @override
  void initState() {
    super.initState();

    initializePlayerFuture = initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: FutureBuilder<void>(
                future: initializePlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return MaterialVideoControlsTheme(
                    fullscreen: _getMaterialControlThemeData(),
                    normal: _getMaterialControlThemeData(),
                    child: Video(
                      controller: controller,
                      controls: MaterialVideoControls,
                      fill: widget.fillColor,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTapDown: (details) {
                      player.playOrPause();
                    },
                    onTap: () {
                      if (shouldGoToNextOrPreviousStatus) {
                        widget.onPreviousStatus.call();
                      }
                    },
                    onLongPressDown: (details) {
                      setState(() {
                        shouldGoToNextOrPreviousStatus = false;
                      });
                    },
                    onLongPressCancel: () {
                      setState(() {
                        shouldGoToNextOrPreviousStatus = true;
                      });
                    },
                    onLongPressUp: () {
                      player.playOrPause();
                      setState(() {
                        shouldGoToNextOrPreviousStatus = true;
                      });
                    },
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth / 2,
                      color: Colors.transparent,
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (details) {
                      player.playOrPause();
                    },
                    onTap: () {
                      if (shouldGoToNextOrPreviousStatus) {
                        widget.onNextStatus.call();
                      }
                    },
                    onLongPressDown: (details) {
                      setState(() {
                        shouldGoToNextOrPreviousStatus = false;
                      });
                    },
                    onLongPressCancel: () {
                      setState(() {
                        shouldGoToNextOrPreviousStatus = true;
                      });
                    },
                    onLongPressUp: () {
                      player.playOrPause();
                      setState(() {
                        shouldGoToNextOrPreviousStatus = true;
                      });
                    },
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth / 2,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  MaterialVideoControlsThemeData _getMaterialControlThemeData() {
    return MaterialVideoControlsThemeData(
      displaySeekBar: false,
      backdropColor: Colors.transparent,
      bottomButtonBar: [],
      primaryButtonBar: [],
      bufferingIndicatorBuilder:
          widget.videoItem.loadingOrBufferingIndicatorBuilder ??
              widget.loadingOrBufferingIndicatorBuilder,
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
