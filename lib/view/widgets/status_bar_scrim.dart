import 'package:flutter/material.dart';

/// A strip behind the status bar, for screens whose red header scrolls under
/// it. At the top it blends into the header; once scrolled it stops content
/// from showing through the clock and icons. Place it last in a [Stack].
class StatusBarScrim extends StatelessWidget {
  const StatusBarScrim({super.key, this.color = const Color(0xFFE30613)});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: MediaQuery.paddingOf(context).top,
      child: IgnorePointer(child: ColoredBox(color: color)),
    );
  }
}
