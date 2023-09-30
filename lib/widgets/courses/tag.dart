import 'package:flutter/material.dart';

class TagWidget extends StatefulWidget {
  final String title;
  final Function(String) onPressed;
  String selected;
  TagWidget({super.key, required this.title, required this.onPressed, this.selected = ""});

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 5),
      child: GestureDetector(
        onTap: () {
          widget.onPressed(widget.title);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: widget.selected == widget.title ? const Color(0xFF244F83) : const Color(0xFF424242)),
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
