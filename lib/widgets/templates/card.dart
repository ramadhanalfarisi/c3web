import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Widget child;
  final double elevation;
  final double borderRadius;
  const CardWidget(
      {super.key, required this.child, required this.elevation, this.borderRadius = 10});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      elevation: widget.elevation,
      child: widget.child,
    );
  }
}
