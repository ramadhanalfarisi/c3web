import 'package:c3web/helpers/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final EdgeInsets padding;
  final Color textColor;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets margin;
  final Function() onPress;

  const Button(
      {super.key, required this.text,
      this.padding = const EdgeInsets.fromLTRB(10, 5, 10, 5),
      this.textColor = Colors.white,
      this.backgroundColor = ColorConfig.primaryColor,
      this.borderRadius = 5,
      this.margin = const EdgeInsets.all(20),
      required this.onPress});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: Text(
          widget.text,
          style: TextStyle(color: widget.textColor, fontSize: 16),
        ),
      ),
    );
  }
}
