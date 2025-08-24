import 'package:flutter/widgets.dart';

class LandscapeScreen extends StatelessWidget {
  const LandscapeScreen({
    super.key,
    required this.padding,
    required this.squarishMainArea,
    required this.topMessageArea,
    required this.rectangularMenuArea,
    required this.isLarge,
  });

  final EdgeInsets padding;
  final Widget squarishMainArea;
  final Widget topMessageArea;
  final Widget rectangularMenuArea;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: isLarge ? 7 : 5,
          child: SafeArea(
            right: false,
            maintainBottomViewPadding: true,
            minimum: padding,
            child: squarishMainArea,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              SafeArea(
                bottom: false,
                left: false,
                maintainBottomViewPadding: true,
                child: Padding(
                  padding: padding,
                  child: topMessageArea,
                ),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  left: false,
                  maintainBottomViewPadding: true,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: padding,
                      child: rectangularMenuArea,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
