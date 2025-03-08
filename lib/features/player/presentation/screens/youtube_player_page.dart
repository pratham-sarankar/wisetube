import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({super.key});

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  YoutubePlayerController? _controller;

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
          ? SafeArea(
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller!,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      // some widgets
                      player,
                      //some other widgets
                    ],
                  );
                },
              ),
            )
          : Container(),
    );
  }

  void _initializePlayer() {
    final videoId = ModalRoute.of(context)?.settings.arguments as String;
    _controller = YoutubePlayerController(initialVideoId: videoId);
    setState(() {});
  }
}
