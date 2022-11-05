import 'package:flutter/material.dart';

import 'default_button.dart';

class TipViewer extends StatefulWidget {
  const TipViewer({super.key, required this.tips});

  final List<String> tips;

  @override
  State<TipViewer> createState() => _TipViewerState();
}

class _TipViewerState extends State<TipViewer> {
  int currentTipIndex = 0;
  late List<String> tips;

  @override
  void initState() {
    super.initState();
    tips = widget.tips;
  }

  bool hasNextTip() {
    final tipsListLength = tips.length - 1;
    return currentTipIndex < tipsListLength;
  }

  bool hasPreviousTip() => currentTipIndex > 0;

  void showNextTip() {
    setState(() {
      currentTipIndex++;
    });
  }

  void showPreviousTip() {
    setState(() {
      currentTipIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTip = tips[currentTipIndex];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DefaultButton(
          text: 'Previous tip',
          onPressed: hasPreviousTip() ? showPreviousTip : null,
        ),
        Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.red,
            ),
          ),
          child: Text(currentTip),
        ),
        DefaultButton(
          text: 'Next tip',
          onPressed: hasNextTip() ? showNextTip : null,
        ),
      ],
    );
  }
}
