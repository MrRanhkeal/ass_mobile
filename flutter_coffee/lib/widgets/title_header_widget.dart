import 'package:flutter/material.dart';

class TitleHeaderWidget extends StatelessWidget {
  final String title;
  const TitleHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, color: Colors.black54),
      ),
    );
  }
}
