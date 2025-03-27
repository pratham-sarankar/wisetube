import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_scrape_api/models/video.dart';

class YoutubePlayerPage extends StatefulWidget {
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
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller != null
          ? OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return SafeArea(
                    child: YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _controller!,
                      ),
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
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.055,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
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
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    video.uploadDate ?? 'No Date',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500,
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
                                        color: Colors.white30,
                                        width: 2,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          video.thumbnails!.first.url
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
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller!,
                    ),
                    builder: (context, player) {
                      return player;
                    },
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
    );
  }

  void _initializePlayer() {
    // video = ModalRoute.of(context)?.settings.arguments as Video;
    // _controller = YoutubePlayerController(initialVideoId: video.videoId!);

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
      _controller = YoutubePlayerController(initialVideoId: video.videoId!);
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
