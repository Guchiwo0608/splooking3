import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showErrorAlertDialog({
  required BuildContext context,
  String? errorText,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.w),
          ),
        ),
        title: Text(
          'エラー',
          style: TextStyle(
            color: Colors.red[900],
            fontWeight: FontWeight.w600,
            fontSize: 18.w,
          ),
        ),
        content: Text(errorText!),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8.h, 20.w, 14.h),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.grey[850],
                  fontWeight: FontWeight.w500,
                  fontSize: 18.w,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}