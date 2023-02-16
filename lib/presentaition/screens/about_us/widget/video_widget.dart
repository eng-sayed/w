import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../cubit/about_us_cubit.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _ytbPlayerController;
  @override
  void initState() {
    super.initState();

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _ytbPlayerController = YoutubePlayerController(
          //initialVideoId: videosList[0].youtubeId,
          params: YoutubePlayerParams(
            showFullscreenButton: true,
          ),
        );
      });
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   _setOrientation([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);

  //   _ytbPlayerController.close();
  // }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutUsCubit, AboutUsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = AboutUsCubit.get(context);

        return Container(
          height: 300,
          width: double.infinity,
          child: YoutubePlayer(
            controller: cubit.cont,
            //  aspectRatio: 16 / 9,
          ),
          // TODOchild: YoutubePlayer(
          //   controller: cubit.cont,
          //   showVideoProgressIndicator: true,
          //   bottomActions: [
          //     CurrentPosition(),
          //     ProgressBar(
          //       isExpanded: true,
          //     )
          //   ],
          // ),
        );
      },
    );
  }
}
