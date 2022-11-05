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
      children: [
        SizedBox(
          width: 90,
          height: 35,
          child: ElevatedButton(
            onPressed: hasPreviousTip() ? showPreviousTip : null,
            child: const Text(
              'Previous\ntip',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.red,
                ),
              ),
              child: Text(
                currentTip,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 90,
          height: 35,
          child: ElevatedButton(
            onPressed: hasNextTip() ? showNextTip : null,
            child: const Text(
              'Next\ntip',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
