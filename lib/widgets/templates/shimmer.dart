import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;
  const ShimmerWidget({super.key, required this.width, required this.height});

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.0,
        height: 100.0,
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 218, 218, 218),
          highlightColor: const Color.fromARGB(255, 247, 247, 247),
          child: const SizedBox(),
        ));
  }
}
