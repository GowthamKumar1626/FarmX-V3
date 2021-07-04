import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final double? borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(color ?? Colors.indigo),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 0.0),
            ),
          ),
        ),
      ),
    );
  }
}
