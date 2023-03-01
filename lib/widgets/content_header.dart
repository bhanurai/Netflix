import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:netflix/model/content_models.dart';

import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  final Content? featuredContent;

  const ContentHeader({required this.featuredContent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent!),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  _ContentHeaderMobileState createState() => _ContentHeaderMobileState();
}

class _ContentHeaderMobileState extends State<_ContentHeaderMobile> {
  bool _isMuted = true;

  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.featuredContent.videoUrl != null) {
      _videoController = VideoPlayerController.network(widget.featuredContent.videoUrl!);
      _initializeVideoPlayerFuture = _videoController.initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_videoController.value.isPlaying) {
            _videoController.pause();
          } else {
            _videoController.play();
          }
        });
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),
          Center(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          Positioned(
              left: 20.0,
              right: 20.0,
              bottom: 40.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 105.0,
                    child: Image.asset(widget.featuredContent.titleImageUrl!),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    widget.featuredContent.description!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 6.0,
                          )
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      _PlayButton(),
                      const SizedBox(
                        width: 8.0,
                      ),
                      TextButton.icon(
                        onPressed: () => print('More Info'),
                        icon: const Icon(Icons.info_outline,size: 15.0,),
                        label:const  Text(
                          'More Info',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      if (_videoController.value.isInitialized)
                        IconButton(
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                          color: Colors.white,
                          iconSize: 10.0,
                          onPressed: () => setState(() {
                            _isMuted
                                ? _videoController.setVolume(100)
                                : _videoController.setVolume(0);
                            _isMuted = _videoController.value.volume == 0;
                          }),
                        ),
                    ],
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}








class _ContentHeaderDesktop extends StatefulWidget {
  final Content? featuredContent;

  const _ContentHeaderDesktop({Key? key, this.featuredContent})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.network(widget.featuredContent!.videoUrl!)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(aspectRatio: _videoController.value.isInitialized
              ? _videoController.value.aspectRatio
              :2.344,
            child: _videoController.value.isInitialized
                ? VideoPlayer(_videoController)
                :Image.asset(
                widget.featuredContent!.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: -1.0,
            child: AspectRatio(aspectRatio: _videoController.value.isInitialized
                ? _videoController.value.aspectRatio
                :2.344,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 60.0,
              right: 60.0,
              bottom: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: Image.asset(widget.featuredContent!.titleImageUrl!),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    widget.featuredContent!.description!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 6.0,
                          )
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      _PlayButton(),
                      const SizedBox(
                        width: 16.0,
                      ),
                      TextButton.icon(
                        onPressed: () => print('More Info'),
                        icon: const Icon(Icons.info_outline,size: 30.0,),
                        label:const  Text(
                          'More Info',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      if (_videoController.value.isInitialized)
                        IconButton(
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () => setState(() {
                            _isMuted
                                ? _videoController.setVolume(100)
                                : _videoController.setVolume(0);
                            _isMuted = _videoController.value.volume == 0;
                          }),
                        ),
                    ],
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(

      style: TextButton.styleFrom(primary: Colors.white),
      // padding: const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
      onPressed: () => print('Play'),
      // color: Colors.white,
      icon: const Icon(
        Icons.play_arrow,
        size: 15.0,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
