import 'package:flutter/material.dart';

class CustomButtonWidget extends StatefulWidget {
  String? title;
  Color? backgroundColor;
  bool isLoading;
  VoidCallback onTab;
  CustomButtonWidget(
      {super.key,
      this.title = "",
      this.backgroundColor,
      this.isLoading = false,
      required this.onTab});

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading == true
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.black54,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : GestureDetector(
            onTap: widget.onTab,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                textAlign: TextAlign.center,
                "${widget.title}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}
