import 'package:flutter/material.dart';

class CardBorderWidget extends StatefulWidget {
  final Widget child;
  final EdgeInsets margin;
  const CardBorderWidget({super.key, required this.child, this.margin = EdgeInsets.zero});

  @override
  State<CardBorderWidget> createState() => _CardBorderWidgetState();
}

class _CardBorderWidgetState extends State<CardBorderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: widget.margin,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.circular(5)),
        child: widget.child);
  }
}
