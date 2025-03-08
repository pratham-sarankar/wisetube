import 'package:flutter/material.dart';
import 'package:youtube_scrape_api/models/video.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.video, required this.onPressed});
  final Video video;
  final VoidCallback onPressed;
  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    final thumbnail = widget.video.thumbnails?.last.url;
    final duration = widget.video.duration;
    final descriptions = [
      widget.video.channelName,
      widget.video.views,
      widget.video.uploadDate,
    ];
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FadeInImage.assetNetwork(
                    image: thumbnail!,
                    fit: BoxFit.cover,
                    placeholder: 'assets/place_holder_image.webp',
                  ),
                  if (duration != null)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          duration,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.video.title!,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              descriptions.whereType<String>().join(" · "),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
