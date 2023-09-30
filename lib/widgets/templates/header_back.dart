import 'package:flutter/material.dart';

class HeaderBackWidget extends StatefulWidget {
  String? title;
  void Function()? onTap;
  HeaderBackWidget({super.key, this.title, this.onTap});

  @override
  State<HeaderBackWidget> createState() => _HeaderBackWidgetState();
}

class _HeaderBackWidgetState extends State<HeaderBackWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color.fromARGB(255, 207, 205, 205)))),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
        child: Row(children: [
          GestureDetector(
            onTap: widget.onTap != null
                ? widget.onTap!
                : () {
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  },
            child: const Icon(Icons.arrow_back),
          ),
          widget.title != null && widget.title!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.title!,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              : const SizedBox()
        ]),
      ),
    );
  }
}
