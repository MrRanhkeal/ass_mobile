import 'package:flutter/material.dart';

class TitleHeaderWidget extends StatefulWidget {
  String? title;
  TitleHeaderWidget({super.key, this.title});

  @override
  State<TitleHeaderWidget> createState() => _TitleHeaderWidgetState();
}

class _TitleHeaderWidgetState extends State<TitleHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: Text(
        "${widget.title}",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, color: Colors.black54),
      ),
    );
  }
}
