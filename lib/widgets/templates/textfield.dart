import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hint;
  final String? label;
  final double width;
  final double height;
  final double borderRadius;
  final Function(String) onChanged;
  final EdgeInsets padding;
  final TextEditingController controller;
  final TextInputType textinputtype;
  const TextFieldWidget(
      {super.key, this.hint,
      this.label,
      this.width = 100,
      this.height = 40,
      this.borderRadius = 10,
      this.padding = EdgeInsets.zero,
      required this.onChanged,
      required this.controller,
      this.textinputtype = TextInputType.text});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.textinputtype,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius)),
              hintText: widget.hint,
              labelText: widget.label,
              floatingLabelBehavior: FloatingLabelBehavior.always),
          onChanged: (text) {
            widget.onChanged(text);
          },
        ),
      ),
    );
  }
}
