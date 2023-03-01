import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Responsive extends StatefulWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final String? videoUrl;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.videoUrl,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
          MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  _ResponsiveState createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return widget.desktop;
        } else if (constraints.maxWidth >= 800) {
          return widget.tablet ?? _buildMobileWithVideo();
        } else {
          return _buildMobileWithVideo();
        }
      },
    );
  }

  Widget _buildMobileWithVideo() {
    return Stack(
      children: [
        widget.mobile,
        if (widget.videoUrl != null)
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
                : Container(),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
