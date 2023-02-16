import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/themes/colors.dart';
import '../cubit/reviews_cubit.dart';

class VideoReview extends StatefulWidget {
  const VideoReview({
    Key? key,
    required this.reviewsCubit,
    required this.index,
  }) : super(key: key);

  final ReviewsCubit reviewsCubit;
  final int index;

  @override
  State<VideoReview> createState() => _VideoReviewState();
}

class _VideoReviewState extends State<VideoReview> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    print(widget.reviewsCubit.reviews[widget.index].images?.first ?? '');
    _controller = VideoPlayerController.network(
      widget.reviewsCubit.reviews[widget.index].videos?.first ?? '',
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: AppColors.lightGreybackgound,
      child: Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 300,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
