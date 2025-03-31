import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_scrape_api/models/video.dart';

/// A page that displays a YouTube video with player controls and video information.
///
/// This widget uses [YoutubePlayerIFrame] to display the video and provides
/// additional UI elements to show video details such as title, view count,
/// upload date, and channel information.
class YoutubePlayerPage extends StatefulWidget {
  /// Creates a YouTube player page.
  const YoutubePlayerPage({super.key});

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  YoutubePlayerController? _controller;
  late Video video;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializePlayer());
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _controller != null
          ? OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return SafeArea(
                    child: YoutubePlayerScaffold(
                      controller: _controller!,
                      builder: (context, player) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            player,

                            // Video Title
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              child: Text(
                                video.title ?? 'No Title',
                                style: textTheme.titleLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      MediaQuery.sizeOf(context).width * 0.045,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            // Views and Upload Date
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    video.views!,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.sizeOf(context).width *
                                              0.035,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    video.uploadDate ?? 'No Date',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.sizeOf(context).width *
                                              0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Channel Info
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              child: Row(
                                children: [
                                  // Channel Avatar
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colorScheme.outline,
                                        width: 2,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          video.thumbnails?.first.url
                                                  .toString() ??
                                              'No Image',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // Channel Name
                                  Expanded(
                                    child: Text(
                                      video.channelName ?? 'No Channel',
                                      style: textTheme.bodyLarge?.copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            MediaQuery.sizeOf(context).width *
                                                0.04,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }

                // Landscape Mode
                return SafeArea(
                  child: YoutubePlayerScaffold(
                    controller: _controller!,
                    builder: (context, player) {
                      return player;
                    },
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
              ),
            ),
    );
  }

  /// Initializes the YouTube player with the video from route arguments.
  ///
  /// Extracts the Video object from route arguments and sets up the controller
  /// with the video ID. Shows an error message and navigates back if video
  /// loading fails.
  void _initializePlayer() {
    try {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is! Video) {
        throw ArgumentError(
            'Expected Video object but got ${args.runtimeType}');
      }
      video = args;
      if (video.videoId == null) {
        throw ArgumentError('Video ID cannot be null');
      }

      _controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          enableCaption: true,
        ),
      );

      _controller!.loadVideoById(videoId: video.videoId!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load video: ${e.toString()}')),
      );
      Navigator.pop(context);
      return;
    }
    setState(() {});
  }
}
