import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function() onPressed;
  final String label;

  const MainButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
