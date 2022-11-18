import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showPickerDateTime(
  BuildContext context, {
  Function(Picker, List<int>)? onConfirm,
}) async {
  Picker(
    adapter: DateTimePickerAdapter(
      type: PickerDateTimeType.kYMDHM,
      isNumberMonth: true,
      //strAMPM: const["上午", "下午"],
      yearSuffix: '年',
      monthSuffix: '月',
      daySuffix: '日',
      hourSuffix: '時',
      minuteSuffix: '分',
      minValue: DateTime.now(),
      minuteInterval: 30,
      //minHour: 1,
      //maxHour: 23,
      // twoDigitYear: true,
    ),
    title: const Text('時間を選択'),
    cancelText: 'キャンセル',
    confirmText: '確認',
    textAlign: TextAlign.right,
    magnification: 1.1,
    smooth: 200,
    height: 200.h,
    selectedTextStyle: const TextStyle(color: Colors.blue),
    footer: SizedBox(height: 40.h),
    onConfirm: onConfirm,
  ).showModal(context);
}
