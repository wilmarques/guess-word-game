import 'package:flutter/material.dart';

class PortraitScreen extends StatelessWidget {
  const PortraitScreen({
    super.key,
    required this.padding,
    required this.squarishMainArea,
    required this.topMessageArea,
    required this.rectangularMenuArea,
    required this.mainAreaProminence,
  });

  final EdgeInsets padding;
  final Widget squarishMainArea;
  final Widget topMessageArea;
  final Widget rectangularMenuArea;
  final double mainAreaProminence;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
