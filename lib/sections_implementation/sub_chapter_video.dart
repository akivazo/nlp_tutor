import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SubChapterVideo extends StatefulWidget {
  final String videoId;
  const SubChapterVideo({super.key, required this.videoId});

  @override
  State<SubChapterVideo> createState() => _SubChapterVideoState();
}

class _SubChapterVideoState extends State<SubChapterVideo> {
  late YoutubePlayerController _controller;
  @override
  void initState(){
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
