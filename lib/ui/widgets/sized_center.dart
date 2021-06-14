import 'package:flutter/material.dart';

class SizedCenter extends StatelessWidget {
  final double cellSize;
  final Widget child;
  const SizedCenter({required this.cellSize, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cellSize,
      width: cellSize,
      child: Center(
        child: child,
      ),
    );
  }
}
