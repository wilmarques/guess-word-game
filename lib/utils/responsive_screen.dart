import 'package:flutter/material.dart';

import 'landscape_screen.dart';
import 'portrait_screen.dart';

/// A widget that makes it easy to create a screen with a square-ish
/// main area, a smaller menu area, and a small area for a message on top.
/// It works in both orientations on mobile- and tablet-sized screens.
class ResponsiveScreen extends StatelessWidget {
  /// This is the "hero" of the screen. It's more or less square, and will
  /// be placed in the visual "center" of the screen.
  final Widget squarishMainArea;

  /// The second-largest area after [squarishMainArea]. It can be narrow
  /// or wide.
  final Widget rectangularMenuArea;

  /// An area reserved for some static text close to the top of the screen.
  final Widget topMessageArea;

  /// How much bigger should the [squarishMainArea] be compared to the other
  /// elements.
  final double mainAreaProminence;

  const ResponsiveScreen({
    required this.squarishMainArea,
    required this.rectangularMenuArea,
    this.topMessageArea = const SizedBox.shrink(),
    this.mainAreaProminence = 0.8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // This widget wants to fill the whole screen.
        final size = constraints.biggest;
        final padding = EdgeInsets.all(size.shortestSide / 30);

        if (size.height >= size.width) {
          return PortraitScreen(
            padding: padding,
            squarishMainArea: squarishMainArea,
            rectangularMenuArea: rectangularMenuArea,
            topMessageArea: topMessageArea,
            mainAreaProminence: mainAreaProminence,
          );
        } else {
          // "Landscape" / "tablet" mode.
          final isLarge = size.width > 900;

          return LandscapeScreen(
            padding: padding,
            squarishMainArea: squarishMainArea,
            topMessageArea: topMessageArea,
            rectangularMenuArea: rectangularMenuArea,
            isLarge: isLarge,
          );
        }
      },
    );
  }
}
