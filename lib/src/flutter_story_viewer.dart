import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_story_viewer/src/models/video_view_item.dart';
import 'package:media_kit/media_kit.dart';
import 'widgets/widgets.dart';

/// [FlutterStoryViewer] manages and gives you a whats app like status view.
class FlutterStoryViewer extends StatefulWidget {
  /// Constructor.
  const FlutterStoryViewer({
    super.key,
    this.items = const [],
    this.backgroundColor,
    this.indicatorBackgroundColor,
    this.indicatorBorderRadius,
    this.indicatorColor,
    this.loadingOrBufferingIndicatorBuilder,
  });

  /// Story Items
  /// Todo: Support Other Status Items like images and Text
  final List<VideoItem> items;

  /// The Background Color for this view
  final Color? backgroundColor;

  /// Indicator Track color
  final Color? indicatorBackgroundColor;

  /// Indicator Color
  final Color? indicatorColor;

  /// The border radius of the indicator.
  final BorderRadius? indicatorBorderRadius;

  /// Loading indicator when a video item is loading
  final Widget Function(BuildContext)? loadingOrBufferingIndicatorBuilder;

  @override
  State<FlutterStoryViewer> createState() => _FlutterStoryViewerState();

  /// Initialize Media Kit
  /// Must be called before Flutter Story viewer is used.
  static void ensureInitialized() {
    MediaKit.ensureInitialized();
  }
}

class _FlutterStoryViewerState extends State<FlutterStoryViewer> {
  int currentIndex = 0;

  final watchedSecondsNotifier = ValueNotifier(0);
  final totalSecondsNotifier = ValueNotifier(0);

  /// Changes the status to the next story in
  void checkOutNextStatus() {
    setState(() {
      if (widget.items.length - 1 > currentIndex) {
        currentIndex += 1;
        watchedSecondsNotifier.value = 0;
        totalSecondsNotifier.value = 0;
      }
    });
  }

  void checkoutPreviousStatus() {
    if (currentIndex != 0) {
      setState(() {
        currentIndex -= 1;
        watchedSecondsNotifier.value = 0;
        totalSecondsNotifier.value = 0;
      });
    }
  }

  void downloadAndCacheAlldeos() {
    for (final item in widget.items) {
      unawaited(
        DefaultCacheManager().downloadFile(
          item.url,
          authHeaders: item.header,
          key: item.cacheKey,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Download and cache all videos
    downloadAndCacheAlldeos();

    watchedSecondsNotifier.addListener(() {
      if (watchedSecondsNotifier.value != 0 &&
          watchedSecondsNotifier.value == totalSecondsNotifier.value) {
        checkOutNextStatus();
      }
    });

    totalSecondsNotifier.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    if (widget.items.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constaint) {
          return Container(
            height: constaint.maxHeight,
            width: constaint.maxWidth,
            color: widget.backgroundColor ?? Colors.black,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  width: double.maxFinite,
                  child: ValueListenableBuilder(
                    valueListenable: totalSecondsNotifier,
                    builder: (context, value, child) {
                      return ValueListenableBuilder(
                        valueListenable: watchedSecondsNotifier,
                        builder: (context, _, child) {
                          const paddingExtent = 10;
                          final width = (size.width -
                                  (widget.items.length * paddingExtent)) /
                              widget.items.length;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...List.generate(widget.items.length, (index) {
                                late double value;
                                if (currentIndex == index) {
                                  if (totalSecondsNotifier.value == 0) {
                                    value = 0;
                                  } else {
                                    value = watchedSecondsNotifier.value /
                                        totalSecondsNotifier.value;
                                  }
                                } else if (currentIndex > index) {
                                  value = 1;
                                } else {
                                  value = 0;
                                }

                                final padding = EdgeInsets.only(
                                  left: (index == 0 ? 0 : paddingExtent)
                                      .toDouble(),
                                );

                                return SizedBox(
                                  width: width - paddingExtent,
                                  child: Padding(
                                    padding: padding,
                                    child: ClipRRect(
                                      borderRadius:
                                          widget.indicatorBorderRadius ??
                                              BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: value,
                                        color: widget.indicatorColor,
                                        backgroundColor:
                                            widget.indicatorBackgroundColor,
                                      ),
                                    ),
                                  ),
                                );
                              })
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: constaint.maxHeight - 40,
                  child: VideoView(
                    fillColor: widget.backgroundColor ?? Colors.black,
                    key: ValueKey(currentIndex),
                    index: currentIndex,
                    videoItem: widget.items[currentIndex],
                    watchedPositionCallback: (postion) {
                      watchedSecondsNotifier.value = postion.inSeconds;
                    },
                    totalDurationCallback: (postion) {
                      totalSecondsNotifier.value = postion.inSeconds;
                    },
                    onNextStatus: checkOutNextStatus,
                    onPreviousStatus: checkoutPreviousStatus,
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
