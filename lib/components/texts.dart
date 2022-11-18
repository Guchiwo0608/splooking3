import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Head1 extends StatelessWidget {
  const Head1({
    Key? key, 
    required this.text,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 28.w,
        letterSpacing: 4.w,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Head2 extends StatelessWidget {
  const Head2({
    Key? key, 
    required this.text,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 24.w,
        letterSpacing: 3.w,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Head3 extends StatelessWidget {
  const Head3({
    Key? key, 
    required this.text,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 20.w,
        letterSpacing: 2.w,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Head4 extends StatelessWidget {
  const Head4({
    Key? key,
    required this.text,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 16.w,
        letterSpacing: 1.w,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Head5 extends StatelessWidget {
  const Head5({
    Key? key,
    required this.text,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 13.w,
        letterSpacing: 1.w,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class HelperTextWidget extends StatelessWidget {
  const HelperTextWidget({
    Key? key,
    this.text = '',
    required this.condition,
  }) : super(key: key);

  final String text;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check,
          size: 20.h,
          color: condition ? Colors.red[900] : Colors.grey,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.h,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

class Body1 extends StatelessWidget {
  const Body1({
    Key? key,
    required this.text,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 12.w,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.clip,
      ),
    );
  }
}