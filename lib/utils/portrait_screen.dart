// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// A widget that makes it easy to create a screen with a square-ish
/// main area, a smaller menu area, and a small area for a message on top.
/// It works in both orientations on mobile- and tablet-sized screens.
class PortraitScreen extends StatelessWidget {
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

  const PortraitScreen({
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: padding,
                child: topMessageArea,
              ),
            ),
            Expanded(
              flex: (mainAreaProminence * 100).round(),
              child: SafeArea(
                top: false,
                bottom: false,
                minimum: padding,
                child: squarishMainArea,
              ),
            ),
            SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Padding(
                padding: padding,
                child: rectangularMenuArea,
              ),
            ),
          ],
        );
      },
    );
  }
}
