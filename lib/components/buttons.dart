import 'package:flutter/material.dart';

class OutLinedButton extends StatelessWidget {
  const OutLinedButton(
      {Key? key,
      required this.child,
      this.padding = EdgeInsets.zero,
      this.elevation = 0,
      required this.onTaped,
      this.color = Colors.blueGrey})
      : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final double elevation;
  final void Function()? onTaped;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTaped,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        side: MaterialStateProperty.all(
          BorderSide(color: Colors.grey[700]!),
        ),
        elevation: MaterialStateProperty.all(elevation),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
