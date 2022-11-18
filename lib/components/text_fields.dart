import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnderLinedTextField extends StatelessWidget {
  const UnderLinedTextField({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.hintText = '',
    this.prefixText,
    this.onChanged,
    this.isPassword = false,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String hintText;
  final String? prefixText;
  final Function(String)? onChanged;
  final bool isPassword;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        prefixStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          letterSpacing: 2.w,
          fontWeight: FontWeight.w700,
          color: Colors.black38,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      textInputAction: textInputAction,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLength: maxLength,
    );
  }
}

class OutLinedTextField extends StatelessWidget {
  const OutLinedTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.backgroundColor,
    this.borderColor = Colors.black38,
    this.textInputAction,
    this.hintText,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.textAlignVertical,
    this.prefixIcon,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final Color? backgroundColor;
  final Color borderColor;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
        ),
        prefixIcon: prefixIcon,
        hintText: hintText,
        fillColor: backgroundColor,
        filled: true,
      ),
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: maxLength,
      textAlignVertical: textAlignVertical,
    );
  }
}
