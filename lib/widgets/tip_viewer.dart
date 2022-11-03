import 'package:flutter/material.dart';

class TipViewer extends StatelessWidget {
  const TipViewer(
      {super.key, required this.tips, required this.currentTipIndex});

  final List<String> tips;
  final int currentTipIndex;

  @override
  Widget build(BuildContext context) {
    final currentTip = tips[currentTipIndex];

    return Container(
      width: 250,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.red,
        ),
      ),
      child: Text(currentTip),
    );
  }
}
