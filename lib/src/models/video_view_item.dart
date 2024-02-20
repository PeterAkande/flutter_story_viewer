import 'package:flutter/material.dart';
import 'package:flutter_story_viewer/src/flutter_story_viewer.dart';

/// [VideoItem] specifies that the story item is a video
class VideoItem {
  /// Constructor
  const VideoItem({
    required this.url,
    this.header,
    this.cacheKey,
    this.loadingOrBufferingIndicatorBuilder,
  });

  /// The url to the resource.
  /// Support for files would be availabke later.
  final String url;

  /// Header when requesting for resource.
  /// Could contain your Authorization token (if needed)
  final Map<String, String>? header;

  /// Status videos are downloaded and cached.
  /// Cache key is used as the id for the cache.
  /// If null, the url is used as the cache key
  final String? cacheKey;

  /// View when Video is loading
  /// Take precedence over the [FlutterStoryViewer] loadingOrBufferingIndicatorBuilder
  final Widget Function(BuildContext)? loadingOrBufferingIndicatorBuilder;

  /// Return the unique cache key for this item
  String get uniqueCacheKey {
    return cacheKey ?? url;
  }
}
